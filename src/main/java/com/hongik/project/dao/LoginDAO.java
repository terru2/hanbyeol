package com.hongik.project.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hongik.project.vo.MemberVO;



@Repository
public class LoginDAO {

	@Autowired
	SqlSession session; 

	public MemberVO getLoginCheck(String id, String pw) {
		
		HashMap<String, String> hash = new HashMap<String, String>();
		hash.put("id", id);
		hash.put("pw", pw);
		
		MemberVO vo = session.selectOne("main.member", hash);
		
		return vo;
	}

	public int chkDupId(String paramId) {
		int checkId = session.selectOne("main.checkId" ,paramId);
		return checkId;
	}

	public int chkDupNick(String paramNick) {
		int checkNick = session.selectOne("main.checkNick" ,paramNick);
		return checkNick;
	}

	public void signIn(MemberVO signupVO) {
		
		session.selectOne("main.signin", signupVO);
	
	}

	public void editInfo(MemberVO editVO) {
		
		session.selectOne("main.editInfo", editVO);
		
	}


}
