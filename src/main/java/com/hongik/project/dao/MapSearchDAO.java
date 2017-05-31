package com.hongik.project.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.UpdatexyVO;

@Repository
public class MapSearchDAO{

	@Autowired
	SqlSession session;
	
	public ArrayList<MapDataVO> getAlldate2() {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.all2");
		return list;
	}

	public ArrayList<MapDataVO> getSearchMapData(String category1) {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.searchdata", category1);
		return list;
	}

	public void UpdateXY(ArrayList<UpdatexyVO> insertlist) {
		for(UpdatexyVO vo : insertlist){
			session.insert("main.updateXY", vo);
		}
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
}
