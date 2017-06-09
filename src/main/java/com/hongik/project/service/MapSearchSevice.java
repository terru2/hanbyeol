package com.hongik.project.service;

import java.util.ArrayList;

import com.hongik.project.vo.CategoryVO;
import com.hongik.project.vo.MapDataVO;
import com.hongik.project.vo.UpdateVO;

public interface MapSearchSevice {
	
	/* 1. 기본페이지 로드시 기본데이터(cf_table)를 맵에 뿌려주기 위한 메소드  */
	ArrayList<MapDataVO> getAlldate(UpdateVO vo);
	/* 2. 경위도 데이터 없는 경우 geocode를 실행하여 경위도 데이터 추가*/
	void UpdateXY(ArrayList<UpdateVO> insertlist); 
	/* 3. 분류1을 가져오는 메소드 */
	public ArrayList<CategoryVO> getCategory1();
	/* 4. 분류1 선택시 해당하는 데이터 가져오는 메소드*/
	public ArrayList<MapDataVO> getSearchMapData(String category1);
}
