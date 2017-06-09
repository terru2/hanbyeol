package com.hongik.project.vo;

public class UpdateVO {
	private String address;
	private String city;
	private String township;
	private String category1;
	private double wsg84x;
	private double wsg84y;
	private double distance;
	
	public double getDistance() {
		return distance;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	@Override
	public String toString() {
		return "UpdatexyVO [address=" + address + ", wsg84x=" + wsg84x + ", wsg84y=" + wsg84y
				+ "]";
	}
}
