package com.hongik.project.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.CategoryVO;
	
@Controller
public class MainController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;
	
	@RequestMapping(value="main.do")
	public String Test(Model model){	
		ArrayList<CategoryVO> list = mapSearchSeviceImpl.getCategory1();
		model.addAttribute("categorylist", list);
		return "mainpage";
	}
}