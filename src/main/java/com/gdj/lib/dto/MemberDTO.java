package com.gdj.lib.dto;

import java.sql.Date;

public class MemberDTO {
	
	private String mb_id;
	private String mb_pw;
	private String mb_status;
	private String name;
	private String email;
	private String phone;
	private Date reg_date;
	private String mb_class;
	private Date leave_date;
	
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getMb_pw() {
		return mb_pw;
	}
	public void setMb_pw(String mb_pw) {
		this.mb_pw = mb_pw;
	}
	public String getMb_status() {
		return mb_status;
	}
	public void setMb_status(String mb_status) {
		this.mb_status = mb_status;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getMb_class() {
		return mb_class;
	}
	public void setMb_class(String mb_class) {
		this.mb_class = mb_class;
	}
	public Date getLeave_date() {
		return leave_date;
	}
	public void setLeave_date(Date leave_date) {
		this.leave_date = leave_date;
	}
	
	

}
