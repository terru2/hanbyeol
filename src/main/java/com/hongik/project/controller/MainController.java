package com.hongik.project.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hongik.project.serviceimpl.DataServiceImpl;
import com.hongik.project.vo.DataVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Autowired
	DataServiceImpl service;
	
	@RequestMapping("home.hongik")
	public String home(Model model,  
			@RequestParam(value="b_category", required=false) String b_category,
			@RequestParam(value="m_category", required=false) String select_m_category,
			HttpServletRequest request)

    {
		List<String> m_category = null;
		List<String> s_category = null;
		
		if(b_category == null){
			m_category = new ArrayList<String>();
			b_category="대분류";
		}
		else if(select_m_category==null){
			m_category = service.getCategory(b_category);
		}
		else{
			s_category = service.getCategory2(b_category, select_m_category);
		}
		
		model.addAttribute("b_category", b_category);
		model.addAttribute("m_category", m_category);

		model.addAttribute("s_category", s_category);
		
		return "home";		
	}
	
	@RequestMapping("test.hongik")
	public String test() {
		return "test";		
	}
	
}
