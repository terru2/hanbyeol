package com.hongik.project.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongik.project.dao.LoginDAO;
import com.hongik.project.service.LoginService;
import com.hongik.project.vo.MemberVO;



@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	LoginDAO dao;

	public MemberVO getLoginCheck(String id, String pw) {
		return dao.getLoginCheck(id,pw);
	}

	public int chkDupId(String paramId) {
		return dao.chkDupId(paramId);
	}

	public int chkDupNick(String paramNick) {
		return dao.chkDupNick(paramNick);
	}

	public void signIn(MemberVO signupVO) {
		dao.signIn(signupVO);
	}

	public void editInfo(MemberVO editVO) {
		dao.editInfo(editVO);
	}



}
