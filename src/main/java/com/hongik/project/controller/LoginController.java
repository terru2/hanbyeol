package com.hongik.project.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import com.hongik.project.serviceImpl.LoginServiceImpl;
import com.hongik.project.vo.MemberVO;


@SessionAttributes("log")
@Controller
public class LoginController {
	
	@Autowired
	LoginServiceImpl service;
	
	/*@RequestMapping(value="login" , method =RequestMethod.GET)
	public String test(){
		
		return "redirect:main.do";
	}*/
	
	@RequestMapping(value="login", method = RequestMethod.POST)
	public void Login(
			Model model,
			HttpServletResponse response,
			@RequestParam(value="id", required=false) String id,
			@RequestParam(value="pw", required=false) String pw) throws IOException
	{		
		PrintWriter out = response.getWriter();
		
		MemberVO log = service.getLoginCheck(id, pw);
		
		if(log!=null){
			model.addAttribute("log", log);	
		}else {
			String logfail = "logfail";
			out.print(logfail);
			out.flush();
			out.close();
		}
		
	}
	
//	@RequestMapping("logout")
//	public String Logout(SessionStatus sessionStatus)
//	{		
//		sessionStatus.setComplete();
//		
//		return "redirect:main.do";
//	}
	
	@RequestMapping("logout")
	public String Logout(String url,SessionStatus sessionStatus)
	{		
 		String chkPosition1 = "insertplace.do";
 		String chkPosition2 = "showsharingdata.do";
 		String chkPosition3 = "sharecheck.do";
 		
 		String[] urlsplit = url.split("/");

 		sessionStatus.setComplete();

 		if(url.contains(chkPosition1) || url.contains(chkPosition2) || url.contains(chkPosition3)){
 			return "redirect:main.do";
 		}else{
 			return "redirect:"+urlsplit[2];
 		}		
	}
	
	
	@RequestMapping(value="signin", method = RequestMethod.POST)
	public String Signin(
			@ModelAttribute("signupVO") MemberVO signupVO,
			@ModelAttribute("url") String url)
	{		
		String[] urlsplit = url.split("/");
		service.signIn(signupVO);
		
		return "redirect:" + urlsplit[2];
	}
	
	@RequestMapping("chkDupId")
	public void checkId(
			HttpServletResponse response,
			@RequestParam(value="prmId", required=false) String paramId) throws IOException
	{	
		PrintWriter out = response.getWriter();

		int checkId = service.chkDupId(paramId);
		
		out.print(checkId);
		out.flush();
		out.close();


	}
	
	@RequestMapping("chkDupNick")
	public void checkNick(
			HttpServletResponse response,
			@RequestParam(value="prmNick", required=false) String paramNick) throws IOException
	{	
		
		PrintWriter out = response.getWriter();

		int checkNick = service.chkDupNick(paramNick);
		
		out.print(checkNick);
		out.flush();
		out.close();

	}
	
	@RequestMapping(value="edit", method = RequestMethod.POST)
	public String editInfo(
			@ModelAttribute("editVO") MemberVO editVO,
			@ModelAttribute("log") MemberVO updatelog,
			@ModelAttribute("url") String url)
	{	
		service.editInfo(editVO);
		
		String[] urlsplit = url.split("/");
		
		return "redirect:" + urlsplit[2];
	}
	
}
