package com.gdj.lib.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BookDTO {
	
	private int b_id;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date b_date;
	private String b_title;
	private String writer;
	private String publisher;
	private int issue;
	private String b_status;
	private boolean b_reserve;
	
	
	public boolean isB_reserve() {
		return b_reserve;
	}
	public void setB_reserve(boolean b_reserve) {
		this.b_reserve = b_reserve;
	}
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
	public Date getB_date() {
		return b_date;
	}
	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public int getIssue() {
		return issue;
	}
	public void setIssue(int issue) {
		this.issue = issue;
	}
	public String getB_status() {
		return b_status;
	}
	public void setB_status(String b_status) {
		this.b_status = b_status;
	}
	
	
	
}
