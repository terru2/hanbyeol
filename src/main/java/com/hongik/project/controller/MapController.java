package com.hongik.project.controller;

import java.io.IOException;
import java.util.ArrayList;

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

@Controller
public class MapController {
	
	@Autowired
	DataServiceImpl service;
	
	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@RequestMapping(value="/search.hongik", method = RequestMethod.GET)
	public String getAddress(Model model,
			@RequestParam(value="address", required=false)String address){
		logger.info("================= 주소를 좌표로 변환하는 메소드 구현 ===================");
		ArrayList<Double> list = new ArrayList<Double>();
		double lat = 0;
		double lng = 0;
		
		ConvertAddressXML convert = new ConvertAddressXML();
		try {
			list = convert.ConvertAddress(address);
			lat = list.get(0);
			lng = list.get(1);
		} catch (ParserConfigurationException | IOException | SAXException e) {
			e.printStackTrace();
		}
		model.addAttribute("address", address);
		model.addAttribute("lat", lat);
		model.addAttribute("lng", lng);
		
		return "map/search";
	}
}
