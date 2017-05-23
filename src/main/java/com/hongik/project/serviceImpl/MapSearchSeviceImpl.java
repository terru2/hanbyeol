package com.hongik.project.serviceImpl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hongik.project.dao.MapSearchDAO;
import com.hongik.project.service.MapSearchSevice;
import com.hongik.project.vo.UpdatexyVO;
import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.PagingVO;

@Service
public class MapSearchSeviceImpl implements MapSearchSevice {

	@Autowired
	MapSearchDAO dao;
	
	public ArrayList<MapDataVO> getAlldate() {
		return dao.getAlldate();
	}

	public ArrayList<MapDataVO> getAlldate2() {
		return dao.getAlldate2();
	}

	public void UpdateXY(ArrayList<UpdatexyVO> insertlist) {
		dao.UpdateXY(insertlist);
	}

	public ArrayList<CategoryVO> getCategory1() {
		return dao.getCategory1();
	}

	public ArrayList<MapDataVO> getSearchData(PagingVO paging) {
		return dao.getSearchData(paging);
	}

	public int getAllCount() {
		return dao.getAllCount();
	}

	public ArrayList<MapDataVO> getpaginglist(PagingVO paging) {
		return dao.getpaginglist(paging);
	}

	public int getcategorylistcount(String category1) {
		return dao.getcategorylistcount(category1);
	}

	public ArrayList<MapDataVO> getSearchMapData(String category1) {
		return dao.getSearchMapData(category1);
	}

	
}
