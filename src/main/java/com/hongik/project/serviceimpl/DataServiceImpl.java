package com.hongik.project.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongik.project.dao.DataDAO;
import com.hongik.project.service.DataService;
import com.hongik.project.vo.DataVO;
import com.hongik.project.vo.MemberVO;

@Service
public class DataServiceImpl implements DataService {

	@Autowired
	DataDAO dao;
	
	public ArrayList<DataVO> getAddress() {
		return dao.getAddress();
	}

	public List<String> getCategory(String b_category) {
		return dao.getCategory(b_category);
	}

	public List<String> getCategory2(String b_category, String select_m_category) {
		return dao.getCategory2(b_category,select_m_category);
	}
	
	public List<DataVO> getList(String b_category, String select_m_category, String select_s_category) {
		return dao.getList(b_category,select_m_category,select_s_category);
	}

	public List<MemberVO> getLoginCheck(String id, String pw) {
		return dao.getLoginCheck(id,pw);
	}

}
