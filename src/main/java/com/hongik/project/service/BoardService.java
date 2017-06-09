package com.hongik.project.service;

import java.util.ArrayList;

import com.hongik.project.vo.BoardVO;


public interface BoardService {
	ArrayList<BoardVO> getBoard(String name);	
	double rateBoard(String name);
	int insertBoard(String writer, String comments, String password, double gpa, String name2, String time);
	int deleteBoard(double seq);
}
