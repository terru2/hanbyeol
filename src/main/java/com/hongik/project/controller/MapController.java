package com.hongik.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

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
import com.hongik.project.vo.PagingVO;
import com.hongik.project.vo.UpdatexyVO;

@Controller
public class MapController {
	
	@Autowired
	MapSearchSeviceImpl mapSearchSeviceImpl;

	private static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	@RequestMapping(value="main.do")
	public String getMapData(Model model,
			@RequestParam(value="page", defaultValue="1")int page){
		PagingVO paging = new PagingVO();
		ArrayList<CategoryVO> category1list = mapSearchSeviceImpl.getCategory1();

		/* Paging처리를 위한 count*/
		int totalCount = mapSearchSeviceImpl.getAllCount();
		paging.setPageNo(page);
		paging.setTotalCount(totalCount);
		ArrayList<MapDataVO> datalist = mapSearchSeviceImpl.getpaginglist(paging); 

		/* 시설들의 좌표 및 이름  Marker를 등록하는데 필요한 데이터들 */
		model.addAttribute("pageVO", paging);
		model.addAttribute("category1list", category1list);
		model.addAttribute("datalist", datalist);
		
		return "map/default";
	}
	
	@RequestMapping(value="mapsearch.do")
	public String getMapSearchData(Model model,
			@RequestParam(value="address", required=false, defaultValue="null")String address,
			@RequestParam(value="category1", required=false, defaultValue="")String category1,
			@RequestParam(value="page", defaultValue="1")int page){
		ConvertAddressXML convert = new ConvertAddressXML();
		DistanceConvert dis = new DistanceConvert();
		PagingVO paging = new PagingVO();
		paging.setCategory(category1);
		ArrayList<Double>focusXYlist = convert.ConvertAddress(address);
		ArrayList<MapDataVO> test = mapSearchSeviceImpl.getSearchMapData(category1);
		/* distance를 구하는 메소드 */
		for(int i=0; i<test.size(); i++){
			double distance =  Math.round(dis.distance(focusXYlist.get(0), focusXYlist.get(1), test.get(i).getWsg84x(),
					test.get(i).getWsg84y(), "meter"));
			test.get(i).setDistance(distance);
		}
		
		
		int totalCount = test.size();
		paging.setPageNo(page);
		paging.setTotalCount(totalCount);
		
		
		
		ArrayList<CategoryVO> category1list = mapSearchSeviceImpl.getCategory1();
		ArrayList<MapDataVO> searchlist = mapSearchSeviceImpl.getSearchData(paging);

		
		
		model.addAttribute("address", address);
		model.addAttribute("category1", category1);
		model.addAttribute("focusXYlist", focusXYlist);
		model.addAttribute("pageVO", paging);
		model.addAttribute("category1list", category1list);
		model.addAttribute("searchlist", searchlist);
		return "map/mapsearch";
	}
	
	@RequestMapping(value="information.do")
	public String moreInformation(Model model,
			@RequestParam(value="name")String name){
		return "map/information";
	}
	
	@RequestMapping(value="allMapdata")
	public @ResponseBody HashMap<String, ArrayList<MapDataVO>> ajax(){
			HashMap<String, ArrayList<MapDataVO>> data = new HashMap<String, ArrayList<MapDataVO>>();
			ConvertAddressXML convert = new ConvertAddressXML();
			ArrayList<MapDataVO> incompletelist = mapSearchSeviceImpl.getAlldate();
			for(MapDataVO vo : incompletelist){
				if(vo.getWsg84x() == 1){
					logger.info("변환값 DB INSERT 실행 중 ==========================================");
					ArrayList<UpdatexyVO> insertlist = convert.UpdateXY(vo.getAddress());
					mapSearchSeviceImpl.UpdateXY(insertlist);
				}
			}
			ArrayList<MapDataVO> maplist = mapSearchSeviceImpl.getAlldate();
			data.put("positions", maplist);
		return data;
	}
	
	@RequestMapping(value="searchMapdata")
	public @ResponseBody HashMap<String, ArrayList<MapDataVO>> searchdata(String category1){
		HashMap<String, ArrayList<MapDataVO>> data = new HashMap<String, ArrayList<MapDataVO>>();
		data.put("positions", mapSearchSeviceImpl.getSearchMapData(category1));
		return data;
	}
	
}
