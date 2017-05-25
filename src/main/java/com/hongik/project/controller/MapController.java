package com.hongik.project.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hongik.project.commons.ConvertAddressXML;
import com.hongik.project.commons.DistanceConvert;
import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.UpdatexyVO;

@Controller
public class MapController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;

	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@RequestMapping(value="main.do")
	public String getMapData(Model model){	
		ArrayList<CategoryVO> category1list = mapSearchSeviceImpl.getCategory1();
		model.addAttribute("category1list", category1list);
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
	
	@RequestMapping(value="mapsearch.do")
	public String getMapSearchData(Model model,
			@RequestParam(value="address", required=false, defaultValue="null")String address,
			@RequestParam(value="category1", required=false, defaultValue="")String category1){
		ConvertAddressXML convert = new ConvertAddressXML();
		ArrayList<Double>focusXYlist = convert.ConvertAddress(address);
		ArrayList<CategoryVO> category1list = mapSearchSeviceImpl.getCategory1();

		model.addAttribute("address", address);
		model.addAttribute("category1", category1);
		model.addAttribute("focusXYlist", focusXYlist);
		model.addAttribute("category1list", category1list);
		return "map/mapsearch";
	}
	
	@RequestMapping(value="insertplace.do")
	public String insertPlace(Model model,
			@RequestParam(value="address", required=false, defaultValue="null")String address){
		ConvertAddressXML convert = new ConvertAddressXML();
		ArrayList<Double>focusXYlist = convert.ConvertAddress(address);
		model.addAttribute("address", address);
		model.addAttribute("focusXYlist", focusXYlist);
		return "map/insertplace";
	}
	
	
	/* Script로 Map 데이터를 ajax로 뿌려주기 위해 사용되는 메소드들  */
	@RequestMapping(value="allMapdata")
	public @ResponseBody ArrayList<MapDataVO> ajax(){
			ConvertAddressXML convert = new ConvertAddressXML();
			ArrayList<MapDataVO> incompletelist = mapSearchSeviceImpl.getAlldate2();
			for(MapDataVO vo : incompletelist){
				if(vo.getWsg84x() == 1){
					logger.info("변환값 DB INSERT 실행 중 ==========================================");
					ArrayList<UpdatexyVO> insertlist = convert.UpdateXY(vo.getAddress());
					mapSearchSeviceImpl.UpdateXY(insertlist);
				}
			}
			ArrayList<MapDataVO> maplist = mapSearchSeviceImpl.getAlldate2();
		return maplist;
	}
	
	@RequestMapping(value="searchMapdata")
	public @ResponseBody ArrayList<MapDataVO> searchdata(String category1){
		ArrayList<MapDataVO> data = mapSearchSeviceImpl.getSearchMapData(category1);
		return data;
	}
	
	@RequestMapping(value = "rangelimitMapdata")
	public @ResponseBody ArrayList<MapDataVO> searchdata(
			@RequestParam(value = "category1") String category1, @RequestParam(value = "lat") double lat,
			@RequestParam(value = "lng") double lng, @RequestParam(value = "range") double range) {
		ArrayList<MapDataVO> incompletelist = mapSearchSeviceImpl.getSearchMapData(category1);
		ConvertAddressXML convert = new ConvertAddressXML();
		DistanceConvert dis = new DistanceConvert();
		for (MapDataVO vo : incompletelist) {
			if (vo.getWsg84x() == 1) {
				logger.info("변환값 DB Update 실행 중 ==========================================");
				ArrayList<UpdatexyVO> insertlist = convert.UpdateXY(vo.getAddress());
				mapSearchSeviceImpl.UpdateXY(insertlist);
			}
		}
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
}
