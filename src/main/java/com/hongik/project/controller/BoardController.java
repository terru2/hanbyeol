package com.hongik.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hongik.project.serviceImpl.BoardServiceImpl;
import com.hongik.project.vo.BoardVO;


@Controller
public class BoardController {
	@Autowired
	BoardServiceImpl Boardservice;
	
		
	@RequestMapping(value = "return2", method = RequestMethod.GET)
	public @ResponseBody double ajax(@RequestParam(value="name", required=false)String name){
		//System.out.println("*--- board main controller start(return2) ---*");
		//System.out.println(name);		
		double rate = Boardservice.rateBoard(name); //평점		
		return rate; 
	}
		
	@RequestMapping(value="Boardinfo")
	public @ResponseBody ArrayList<BoardVO> boardMain(@RequestParam(value="name", required=false)String name){		
		//System.out.println("*--- board main controller start(Boardinfo) ---*");
		ArrayList<BoardVO> boardlist = Boardservice.getBoard(name);
		//System.out.println(name);
		return boardlist;
	}
	@RequestMapping(value="deleteInfo", method = RequestMethod.POST)
	public @ResponseBody int deleteInfo(
			@RequestParam(value="seq", required=false)double seq){
		//System.out.println("/&-- BoardController Start(delete) --&/\n");
		int success = Boardservice.deleteBoard(seq);
		//System.out.println("성공 여부 : "+success);
		return success;
	}
	
	@RequestMapping(value="informat", method = RequestMethod.POST)
	public @ResponseBody int insertBoard(@RequestParam(value="writer", required=false)String writer,
							@RequestParam(value="comment", required=false)String comments, 
							@RequestParam(value="password2", required=false)String password, 
			@RequestParam(value="gpa", required=false)double gpa,
			@RequestParam(value="name2", required=false)String name2,
			@RequestParam(value="time", required=false)String time) throws IOException{
		//System.out.println("//--- BoardController Start(informat) ---//\n");
		//System.out.println("writer = "+writer+"\ncomment = "+comments+"\npassword = "+password+"\nrate = "+gpa+"\nname = " + name2+"\ntime"+time);
		//System.out.println("********** 저장 성공 **********");
		
		if(writer==""){
			writer = "비회원";
		}

		int success = Boardservice.insertBoard(writer,comments,password,gpa,name2,time);
//		System.out.println("성공 여부 : "+success);
		return success;
	}
}
