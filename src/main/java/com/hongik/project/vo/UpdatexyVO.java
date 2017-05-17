package com.hongik.project.vo;

public class UpdatexyVO {
	private String address;
	private double wsg84x;
	private double wsg84y;
	
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
