package com.hongik.project.vo;

public class BoardVO {
	double seq;	//글 번호	
	String writer;//작성자
	String comments;//
	String password;//글 비번
	double gpa;//별점
	String name;//
	String time;
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getSeq() {		
		return seq;
	}
	public void setSeq(double seq) {		
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public double getGpa() {
		return gpa;
	}
	public void setGpa(double gpa) {
		this.gpa = gpa;
	}
	
	@Override
	public String toString() {
		return "BoardVO [seq=" + seq + ", writer=" + writer + ", comments=" + comments + ", password=" + password
				+ ", gpa=" + gpa + ", name=" + name + ", time=" + time + "]";
	}
	
}
