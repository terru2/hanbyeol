package com.hongik.project.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hongik.project.commons.ConvertAddressXML;
import com.hongik.project.commons.DistanceConvert;
import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.UpdateVO;

@Controller
public class MapController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;

	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@RequestMapping(value="search.do")
	public String getMapData(Model model,
			@RequestParam(value="focusAddress", required=false, defaultValue="")String address,
			@RequestParam(value="category1", required=false, defaultValue="도시공원")String category1){
		ConvertAddressXML convert = new ConvertAddressXML();
		ArrayList<Double> focuslist = convert.ConvertAddress(address);
		ArrayList<CategoryVO> categorylist = mapSearchSeviceImpl.getCategory1();
		
		model.addAttribute("category1", category1);
		model.addAttribute("categorylist", categorylist);
		model.addAttribute("focusAddress", address);
		model.addAttribute("focuslist", focuslist);
		return "map/mainpage";
	}
	
	@RequestMapping(value = "rangesearch.do")
	public String moreInformation(Model model, @RequestParam(value = "category1", required = false) String category,
			@RequestParam(value = "range", required = false, defaultValue = "500") double range) {
		model.addAttribute("category1", category);
		model.addAttribute("range", range);
		model.addAttribute("categorylist", mapSearchSeviceImpl.getCategory1());
		return "map/rangesearch";
	}
	
	/* Script로 Map 데이터를 ajax로 뿌려주기 위해 사용되는 메소드들  */
	@RequestMapping(value="allMapdata")
	public @ResponseBody ArrayList<MapDataVO> ajax(UpdateVO vo){
			ConvertAddressXML convert = new ConvertAddressXML();
			ArrayList<MapDataVO> incompletelist = mapSearchSeviceImpl.getAllMapdate();
			for(MapDataVO mapvo : incompletelist){
				if(mapvo.getWsg84x() == 1){
					logger.info("======================= Address To coord 실행 중 =======================");
					ArrayList<UpdateVO> updatelist = convert.UpdateXY(mapvo.getAddress());
					mapSearchSeviceImpl.UpdateXY(updatelist);
				}else if(mapvo.getCity() == null){
					logger.info("======================= Coord To Address 실행 중 =======================");
					ArrayList<UpdateVO> updatelist = convert.Updatecoord2addr(mapvo.getWsg84x(), mapvo.getWsg84y());
					mapSearchSeviceImpl.UpdateCityTown(updatelist);
				}
			}
			logger.info("======================= Data 불러오기 완료  =======================");
			ArrayList<MapDataVO> maplist = mapSearchSeviceImpl.getAlldate(vo);
		return maplist;
	}
	
	@RequestMapping(value="insertplace.do")
	public String insertPlace(Model model,
			@RequestParam(value="focusAddress", required=false, defaultValue="null")String focusAddress){
		ConvertAddressXML convert = new ConvertAddressXML();
		ArrayList<Double>focusXYlist = convert.ConvertAddress(focusAddress);
		ArrayList<CategoryVO> category1list = mapSearchSeviceImpl.getCategory1();
		
		model.addAttribute("focusAddress", focusAddress);
		model.addAttribute("focusXYlist", focusXYlist);
		model.addAttribute("category1list", category1list);
		return "map/insertplace";
	}
	
	@RequestMapping(value="insertplace.do", method=RequestMethod.POST)
	public String insertPlacePost(MapDataVO vo,
			@RequestParam(value="lat")String wsg84x,
			@RequestParam(value="lng")String wsg84y){
		vo.setWsg84x(Double.parseDouble(wsg84x));
		vo.setWsg84y(Double.parseDouble(wsg84y));

		mapSearchSeviceImpl.insertTempMapData(vo);
		return "redirect:insertplace.do";
	}
	
	@RequestMapping(value="focusinsertplace.do")
	public String FocusinsertPlace(){
		return "map/focusinsertplace";
	}
	
	/*@RequestMapping(value="DeleteMapData.do")
	public String DeleteMapData(@RequestParam(value="name", required=true)String name){
		mapSearchSeviceImpl.deleteMapData(name);
		return "redirect:insertplace.do";
	}*/
	
	@RequestMapping(value="DeleteMapData.do", method=RequestMethod.POST)
	public @ResponseBody void DeleteMapData(@RequestParam(value="name", required=true)String name){
		mapSearchSeviceImpl.deleteMapData(name);
	}
	
	@RequestMapping(value="DeleteMainMapData.do")
	public String DeleteMainMapData(@RequestParam(value="name", required=true)String name){
		mapSearchSeviceImpl.deleteMainMapData(name);
		return "redirect:main.do";
	}
	
	@RequestMapping(value = "rangelimitMapdata")
	public @ResponseBody ArrayList<MapDataVO> searchdata(
			@RequestParam(value = "category1") String category1, @RequestParam(value = "lat") double lat,
			@RequestParam(value = "lng") double lng, @RequestParam(value = "range") double range) {
		DistanceConvert dis = new DistanceConvert();
		ArrayList<MapDataVO> list = mapSearchSeviceImpl.getSearchMapData(category1);
		ArrayList<MapDataVO> data = new ArrayList<MapDataVO>();
		for (MapDataVO vo : list) {
			double distance = Math.round(dis.distance(lat, lng, vo.getWsg84x(), vo.getWsg84y(), "meter"));
			if (range > distance) {
				vo.setDistance(distance);
				data.add(vo);
			}
		}
		return data;
	}
	
	@RequestMapping(value="idcheckMapdata")
	public @ResponseBody ArrayList<MapDataVO> searchDataID(String id){
		ArrayList<MapDataVO> data = mapSearchSeviceImpl.getTempMapData(id);
		return data;
	}
	
	
	@RequestMapping(value="OneCulum")
	public @ResponseBody MapDataVO getculum(@RequestParam(value="name", required=false)String name,
			@RequestParam(value="address", required=false)String address){
		MapDataVO OneCulum = mapSearchSeviceImpl.getOneCulum(name,address);
		return OneCulum;
	}
}
