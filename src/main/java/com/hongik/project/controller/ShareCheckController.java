package com.hongik.project.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.MapDataVO;

@Controller
public class ShareCheckController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;
	
	@RequestMapping(value="/sharecheck.do")
	public String getTempMapdatalist(Model model){
		return "map/sharecheck";
	}
	
	@RequestMapping(value="/showsharingdata.do")
	public String getTempSharingMapdatalist(Model model){
		return "map/sharingdata";
	}
	
	@RequestMapping(value="/ShareMapData.do")
	public String ShareMapdataOK(MapDataVO vo){
		mapSearchSeviceImpl.updateSharedataOK(vo);
		return "redirect:insertplace.do";
	}
	
	@RequestMapping(value="/ShareCancle.do", method=RequestMethod.POST)
	public @ResponseBody void ShareMapdataCancle(MapDataVO vo){
		mapSearchSeviceImpl.updateSharedataCancle(vo);
	}
	
	@RequestMapping(value="/sharingdata.do")
	public String SharingDataInsert(MapDataVO vo){
		mapSearchSeviceImpl.updateSharedataStatus(vo);		
		mapSearchSeviceImpl.insertMapTableShareData(vo);
		return "redirect:sharecheck.do";
	}
	
	@RequestMapping(value="/getShareData")
	public @ResponseBody ArrayList<MapDataVO> ajaxData(){
		ArrayList<MapDataVO> data = mapSearchSeviceImpl.getTempShareCheckData();
		return data;
	}
	
	@RequestMapping(value="/getSharingData")
	public @ResponseBody ArrayList<MapDataVO> ajaxData2(){
		ArrayList<MapDataVO> data = mapSearchSeviceImpl.getTempSharingData();
		return data;
	}
	
}
