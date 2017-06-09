package com.hongik.project.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.CityVO;
	
@Controller
public class MainController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;
	
	@RequestMapping(value="main.do")
	public String Test(Model model,
			@RequestParam(value="city", required=true, defaultValue="default")String city){	
		ArrayList<CityVO> citylist = mapSearchSeviceImpl.getcity();
		ArrayList<CityVO> townshiplist = mapSearchSeviceImpl.gettownship(city);

		model.addAttribute("city", city);
		model.addAttribute("citylist", citylist);
		model.addAttribute("townshiplist", townshiplist);
		return "mainpage";
	}
}