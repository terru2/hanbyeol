package com.hongik.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.hongik.project.vo.BoardVO;

@Repository
public class BoardDAO {
	
	@Autowired
	SqlSession session;
	
	public double seq;
	public double rateBoard(String name){
//		System.out.println("/////DAO 시작 /////\n");
		try{
			double rate = session.selectOne("main.rate", name);
			return rate;
		}catch(Exception e){}
		return 0.0;
	}	
	
	public ArrayList<BoardVO> getBoard(String name){
		ArrayList<BoardVO> bvo = (ArrayList)session.selectList("main.checkBoard", name);
		return bvo;
	}
	
	public int insertBoard(String writer, String comments, String password, double gpa, String name2, String time) {		
//		System.out.println("/////DAO 시작 /////\n");
		seq++;
		Map<String, Object> tmp = new HashMap<String, Object>();
		tmp.put("seq", seq);
		tmp.put("writer", writer);
		tmp.put("comments", comments);
		tmp.put("password", password);
		tmp.put("gpa", gpa);
		tmp.put("name", name2);
		tmp.put("time", time);
		//System.out.println("번호 : " + tmp.get("seq")+"\n작성자 : "+tmp.get("writer")+"\n후기 : "+tmp.get("comments")+"\n글비번 : "+tmp.get("password")+"\n별점 : "+tmp.get("gpa")+"\n이름 : "+name2+"\n시간 : "+time);		
		int abc = session.insert("main.insertBoard", tmp);
		
		return abc;
	}
	
	public int deleteBoard(double seq){
//		System.out.println("/////DAO 시작/////");
		/*Map<String, Object> where = new HashMap<String, Object>();
		where.put("seq", seq);
		where.put("password", password);
		where.put("name", name2);*/
		
//		System.out.println("글비번 : "+where.get("password")+"\n시설이름 : "+where.get("name")+"\n시간 : "+where.get("time"));
		int returnNum = session.delete("main.deleteBoard", seq);
//		System.out.println("삭제성공");
		return returnNum;
	}
}
