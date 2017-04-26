package com.hongik.project;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hongik.project.serviceimpl.DataServiceImpl;
import com.hongik.project.vo.DataVO;

@Controller
public class MainController {
	
	@Autowired
	DataServiceImpl service;
	
	@RequestMapping("home.hongik")
	public String home(Model model,  
			@RequestParam(value="b_category", required=false) String b_category,
			@RequestParam(value="m_category", required=false) String select_m_category,
			@RequestParam(value="s_category", required=false) String select_s_category
			)

    {
		List<String> m_category = null;
		List<String> s_category = null;
		List<DataVO> placeList = null;
		
		if(b_category == null){
			m_category = new ArrayList<String>();
			b_category="대분류";
			select_m_category = "중분류";
			select_s_category = "소분류";
		}
		else if(select_m_category==null){
			m_category = service.getCategory(b_category);
			select_m_category = "중분류";
			select_s_category = "소분류";
		}
		else{
			m_category = service.getCategory(b_category);
			s_category = service.getCategory2(b_category, select_m_category);
			
			if(select_s_category == null){
				select_s_category = "소분류";
				placeList = service.getList(b_category, select_m_category, null);
			}
			else{
				placeList = service.getList(b_category, select_m_category, select_s_category);
			}
			
			
		}
		model.addAttribute("b_category", b_category);
		
		model.addAttribute("m_category", m_category);
		model.addAttribute("select_m_category", select_m_category);

		model.addAttribute("s_category", s_category);
		model.addAttribute("select_s_category", select_s_category);
		
		model.addAttribute("placeList",placeList);
		
		return "home";		
	}
	
	@RequestMapping("test.hongik")
	public String test() {
		return "test";		
	}
	
}
