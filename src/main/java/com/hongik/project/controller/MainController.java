package com.hongik.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping(value="/main.project")
	public String getMainPage(){
		
		return "main";
	}
}
