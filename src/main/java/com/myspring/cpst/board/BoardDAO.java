package com.myspring.cpst.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.cpst.member.MemberService;
import com.myspring.cpst.member.MemberVO;
import com.myspring.cpst.board.BoardVO;
//import com.myspring.cpst.member.vo.MemberVO;

//import com.myspring.cpst.board.boardVO;

@Repository("boardDAO")
public class BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BoardVO boardVO;
	
	
//	public MemberVO login(MemberVO memberVO) throws DataAccessException{
//		  MemberVO vo = sqlSession.selectOne("login", memberVO);
//		  System.out.println("in MDAO em : " + vo.getEmail());
//		  System.out.println("pw : " + vo.getPassword());
//		  System.out.println("un : " + vo.getUsername());
//		return vo;
//	}
	

	public BoardVO getPost(int postNum) throws DataAccessException{
		System.out.println("2. boarddao.java getpost - postNum : " + postNum);
		
		BoardVO post = sqlSession.selectOne("selectPost", postNum);
		System.out.println("3. boarddao.java - post.getTitle() : " + post.getTitle());
		return post;
	}
	
	public int insertPost(Map postMap) {
		int result = 0;
		System.out.println("BOARD DAO insertPost ");
		System.out.println("postMap.title : " + postMap.get("title"));
		System.out.println("postMap.content : " + postMap.get("content"));
		
		result = sqlSession.insert("insertPost", postMap);
		return result;
	}

	public List postlist() {
		List<BoardVO> postlist = null;
		postlist = sqlSession.selectList("selectAllPosts");
		return postlist;
	}

	public void addHit(int postNum) {
		sqlSession.update("updateHit", postNum);
	}

	public CommentVO addComment(Map<String, Object> commentMap) {
		int result = 0;
		CommentVO commentVO = null;
		result = sqlSession.insert("insertComment", commentMap);
		
		
//		if(result == 1) {
//			commentVO = sqlSession.selectOne("selectComment", commentMap.get(key));
//		}
		return commentVO;
	}

//	public MemberVO login(@MemberVO memberVO) {
//		memberVO vo = sqlSession.selectOne("mapper.member.loginById",memberVO);
//		return vo;
//	}



}
