package com.hongik.project.commons;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.hongik.project.serviceImpl.MapSearchSeviceImpl;
import com.hongik.project.vo.UpdateVO;

public class ConvertAddressXML {
	private static final Logger logger = LoggerFactory.getLogger(ConvertAddressXML.class);
	MapSearchSeviceImpl service = new MapSearchSeviceImpl();
	
	public ArrayList<Double> ConvertAddress(String address){
		ArrayList<Double> result = new ArrayList<Double>();
		if(address.equals(" ")){
			result.add((double) 37.566696);
			result.add((double) 126.977942);
		}
//		1. 한글은 URL에서 인식을 하지 못하기 때문에 한글을 UTF-8 형식으로 변환 시킴.
		String convertaddress = null;
		try {
			convertaddress = URLEncoder.encode(address, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("===== 주소값 NULL 또는 변환 실패 =====");
			e.printStackTrace();
		}
//		2. 주소를 utf-8 형식으로 변환 후 구글맵 api 를 이용하여 xml 형식으로 데이터를 받은 후 
//		파싱하여 경도, 위도를 알아 내고 그 결과값을 Controller로 반환함
	   //String apiURL = "https://openapi.naver.com/v1/map/geocode?query=" + addr; //json
	    String apiURL = "https://apis.daum.net/local/geo/addr2coord?"
	    +"apikey=2280fd7a86793fef854e4c2d014f194f"
	    +"&q="+ convertaddress
	   	+"&output=xml";// xml
	    URL url = null;
		try {
			url = new URL(apiURL);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	    HttpURLConnection con;
		try {
			con = (HttpURLConnection)url.openConnection();
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
			   	br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}else {  // 에러 발생
			   	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
			   	response.append(inputLine);
			}
			br.close();
			DocumentBuilderFactory factory= DocumentBuilderFactory.newInstance();
			DocumentBuilder builder= factory.newDocumentBuilder();
			Document document= builder.parse(new InputSource(new StringReader(response.toString())));
			NodeList nodelist= document.getElementsByTagName("point_x");
			if(nodelist.getLength() > 0){
				Node node=  nodelist.item(0).getChildNodes().item(0);//첫번째 element 얻기
				NodeList nodelist2= document.getElementsByTagName("point_y");
				Node node2=  nodelist2.item(0).getChildNodes().item(0);//첫번째 element 얻기
				String lat = node2.getNodeValue();
				String lng = node.getNodeValue();
				result.add(Double.parseDouble(lat));
				result.add(Double.parseDouble(lng));
			}else{
				logger.error("----- 주소값 => 좌표값 변환 실패 ----------------------");
				logger.error("오류가 난 주소값 => "+address+" [확인 요망] ----- ");
				logger.error("-----------------------------------------------");
				result.add((double) 37.566696);
				result.add((double) 126.977942);
			}
		} catch (IOException | ParserConfigurationException | SAXException e) {
			e.printStackTrace();
		}
        return result;
	}
	
	public ArrayList<UpdateVO> UpdateXY(String address){
		UpdateVO vo = new UpdateVO();
		ArrayList<UpdateVO> insertlist = new ArrayList<UpdateVO>();
		
//		1. 한글은 URL에서 인식을 하지 못하기 때문에 한글을 UTF-8 형식으로 변환 시킴.
		String convertaddress = null;
		try {
			convertaddress = URLEncoder.encode(address, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("===== 주소값 NULL 또는 변환 실패 =====");
			e.printStackTrace();
		}
		
	   //String apiURL = "https://openapi.naver.com/v1/map/geocode?query=" + addr; //json
	   String apiURL = "https://apis.daum.net/local/geo/addr2coord?"
	     		+ "apikey=2280fd7a86793fef854e4c2d014f194f"
	       		+ "&q="+ convertaddress
	       		+ "&output=xml";// xml
	   
		   URL url = null;
		try {
			url = new URL(apiURL);
		} catch (MalformedURLException e) {
			System.out.println("===== URL(OpenAPI 변환 실패 =====");
			e.printStackTrace();
		}
		   HttpURLConnection con;
		try {
			con = (HttpURLConnection)url.openConnection();
			int responseCode = con.getResponseCode();
			BufferedReader br;
		   if(responseCode==200) { // 정상 호출
			   br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		   } else {  // 에러 발생
			   br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		   }
		   String inputLine;
		   StringBuffer response = new StringBuffer();
		   while ((inputLine = br.readLine()) != null) {
			   response.append(inputLine);
		   }
		   br.close();
		   
		   	DocumentBuilderFactory factory= DocumentBuilderFactory.newInstance();
			DocumentBuilder builder;
			builder = factory.newDocumentBuilder();
			Document document;
			document = builder.parse(new InputSource(new StringReader(response.toString())));
			NodeList nodelist= document.getElementsByTagName("point_x");
			
			/* 주소지가 잘못될 경우 좌표값이 존재 하지 않으므로 WSG84X, WSG84Y 1로 표기 함으로써 데이터를 읽어오지 않게 조치 */
			if(nodelist.getLength() > 0){
				Node node=  nodelist.item(0).getChildNodes().item(0);//첫번째 element 얻기
				NodeList nodelist2= document.getElementsByTagName("point_y");
				Node node2=  nodelist2.item(0).getChildNodes().item(0);//첫번째 element 얻기
				String lat = node2.getNodeValue();
				String lng = node.getNodeValue();
				vo.setWsg84x(Double.parseDouble(lat));
				vo.setWsg84y(Double.parseDouble(lng));
			}else{
				logger.error("----- 주소값 => 좌표값 변환 실패 ----------------------");
				logger.error("오류가 난 주소값 => "+address+" [확인 요망] ----- ");
				logger.error("-----------------------------------------------");
				vo.setWsg84x(1);
				vo.setWsg84y(1);	
			}
		} catch (IOException | ParserConfigurationException | SAXException e) {
			e.printStackTrace();
		}
		vo.setAddress(address);
		insertlist.add(vo);
		
		return insertlist;
	}
	
	public ArrayList<UpdateVO> Updatecoord2addr(double lat, double lng){
		UpdateVO vo = new UpdateVO();
		ArrayList<UpdateVO> result = new ArrayList<UpdateVO>();
		vo.setWsg84x(lat);
		vo.setWsg84y(lng);
		  //String apiURL = "https://openapi.naver.com/v1/map/geocode?query=" + addr; //json
		   String apiURL = "https://apis.daum.net/local/geo/coord2detailaddr?"
		     		+ "apikey=2280fd7a86793fef854e4c2d014f194f"
		       		+ "&y="+lat
		       		+ "&x="+lng
		       		+ "&inputCoordSystem=WGS84"
		       		+ "&output=json";//json 형식 
		try {
			URL url = new URL(apiURL);
			InputStreamReader isr = new InputStreamReader(url.openConnection().getInputStream(), "UTF-8");
			JSONObject object = (JSONObject)JSONValue.parse(isr);
			JSONObject  old = (JSONObject) object.get("old");
			String address = old.get("name").toString();
			String[] array = address.split(" ");
			String Si = array[0];
			String GunGu = array[1];
			vo.setAddress(address);
			vo.setCity(Si);
			vo.setTownship(GunGu);
			result.add(vo);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
