package com.hongik.project.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.PagingVO;
import com.hongik.project.vo.UpdatexyVO;

@Repository
public class MapSearchDAO{

	@Autowired
	SqlSession session;
	
	public ArrayList<MapDataVO> getAlldate() {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.all");
		return list;
	}
	
	public ArrayList<MapDataVO> getSearchMapData(String category1) {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.searchdata", category1);
		return list;
	}
	
	public ArrayList<MapDataVO> getpaginglist(PagingVO paging) {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.paginglist", paging);
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

	public ArrayList<MapDataVO> getSearchData(PagingVO paging) {
		ArrayList<MapDataVO> list = (ArrayList)session.selectList("main.getsearchdata", paging);
		return list;
	}

	public int getAllCount() {
		return session.selectOne("main.getallcount");
	}

	public int getcategorylistcount(String category1) {
		return session.selectOne("main.getcategorylistcount", category1);
	}
}
