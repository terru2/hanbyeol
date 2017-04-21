package com.hongik.project.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hongik.project.serviceimpl.DataServiceImpl;
import com.hongik.project.vo.DataVO;

@Controller
public class MapController {
	
	@Autowired
	DataServiceImpl service;
	
	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@RequestMapping(value="/map.test", method = RequestMethod.GET)
	public String getAddress(Model model){
		logger.info("Test 중입니다.");
		ArrayList<DataVO> list = service.getAddress();
		
		ArrayList<String> name = new ArrayList<String>();
		ArrayList<String> address = new ArrayList<String>();
		ArrayList<Double> wsg84x = new ArrayList<Double>();
		ArrayList<Double> wsg84y = new ArrayList<Double>();
		
		for(DataVO vo : list){
			name.add(vo.getName());
			address.add(vo.getAddress());
			wsg84x.add(vo.getWsg84x());
			wsg84y.add(vo.getWsg84y());
		}
		model.addAttribute("wsg84x", wsg84x);
		model.addAttribute("wsg84y", wsg84y);
		model.addAttribute("name", name);
		model.addAttribute("address", address);
		
		return "map";
	}
}
