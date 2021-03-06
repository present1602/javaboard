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
import java.util.UUID;

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

import com.google.gson.Gson;
import com.myspring.cpst.member.MemberDAO;
import com.myspring.cpst.member.MemberVO;



@Controller
@RequestMapping(value = "/board")


public class BoardController {
	private static final String UPLOAD_REPO 
	= "D:/project/eclipsews/spring2/src/main/webapp/resources/upload/post/";
	
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
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request, HttpServletResponse response) throws Exception {

		List postlist = boardDAO.postlist();
		List postlist_best = boardDAO.postlist_best();
		
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("postlist", postlist);
		mav.addObject("postlist_best", postlist_best);
		Gson gson = new Gson();
		System.out.println("gson postlistbest : ");
		System.out.println(gson.toJson(postlist_best));
		
		return mav;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView search(@RequestParam(value="search_text") String searchText) throws Exception {
		System.out.println("/board/search ȣ��");
		System.out.println("searchText : " + searchText);
		List postlist = boardDAO.postlistBySearch(searchText);
		List postlist_best = boardDAO.postlist_best();
		
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("postlist", postlist);
		mav.addObject("postlist_best", postlist_best);
		 
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
		//mav.addObject("commentList, commentList);
		
		List commentList = boardDAO.commentList(postNum);
		mav.addObject("comments", commentList);
		return mav;
	}
	
	@RequestMapping(value = "/write_comment", method = RequestMethod.POST)	
	public @ResponseBody ModelAndView write_comment(
			@RequestParam(value="commentContent") String commentContent, 
			@RequestParam(value="postNum") String postNum, 
			HttpServletRequest request) throws Exception {

		Map<String,Object> commentMap = new HashMap<String, Object>();
		
		commentMap.put("post", postNum);
		commentMap.put("content", commentContent);
		
		int commentNum = getNewCommentNum();
		commentMap.put("commentNum", commentNum);
		
		HttpSession session = request.getSession();
		int writerSid = (Integer) session.getAttribute("memberSid");
		String writerImage = (String) session.getAttribute("memberImage");
		String writerNick = (String) session.getAttribute("memberNick");
	
		commentMap.put("writerSid", writerSid);
		commentMap.put("writerImage", writerImage);
		commentMap.put("writerNick", writerNick);
	
		CommentVO commentVO = boardDAO.addComment(commentMap);
	
		List commentList = boardDAO.commentList((int) Integer.parseInt(postNum));
		
		ModelAndView mav = new ModelAndView("comments");
		mav.addObject("comments", commentList);
		
		return mav;
	}
	
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ResponseEntity write(MultipartHttpServletRequest request, 
			MultipartHttpServletRequest response) throws Exception {
		System.out.println("path : /write  in boardController ");
		String imageFile = null;
		request.setCharacterEncoding("utf-8");
		Map<String,Object> postMap = new HashMap<String, Object>();
		postMap.put("title", request.getParameter("title"));
		postMap.put("content", request.getParameter("content"));
		
		Iterator<String> iterator = request.getFileNames(); 
		MultipartFile multipartFile = null; 
		while(iterator.hasNext()){ 
			multipartFile = request.getFile(iterator.next()); 
			if(multipartFile.isEmpty() == false){ 
					String filename = multipartFile.getOriginalFilename();
					UUID uuid = UUID.randomUUID();
					imageFile = uuid + filename;
					File file = new File(UPLOAD_REPO);
					file = new File(UPLOAD_REPO + imageFile); 
					multipartFile.transferTo(file);
						
			} 
		}

		postMap.put("imageFile", imageFile);
		System.out.println("imageFile : " + imageFile);
		
		HttpSession session = request.getSession();
		String memberSid = (String) session.getAttribute("memberSid").toString();	
		String memberImage = (String) session.getAttribute("memberImage");
		
		postMap.put("writer", Integer.parseInt(memberSid));//		
		MemberVO member = (MemberVO) memberDAO.getMember(Integer.parseInt(memberSid));
		
		postMap.put("writerImage", member.getProfile_image());
		postMap.put("writerNick", member.getNick());
		postMap.put("writerMajor", member.getMajor());

		int result = 0;
		result = boardDAO.insertPost(postMap);		
		System.out.println("BoardCTRL insetPost result : " + result);
		
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		if(result == 1) {
			message = "<script>";
			message += " alert('���� ��ϵǾ����ϴ�');";
			message += " location.href='/board'";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
		
	}
	
	
	@RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String update(
			@RequestParam("post_num") String post_num,
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam("image_upload") MultipartFile file
			) throws Exception {

		Map<String,Object> postMap = new HashMap<String, Object>();
		postMap.put("postNum", Integer.parseInt(post_num));
		postMap.put("title", title);
		postMap.put("content", content);
		
		String img = null;
		if(file != null) {
			img = saveImage(file);
		}
		postMap.put("imageFile", img);

		int result = 0;
		result = boardDAO.updatePost(postMap);
		
		String message = "";
		if(result == 1) {
			message = "�������� �����Ǿ����ϴ�";
		}
		return message;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String delete(@RequestParam(value="postNum") String postNum) throws Exception {
		System.out.println("path : /delete  in boardController ");
		
		int result = 0;
		result = boardDAO.deletePost(Integer.parseInt(postNum));
		
		String message = "";
		if(result == 1) {
			message = "�������� �����Ǿ����ϴ�";
		}
		return message;
		
	}
	

	@RequestMapping(value = "/delete_file", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String delete_file(@RequestParam(value="postNum") String postNum)  {
		String message = "";
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		int result = 0;
		result = sqlSession.update("deleteFile", Integer.parseInt(postNum));
				
		if(result == 1) {
			message = "�̹����� �����Ǿ����ϴ�";
		}
		return message;
		
	}		
	
	
	
	private int getNewCommentNum() throws DataAccessException {
		return sqlSession.selectOne("selectNewCommentNum");
	}

	private String saveImage(MultipartFile file) {
		String imageUrl = null;		
		try {
			String originFilename = file.getOriginalFilename();
			Long size = file.getSize();
			UUID uuid = UUID.randomUUID();
			String saveImageName = uuid + originFilename;

			if(size != 0) {
				writeFile(file, saveImageName);
				imageUrl = saveImageName;	
			}
			
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
		return imageUrl;
	}
	
	private static void writeFile(MultipartFile file, String saveFileName)
			throws IOException{
		byte[] data = file.getBytes();
		FileOutputStream fos = new FileOutputStream(UPLOAD_REPO + saveFileName);
		fos.write(data);
		fos.close();
	}
			
}



