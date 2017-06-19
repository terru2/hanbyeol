package com.hongik.project.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.MapDataVO;

@Controller
public class ShareCheckController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;
	
	
	@RequestMapping(value="/ShareMapData.do")
	public String ShareMapdataOK(@RequestParam(value="name")String name){
		mapSearchSeviceImpl.updateSharedataOK(name);
		return "redirect:insertplace.do";
	}
	
/*	@RequestMapping(value="/ShareCancle.do")
	public String ShareMapdataCancle(@RequestParam(value="name")String name){
		mapSearchSeviceImpl.updateSharedataCancle(name);
		return "redirect:insertplace.do";
	}*/
	
	@RequestMapping(value="/ShareCancle.do", method=RequestMethod.POST)
	public @ResponseBody void ShareMapdataCancle(@RequestParam(value="name")String name){
		mapSearchSeviceImpl.updateSharedataCancle(name);
	}
	
	@RequestMapping(value="/sharecheck.do")
	public String getTempMapdatalist(Model model){
		return "map/sharecheck";
	}
	
	@RequestMapping(value="/getShareData")
	public @ResponseBody ArrayList<MapDataVO> ajaxData(){
		ArrayList<MapDataVO> data = mapSearchSeviceImpl.getTempShareCheckData();
		return data;
	}
	
	
}
