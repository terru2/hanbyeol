package com.hongik.project.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongik.project.dao.DataDAO;
import com.hongik.project.service.DataService;
import com.hongik.project.vo.DataVO;

@Service
public class DataServiceImpl implements DataService {

	@Autowired
	DataDAO dao;
	
	public ArrayList<DataVO> getAddress() {
		return dao.getAddress();
	}

	@Override
	public List<String> getCategory(String b_category) {
		return dao.getCategory(b_category);
	}

	public List<String> getCategory2(String b_category, String select_m_category) {
		return dao.getCategory2(b_category,select_m_category);
	}

}
