package com.hongik.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.CityVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.UpdateVO;

@Repository
public class MapSearchDAO{

	@Autowired
	SqlSession session;
	
	public ArrayList<CityVO> getcity() {
		return (ArrayList)session.selectList("main.getcity");
	}
	
	public ArrayList<CityVO> gettownship(String city) {
		return (ArrayList)session.selectList("main.gettownship", city);
	}

	public ArrayList<CityVO> getFocusXY(String township) {
		return (ArrayList)session.selectList("main.getFocusXY", township);
	}
	public ArrayList<MapDataVO> getAlldate(UpdateVO vo) {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.all", vo);
		return list;
	}
	
	public void UpdateXY(ArrayList<UpdateVO> updatelist) {
		for(UpdateVO vo : updatelist){
			session.update("main.updateXY", vo);
		}
	}
	
	public void UpdateCityTown(ArrayList<UpdateVO> updatelist) {
		for(UpdateVO vo : updatelist){
			session.update("main.updatecitytown", vo);
		}
	}

	public ArrayList<MapDataVO> getAllMapdate() {
		return (ArrayList)session.selectList("main.mapall");
	}
	
	public MapDataVO getOneCulum(String name, String address){
		Map<String, String> para = new HashMap<String, String>();
		para.put("name", name);
		para.put("address", address);
		
		return session.selectOne("main.oneInfo", para);
	}
	public ArrayList<MapDataVO> getSearchMapData(String category1) {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.searchdata", category1);
		return list;
	}

	public ArrayList<CategoryVO> getCategory1() {
		ArrayList<CategoryVO> list = (ArrayList)session.selectList("main.getcategory1");
		return list;
	}

	public void insertTempMapData(MapDataVO vo) {
		session.insert("main.tempinsert", vo);
	}

	public ArrayList<MapDataVO> getTempMapData(String id) {
		return (ArrayList)session.selectList("main.gettempdata", id);
	}

	public void deleteMapData(String name) {
		session.delete("main.deleteMapData", name);
	}

	public void deleteMainMapData(String name) {
		session.delete("main.deleteMainMapData", name);
	}

	public ArrayList<MapDataVO> getTempShareCheckData() {
		return (ArrayList)session.selectList("main.getShareCheckData");
	}
	
	public ArrayList<MapDataVO> getTempSharingData() {
		return (ArrayList)session.selectList("main.getShringData");
	}

	public void updateSharedataOK(MapDataVO vo) {
		session.update("main.updatesharedate", vo);
	}

	public void updateSharedataCancle(MapDataVO vo) {
		session.update("main.updatesharedatecancle", vo);
	}

	public void updateSharedataStatus(MapDataVO vo) {
		session.update("main.updatesharedatestatus", vo);
	}

	public void insertMapTableShareData(MapDataVO vo) {
		session.insert("main.insertsharedate", vo);
	}
}
