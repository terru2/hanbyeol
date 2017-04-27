package com.hongik.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hongik.project.vo.DataVO;
import com.hongik.project.vo.MemberVO;

@Repository
public class DataDAO {

	@Autowired
	SqlSession session; 
	
	public ArrayList<DataVO> getAddress() {
		return (ArrayList)session.selectList("test.all");
	}
	
	public List<String> getCategory(String b_category) {
		String table = "";
		
		if(b_category.equals("문화시설")){
			table = "CF_TABLE";
		}
		else if(b_category.equals("의료시설")){
			table = "EF_TABLE";
		}
		else if(b_category.equals("체육시설")){
			table = "GF_TABLE";
		}
		else if(b_category.equals("복지시설")){
			table = "WF_TABLE";
		}
		else if(b_category.equals("기타시설")){
			table = "OF_TABLE";
		}
		
		List<String> list = session.selectList("test.table", table);
		
		return list;
	}

	public List<String> getCategory2(String b_category, String select_m_category) {
		
		String table = "";
		
		if(b_category.equals("문화시설")){
			table = "CF_TABLE";
		}
		else if(b_category.equals("의료시설")){
			table = "EF_TABLE";
		}
		else if(b_category.equals("체육시설")){
			table = "GF_TABLE";
		}
		else if(b_category.equals("복지시설")){
			table = "WF_TABLE";
		}
		else if(b_category.equals("기타시설")){
			table = "OF_TABLE";
		}
	
		HashMap<String, String> hash = new HashMap<String, String>();
		hash.put("table", table);
		hash.put("m_category", select_m_category);
		
		List<String> list = session.selectList("test.table2", hash);
		
		return list;
	}

	public List<DataVO> getList(String b_category, String select_m_category, String select_s_category) {
		
		String table = "";
		
		if(b_category.equals("문화시설")){
			table = "CF_TABLE";
		}
		else if(b_category.equals("의료시설")){
			table = "EF_TABLE";
		}
		else if(b_category.equals("체육시설")){
			table = "GF_TABLE";
		}
		else if(b_category.equals("복지시설")){
			table = "WF_TABLE";
		}
		else if(b_category.equals("기타시설")){
			table = "OF_TABLE";
		}
		
		HashMap<String, String> hash = new HashMap<String, String>();
		hash.put("table", table);
		hash.put("m_category", select_m_category);
		hash.put("s_category", select_s_category);
		
		List<DataVO> list = session.selectList("test.table3", hash);
		
		return list;
	}

	public List<MemberVO> getLoginCheck(String id, String pw) {
		
		HashMap<String, String> hash = new HashMap<String, String>();
		hash.put("id", id);
		hash.put("pw", pw);
		
		List<MemberVO> list = session.selectList("test.member", hash);
		
		return list;
	}

}
