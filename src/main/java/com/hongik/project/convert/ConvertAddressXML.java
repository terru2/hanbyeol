package com.hongik.project.convert;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class ConvertAddressXML {
	
	private DocumentBuilder docBuilder;
	private String xmlData;
	private Document doc;
	private ArrayList<Double> result = new ArrayList<Double>();
	
	public ArrayList<Double> ConvertAddress(String address) throws ParserConfigurationException, IOException, SAXException {
		
//		1. 한글은 URL에서 인식을 하지 못하기 때문에 한글을 UTF-8 형식으로 변환 시킴.
		String convertaddress = null;
		String testaddress = null;
		byte[] b;
		try {
			b = address.getBytes("UTF-8");
		
		for(int i=0; i<b.length; i++){
			if(Integer.toHexString(b[i]).length()>3){
				 testaddress += "%"+Integer.toHexString(b[i]).substring(6,8);
				 convertaddress = testaddress.substring(4);
			}else{
				testaddress += "%"+Integer.toHexString(b[i]);
				convertaddress = testaddress.substring(4);
			}
		}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		System.out.println("String 한글형식을 UTF-8 형태로 변경 --> "+convertaddress);
		
//		2. 주소를 utf-8 형식으로 변환 후 구글맵 api 를 이용하여 xml 형식으로 데이터를 받은 후 
//		파싱하여 경도, 위도를 알아 내고 그 결과값을 Controller로 반환함
		docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
		String urlString = "https://maps.googleapis.com/maps/api/geocode/xml?address="+convertaddress
				+ "&key=AIzaSyC8McCQMfRdbXz90jcIfaAbYvbCPf9D5yg&language=ko";
		URL url = new URL(urlString);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		
		byte[] bytes = new byte[4096];
		InputStream in = conn.getInputStream();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		while(true){
			int red = in.read(bytes);
			if(red < 0)
				break;
			baos.write(bytes, 0, red);
		}
		xmlData = baos.toString("UTF-8");
		baos.close();
		in.close();
		doc = docBuilder.parse(new InputSource(new StringReader(xmlData)));
		/* 전체 xml Data 보기 
		System.out.println(xmlData);*/
		
		NodeList nodelist = doc.getElementsByTagName("location");
		for(int i=0; i<nodelist.getLength(); i++){
			for(Node node = nodelist.item(i).getFirstChild(); node!=null; node=node.getNextSibling()){
				if(node.getNodeName().equals("lat")){
					String lat = node.getTextContent();
					result.add(Double.parseDouble(lat));
				}if(node.getNodeName().equals("lng")){
					String lng = node.getTextContent();
					result.add(Double.parseDouble(lng));
				}
			}
		}
		return result;
	}
}
