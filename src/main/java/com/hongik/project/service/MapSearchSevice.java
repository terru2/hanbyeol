package com.hongik.project.service;

import java.util.ArrayList;

import com.hongik.project.vo.UpdatexyVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.PagingVO;

public interface MapSearchSevice {
	
	/* 1. 기본페이지 로드시 기본데이터(cf_table)를 맵에 뿌려주기 위한 메소드  */
	ArrayList<MapDataVO> getAlldate();
	
	ArrayList<MapDataVO> getAlldate2();
	/* 2. 경위도 데이터 없는 경우 geocode를 실행하여 경위도 데이터 추가*/
	void UpdateXY(ArrayList<UpdatexyVO> insertlist); 
	/* 3. 조건을 검색 하였을때의 Data */
	ArrayList<MapDataVO> getSearchData(PagingVO pagingVO);
}
