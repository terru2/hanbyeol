package com.hongik.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.xml.sax.SAXException;

import com.hongik.project.convert.ConvertAddressXML;
import com.hongik.project.serviceimpl.DataServiceImpl;
import com.hongik.project.vo.MemberVO;

@Controller
public class LoginController {
	
	@Autowired
	DataServiceImpl service;
	
	@RequestMapping(value="/test2.hongik", method = RequestMethod.GET)
	public String getAddress(Model model,
			@RequestParam(value="id", required=false) String id,
			@RequestParam(value="pw", required=false) String pw)
	{		
		
		List<MemberVO> log = null;
		
		log = service.getLoginCheck(id, pw);
		
		for(MemberVO data : log){
			System.out.println(data.getId() +":"+ data.getPassword());
		}
		
		return "home";
	}
}
