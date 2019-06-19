package com.myspring.cpst.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
//import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.cpst.member.MemberVO;

@Repository("memberDAO")
public class MemberDAO {
	@Autowired
	private SqlSession sqlSession;

	public MemberVO login(String email) throws DataAccessException {
		MemberVO vo = sqlSession.selectOne("selectMemberByEmail", email);
		  
		return vo;
	}

	public int insertMember(Map memberMap) {
		int result = 0;
		System.out.println("MB DAO insertMember ");
		System.out.println("memberMap.email : " + memberMap.get("email"));
		System.out.println("memberMap.password : " + memberMap.get("password"));
		
		result = sqlSession.insert("insertMember", memberMap);
		
		return result;
	}

	public MemberVO getMember(int sid) {
		System.out.println("memberdao sid : " + sid);
		
		MemberVO member = sqlSession.selectOne("selectMemberBySid", sid);
		return member;
	}

	public boolean isEmailExists(String email) {
		boolean result = false;
		MemberVO member = sqlSession.selectOne("selectMemberByEmail", email);
		if( member != null) {
			result = true;
		}
		return result;
	}

	public int updateMember(Map<String, Object> memberMap) {
		int result = 0;
		result = sqlSession.update("updateMember", memberMap);
		return result;
	}
	

}
