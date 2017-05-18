package com.hongik.project.service;

import com.hongik.project.vo.MemberVO;

public interface LoginService {
	
	MemberVO getLoginCheck(String id,String pw);
	
	int chkDupId(String paramId);
	int chkDupNick(String paramNick);
	
	void signIn(MemberVO signupVO);
	void editInfo(MemberVO editVO);
}
