package com.myspring.cpst.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
//import java.net.http.HttpRequest;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.ibatis.session.SqlSession;
//import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myspring.cpst.member.MemberDAO;
import com.myspring.cpst.member.MemberService;
import com.myspring.cpst.member.MemberVO;



@Controller
@RequestMapping(value = "/board")


public class BoardController {
	private static final String UPLOAD_REPO = "D:/project/eclipsews/spring2/src/main/webapp/resources/upload/post";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	MemberVO memberVO ;
	
	@Autowired
	BoardVO boardVO ;
	
	
//	@RequestMapping(value = "", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		System.out.println("path : /  in boardController ");
//		
//		return "main";
//	}
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List postlist = boardDAO.postlist();
		
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("postlist", postlist);
		return mav;
	}
	
	@RequestMapping("/{postNum}")
	public ModelAndView post(@PathVariable int postNum) throws Exception {
		System.out.println(" 1. postnum pathv ");
		boardDAO.addHit(postNum);
		BoardVO postVO = boardDAO.getPost(postNum);
		System.out.println("4. Boardcontroller post-getTitle : " +  postVO.getTitle());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("post_layer");
		mav.addObject("post", postVO);
		return mav;
	}
	
	@RequestMapping("/{postNum}/write_comment")
	public CommentVO write_comment(@PathVariable int postNum, @RequestBody String  commentData, HttpServletRequest request) throws Exception {
		System.out.println("1. write_comment pathv ");
		System.out.println("2. postNum : " + postNum);
		System.out.println("3. commentData : " + commentData);
		
		Map<String,Object> commentMap = new HashMap<String, Object>();
		
		commentMap.put("post", postNum);
		commentMap.put("content", commentData);
		int commentNum = getNewCommentNum();
		commentMap.put("commentNum", commentNum);
		
		HttpSession session = request.getSession();
		int writerSid = (Integer) session.getAttribute("memberSid");
		String writerImage = (String) session.getAttribute("memberImage");
		String writerNick = (String) session.getAttribute("memberNick");
		
		System.out.println("4. memberSid : " + writerSid);
		System.out.println("4. memberImage : " + writerImage);
		System.out.println("4. memberNick : " + writerNick);
		
		commentMap.put("writerSid", writerSid);
		commentMap.put("writerImage", writerImage);
		commentMap.put("writerNick", writerNick);
		
		System.exit(0);
		
		CommentVO commentVO = boardDAO.addComment(commentMap);
		
		
		
		return commentVO;
	}
	

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ResponseEntity write(MultipartHttpServletRequest multipartRequest, 
			HttpServletResponse response) throws Exception {
		System.out.println("path : /write  in boardController ");
		
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String,Object> postMap = new HashMap<String, Object>();
		Enumeration enu=multipartRequest.getParameterNames();
		while(enu.hasMoreElements()){
			String name=(String)enu.nextElement();
			String value=multipartRequest.getParameter(name);
			postMap.put(name,value);
			System.out.println("BCTR name : " + name + ", value : " + value);
		}
		
		String imageFileName= saveImage(multipartRequest);
		System.out.println("imageFileName : " + imageFileName);
		
		HttpSession session = multipartRequest.getSession();
//		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		
		String memberSid = (String) session.getAttribute("memberSid").toString();
		
		String memberImage = (String) session.getAttribute("memberImage");
		
		System.out.println("memberSid : " + memberSid);
		System.out.println("memberImage : " + memberImage);
		
		postMap.put("imageFile", imageFileName);
		postMap.put("writer", Integer.parseInt(memberSid));
//		postMap.put("writer", memberSid);
		
		System.out.println("writer class : " + postMap.get("writer").getClass()); 
		
		System.out.println("memberSid : " + memberSid);
		System.out.println("postmap get writer - : " + postMap.get("writer") );
		
//		System.exit(3);
		
		
		MemberVO member = (MemberVO) memberDAO.getMember(Integer.parseInt(memberSid));
		
		
		postMap.put("writerImage", member.getProfile_image());
		postMap.put("writerNick", member.getNick());
		postMap.put("writerMajor", member.getMajor());
		
		System.out.println("postmap writer img get : " + member.getProfile_image());
		System.out.println("postmap writer nick get : " + member.getNick());
		System.out.println("postmap writer major get : " + member.getMajor());
		
//		System.out.println("boardcontroller print all map key value");
//		for (String name: postMap.keySet()){
//            String key = name.toString();
//            String value = postMap.get(name).toString();  
//            System.out.println(key + " " + value);  
//		} 
		
		int result = 0;
		result = boardDAO.insertPost(postMap);
		
		System.out.println("BoardCTRL insetPost result : " + result);
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		if(result == 1) {
			message = "<script>";
			message += " alert('글이 등록되었습니다');";
			message += " location.href='/board'";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
		
	}
	
		
	
	public static String saveImage(MultipartHttpServletRequest multipartRequest) throws IllegalStateException, IOException {
		String imageFileName= null;
		Iterator<String> fileNames = multipartRequest.getFileNames();
		
		while(fileNames.hasNext()){
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName=mFile.getOriginalFilename();
			File file = new File(fileName);
			mFile.transferTo(new File(UPLOAD_REPO +"\\"+imageFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
			
//			if(mFile.getSize()!=0){ //File Null Check
//				if(! file.exists()){ //경로상에 파일이 존재하지 않을 경우
//					if(file.getParentFile().mkdirs()){ //경로에 해당하는 디렉토리들을 생성
//							file.createNewFile(); //이후 파일 생성
//					}
//				}
//				mFile.transferTo(new File(UPLOAD_REPO +"\\"+imageFileName)); //임시로 저장된 multipartFile을 실제 파일로 전송
//			}
		}
		return imageFileName;
	}

	private int getNewCommentNum() throws DataAccessException {
		return sqlSession.selectOne("selectNewCommentNum");
	}
	
}
