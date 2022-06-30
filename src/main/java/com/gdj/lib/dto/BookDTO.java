package com.gdj.lib.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BookDTO {
	
	// 회원 정보
	private int mb_id;
	private String mb_status;
	
	public int getMb_id() {
		return mb_id;
	}
	public void setMb_id(int mb_id) {
		this.mb_id = mb_id;
	}
	public String getMb_status() {
		return mb_status;
	}
	public void setMb_status(String mb_status) {
		this.mb_status = mb_status;
	}
	
	
	//도서 정보
	private int b_id;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date b_date;
	private String b_title;
	private String writer;
	private String publisher;
	private int issue;
	private String b_status;
	private boolean reserve_able;
	private String newFileName;
	
	
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	public boolean isReserve_able() {
		return reserve_able;
	}
	public void setReserve_able(boolean reserve_able) {
		this.reserve_able = reserve_able;
	}
	public int getB_id() {
		return b_id;
	}
	public void setB_id(int b_id) {
		this.b_id = b_id;
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
	public Date getB_date() {
		return b_date;
	}
	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}
	
	
	//대출 정보
	
	private int brw_id;
	private Date brw_date;
	private boolean renew;
	private Date retrun_date;
	private Date return_finish;
	private String brw_status;

	public int getBrw_id() {
		return brw_id;
	}
	public void setBrw_id(int brw_id) {
		this.brw_id = brw_id;
	}
	public Date getBrw_date() {
		return brw_date;
	}
	public void setBrw_date(Date brw_date) {
		this.brw_date = brw_date;
	}
	public boolean isRenew() {
		return renew;
	}
	public void setRenew(boolean renew) {
		this.renew = renew;
	}
	public Date getRetrun_date() {
		return retrun_date;
	}
	public void setRetrun_date(Date retrun_date) {
		this.retrun_date = retrun_date;
	}
	public Date getReturn_finish() {
		return return_finish;
	}
	public void setReturn_finish(Date return_finish) {
		this.return_finish = return_finish;
	}
	public String getBrw_status() {
		return brw_status;
	}
	public void setBrw_status(String brw_status) {
		this.brw_status = brw_status;
	}
	
	
	//예약 정보
	private int reserve_id;
	private Date reserve_date;
	private String reason;

	public int getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(int reserve_id) {
		this.reserve_id = reserve_id;
	}
	public Date getReserve_date() {
		return reserve_date;
	}
	public void setReserve_date(Date reserve_date) {
		this.reserve_date = reserve_date;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
	
	
	
	
}
