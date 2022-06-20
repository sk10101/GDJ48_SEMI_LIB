package com.gdj.lib.dto;

import java.sql.Date;

public class BoardDTO {
	
	// 답변 DTO
	private int reply_id;
	private int mb_id;
	private Date reply_date;
	private String reply_content;
	
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getMb_id() {
		return mb_id;
	}
	public void setMb_id(int mb_id) {
		this.mb_id = mb_id;
	}
	public Date getReply_date() {
		return reply_date;
	}
	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	
	
	
	// 건의사항 DTO
	private int claim_id;
	private String claim_title;
	private Date claim_date;
	private String claim_content;
	private String claim_status;
	
	public int getClaim_id() {
		return claim_id;
	}
	public void setClaim_id(int claim_id) {
		this.claim_id = claim_id;
	}
	public String getClaim_title() {
		return claim_title;
	}
	public void setClaim_title(String claim_title) {
		this.claim_title = claim_title;
	}
	public Date getClaim_date() {
		return claim_date;
	}
	public void setClaim_date(Date claim_date) {
		this.claim_date = claim_date;
	}
	public String getClaim_content() {
		return claim_content;
	}
	public void setClaim_content(String claim_content) {
		this.claim_content = claim_content;
	}
	public String getClaim_status() {
		return claim_status;
	}
	public void setClaim_status(String claim_status) {
		this.claim_status = claim_status;
	}
	
	
}
