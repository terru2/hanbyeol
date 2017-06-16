package com.hongik.project.vo;

import org.springframework.stereotype.Component;

@Component
public class MapDataVO{
	
	private String id;
	private String category1;
	private String category2;
	private String name;
	private String city;
	private String township;
	private String address;
	private String roadaddress;
	private String phonenumber;
	private String closeddays;
	private String time;
	private String comments;
	private double wsg84x;
	private double wsg84y;
	private String shareox;
	private double distance;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public double getDistance() {
		return distance;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTownship() {
		return township;
	}
	public void setTownship(String township) {
		this.township = township;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
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
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getCloseddays() {
		return closeddays;
	}
	public void setCloseddays(String closeddays) {
		this.closeddays = closeddays;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
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
	public String getShareox() {
		return shareox;
	}
	public void setShareox(String shareox) {
		this.shareox = shareox;
	}
	@Override
	public String toString() {
		return "MapDataVO [id=" + id + ", category1=" + category1 + ", category2=" + category2 + ", name=" + name
				+ ", address=" + address + ", roadaddress=" + roadaddress + ", phonenumber=" + phonenumber
				+ ", closeddays=" + closeddays + ", time=" + time + ", comments=" + comments + ", wsg84x=" + wsg84x
				+ ", wsg84y=" + wsg84y + ", distance=" + distance + "]";
	}
}
