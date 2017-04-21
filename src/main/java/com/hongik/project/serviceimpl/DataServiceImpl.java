package com.hongik.project.serviceimpl;

import java.util.ArrayList;

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

}
