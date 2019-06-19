package com.myspring.cpst.member;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.myspring.cpst.member.MemberVO;


@Controller
@RequestMapping(value = "/member")


public class MemberController {
//	private static final Logger logger = LoggerFactory.getLogger(MemberControllerImpl.class);
	private static final String UPLOAD_REPO 
	= "D:/project/eclipsews/spring2/src/main/webapp/resources/upload/profile/";
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	MemberVO memberVO ;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup_view(Model model) {
		System.out.println("member signup view");
        
		return "signup";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update_view(Model model, HttpServletRequest request) {
		System.out.println("member signup view");
		HttpSession session = request.getSession();
		int sid = (int) session.getAttribute("memberSid");
		MemberVO vo = sqlSession.selectOne("selectMemberBySid", sid);
		model.addAttribute("vo", vo);
		return "member_update";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login_view(Model model) {
		System.out.println("member login view");
		return "login";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("memberSid");
		session.removeAttribute("memberImage");
		session.removeAttribute("memberNick");
		
		return "redirect:/board";
	
	}

			
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {

		String email = request.getParameter("email");
		String password = request.getParameter("password");
		 
		MemberVO vo = memberDAO.login(email);
		
		ModelAndView mav = new ModelAndView("main");
		Boolean authUser = false;
		if(vo != null) {
			boolean passMatch = passwordEncoder.matches(password, vo.getPassword());
			if(passMatch == true) {
				authUser = true;
				HttpSession session = request.getSession();
				
				session.setAttribute("memberSid", vo.getSid());
				session.setAttribute("memberImage", vo.getProfile_image());
				session.setAttribute("memberNick", vo.getNick());
				
				mav.setViewName("redirect:/board");
			}
		}
		mav.setViewName("login");
		mav.addObject("msg", "계정 정보가 일치하지 않습니다");
		return mav;
	}
		
//	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public ModelAndView login(@ModelAttribute("member") MemberVO member,
//            RedirectAttributes rAttr,
//             HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
//		memberVO = memberDAO.login(member);
//
//		System.out.println("login - memberVO : " + memberVO);
//		
//		ModelAndView mav = new ModelAndView("main");
//		if(memberVO != null) {
//			HttpSession session = request.getSession();
//			
//			session.setAttribute("memberSid", memberVO.getSid());
//			session.setAttribute("memberImage", memberVO.getProfile_image());
//			session.setAttribute("memberNick", memberVO.getNick());
//			
//			mav.setViewName("redirect:/board");
//		}
//		
//		return mav;
//	}
	
	@RequestMapping(value="/emailCheck", produces = "application/text; charset=utf8")
	@ResponseBody
	public String checkEmail(@RequestParam("text") String email) {
		System.out.println("checkEmail ");
		System.out.println("email : " + email);
		String msg = "";
		boolean checkEmail = memberDAO.isEmailExists(email);
		if(checkEmail == true) {
			System.out.println("chk em true");
			msg = "email exists";
		}else {
			System.out.println("chk em false");
		}
		return msg;
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity signup(Model model,
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("nick") String nick,
			@RequestParam("username") String username,
			@RequestParam("phone") String phone,
			@RequestParam("univ") String univ,
			@RequestParam("major") String major,
			@RequestParam("profile_image") MultipartFile file
			) {
		System.out.println("/signup post");
		
		String imgUrl = saveImage(file);
		
		System.out.println("imgUrl : " + imgUrl);
		Map<String,Object> memberMap = new HashMap<String, Object>();
		
		String encryptPassword = passwordEncoder.encode(password);
		System.out.println("encryptPassword : " + encryptPassword);

		memberMap.put("email", email);
		memberMap.put("password", encryptPassword);
		memberMap.put("nick", nick);
		memberMap.put("username", username);
		memberMap.put("phone", phone);
		memberMap.put("univ", univ);
		memberMap.put("major", major);
		memberMap.put("profile_image", imgUrl);
		
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		int result = memberDAO.insertMember(memberMap);
		System.out.println("in mbctroller result : " + result);
		
		if(result == 1) {
			message = "<script>";
			message += " alert('회占쏙옙占쏙옙占쏙옙占쏙옙 占싹뤄옙퓸占쏙옙占쏙옙求占�.');";
			message += " location.href='login'";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		
		return resEnt;

	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	
	public ResponseEntity update(Model model, HttpServletRequest request, 
			@RequestParam("sid") String sid,
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("nick") String nick,
			@RequestParam("username") String username,
			@RequestParam("phone") String phone,
			@RequestParam("univ") String univ,
			@RequestParam("major") String major,
			@RequestParam("profile_image") MultipartFile file
			) {
		System.out.println("/signup post");
		String imgUrl = null;
		String originFilename = file.getOriginalFilename();
		Long size = file.getSize();
		if(file!=null && size != 0) {
			imgUrl = saveImage(file);
		}
		System.out.println("imgUrl : " + imgUrl);
		Map<String,Object> memberMap = new HashMap<String, Object>();
		
		String encryptPassword = passwordEncoder.encode(password);
		System.out.println("encryptPassword : " + encryptPassword);

		memberMap.put("sid", sid);
		memberMap.put("email", email);
		memberMap.put("password", encryptPassword);
		memberMap.put("nick", nick);
		memberMap.put("username", username);
		memberMap.put("phone", phone);
		memberMap.put("univ", univ);
		memberMap.put("major", major);
		memberMap.put("profile_image", imgUrl);
		
		String message;
		ResponseEntity resEnt=null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		int result = memberDAO.updateMember(memberMap);
		System.out.println("in mbctroller result : " + result);
		
		if(result == 1) {
			MemberVO vo = sqlSession.selectOne("selectMemberBySid", memberMap);
			HttpSession session = request.getSession();
			session.setAttribute("memberImage", vo.getProfile_image());
			session.setAttribute("memberNick", vo.getNick());
			message = "<script>";
			message += " alert('회占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占실억옙占쏙옙占싹댐옙.');";
			message += " location.href='/board'";
			message +=" </script>";
		    resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		
		return resEnt;

	}
	

	public static String saveImage(MultipartFile file) {
		String imageUrl = "profile_default2.jpg";
		try {
			String originFilename = file.getOriginalFilename();
			Long size = file.getSize();
			System.out.println("originFilename : " + originFilename);
			UUID uuid = UUID.randomUUID();
			String saveImageName = uuid + originFilename;
			System.out.println("size : " + size);
			if(size != 0) {
				
				writeFile(file, saveImageName);
				imageUrl = saveImageName;	
			}
			
		}catch (Exception e) {
			// 占쏙옙占쏙옙占쏙옙占� RuntimeException 占쏙옙 占쏙옙達占쏙옙占� 占쏙옙占쌤곤옙 처占쏙옙占실억옙占� 占쏙옙占쏙옙占쏙옙
			// 占쏙옙占실삼옙 RuntimeException占쏙옙 占쏙옙占쏙옙占쏙옙.
			// throw new FileUploadException();	
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
