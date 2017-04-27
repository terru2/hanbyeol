package com.hongik.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.hongik.project.vo.DataVO;
import com.hongik.project.vo.MemberVO;

public interface DataService {

	ArrayList<DataVO> getAddress();
	
	List<String> getCategory(String b_category);
	List<String> getCategory2(String b_category, String m_category);
	
	List<DataVO> getList(String b_category,String select_m_category, String select_s_category);
	
	List<MemberVO> getLoginCheck(String id,String pw);
	
}
