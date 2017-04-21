package com.hongik.project.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hongik.project.vo.DataVO;

@Repository
public class DataDAO {

	@Autowired
	SqlSession session; 
	
	public ArrayList<DataVO> getAddress() {
		return (ArrayList)session.selectList("test.all");
	}
}
