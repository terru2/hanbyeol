package com.hongik.project.vo;

import org.springframework.stereotype.Component;

@Component
public class DataVO {
	
	private String category1;
	private String category2;
	private String name;
	private String address;
	private String roadaddress;
	private double wsg84x;
	private double wsg84y;
	private String phonenumber;
	
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRoadaddress() {
		return roadaddress;
	}
	public void setRoadaddress(String roadaddress) {
		this.roadaddress = roadaddress;
	}
	public double getWsg84x() {
		return wsg84x;
	}
	public void setWsg84x(double wsg84x) {
		this.wsg84x = wsg84x;
	}
	public double getWsg84y() {
		return wsg84y;
	}
	public void setWsg84y(double wsg84y) {
		this.wsg84y = wsg84y;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
}
