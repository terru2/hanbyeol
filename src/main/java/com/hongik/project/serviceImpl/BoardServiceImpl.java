package com.hongik.project.serviceImpl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongik.project.dao.BoardDAO;

import com.hongik.project.service.BoardService;
import com.hongik.project.vo.*;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	BoardDAO dao;
		
	@Override
	public double rateBoard(String name){
		return dao.rateBoard(name);
	}
	
	@Override
	public ArrayList<BoardVO> getBoard(String name){		
		return dao.getBoard(name);
	}

	@Override
	public	int insertBoard(String writer, String comments, String password, double gpa, String name2, String time) {
		return dao.insertBoard(writer, comments, password, gpa,name2,time);
	}
	@Override
	public int deleteBoard(double seq){
		return dao.deleteBoard(seq);
	}
}
