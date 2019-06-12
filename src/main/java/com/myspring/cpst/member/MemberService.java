package com.myspring.cpst.member;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


@Service("memberService")
public class MemberService {
	
//	private static final String UPLOAD_REPO = "D:\\project\\eclipsews\\spring2\\src\\main\\webapp\\resources\\upload";
	private static final String UPLOAD_REPO = "D:/project/eclipsews/spring2/src/main/webapp/resources/upload";
	
	@Autowired
	private MemberDAO memberDAO;

	public static String saveImage(MultipartFile file) {
		String imageUrl = "profile_default2.jpg";
		try {
			String originFilename = file.getOriginalFilename();
			Long size = file.getSize();
			System.out.println("originFilename : " + originFilename);
			System.out.println("size : " + size);
			if(size != 0) {
				
				writeFile(file, originFilename);
				imageUrl = originFilename;	
			}
			
		}catch (Exception e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();	
			throw new RuntimeException(e);
		}
		return imageUrl;
	}

	private static void writeFile(MultipartFile file, String saveFileName)
					throws IOException{
		
		
		byte[] data = file.getBytes();
		FileOutputStream fos = new FileOutputStream(UPLOAD_REPO + "/" + saveFileName);
		fos.write(data);
		fos.close();
		
	}

	public void addMember(Map<String, Object> memberMap) {
		System.out.println("MB service addMember ");
		System.out.println("memberMap.email : " + memberMap.get("email"));
		System.out.println("memberMap.password : " + memberMap.get("password"));
		
		int result = memberDAO.insertMember(memberMap);
		System.out.println("result : " + result);
	}

	
//	public List listMembers() throws DataAccessException {
//		List membersList = null;
//		membersList = memberDAO.selectAllMemberList();
//		return membersList;
//	}
//
//	
//	public int addMember(MemberVO member) throws DataAccessException {
//		return memberDAO.insertMember(member);
//	}
//
//	
//	public int removeMember(String id) throws DataAccessException {
//		return memberDAO.deleteMember(id);
//	}
//	
//	
//	public MemberVO login(MemberVO memberVO) throws Exception{
//		return memberDAO.loginById(memberVO);
//	}

}
