package com.gdj.lib.dto;

import java.sql.Date;

<<<<<<< HEAD
import com.fasterxml.jackson.annotation.JsonFormat;

=======
>>>>>>> origin/master
public class MemberDTO {
	
	private String mb_id;
	private String mb_pw;
	private String mb_status;
	private String name;
	private String email;
	private String phone;
<<<<<<< HEAD
	private String mb_class;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date reg_date;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date leave_date;
	
	
	
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getLeave_date() {
		return leave_date;
	}
	public void setLeave_date(Date leave_date) {
		this.leave_date = leave_date;
=======
	private Date reg_date;
	private String mb_class;
	private Date leave_date;
	
	private int black_id;
	private String admin_start;
	private Date black_start;
	private String black_reason;
	private String admin_end;
	private Date black_end;
	private String end_reason;
	
	private int penalty_id;
	private int category_id;
	private Date penalty_start;
	private Date penalty_end;
	private String admin_cancel;
	private boolean cancel;
	
	
	
	public int getPenalty_id() {
		return penalty_id;
	}
	public void setPenalty_id(int penalty_id) {
		this.penalty_id = penalty_id;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public Date getPenalty_start() {
		return penalty_start;
	}
	public void setPenalty_start(Date penalty_start) {
		this.penalty_start = penalty_start;
	}
	public Date getPenalty_end() {
		return penalty_end;
	}
	public void setPenalty_end(Date penalty_end) {
		this.penalty_end = penalty_end;
	}
	public String getAdmin_cancel() {
		return admin_cancel;
	}
	public void setAdmin_cancel(String admin_cancel) {
		this.admin_cancel = admin_cancel;
	}
	public boolean isCancel() {
		return cancel;
	}
	public void setCancel(boolean cancel) {
		this.cancel = cancel;
	}
	public String getAdmin_start() {
		return admin_start;
	}
	public void setAdmin_start(String admin_start) {
		this.admin_start = admin_start;
	}
	public Date getBlack_start() {
		return black_start;
	}
	public void setBlack_start(Date black_start) {
		this.black_start = black_start;
	}
	public String getBlack_reason() {
		return black_reason;
	}
	public void setBlack_reason(String black_reason) {
		this.black_reason = black_reason;
	}
	public String getAdmin_end() {
		return admin_end;
	}
	public void setAdmin_end(String admin_end) {
		this.admin_end = admin_end;
	}
	public Date getBlack_end() {
		return black_end;
	}
	public void setBlack_end(Date black_end) {
		this.black_end = black_end;
	}
	public String getEnd_reason() {
		return end_reason;
	}
	public void setEnd_reason(String end_reason) {
		this.end_reason = end_reason;
>>>>>>> origin/master
	}
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
<<<<<<< HEAD
=======
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
>>>>>>> origin/master
	public String getMb_class() {
		return mb_class;
	}
	public void setMb_class(String mb_class) {
		this.mb_class = mb_class;
	}
<<<<<<< HEAD
=======
	public Date getLeave_date() {
		return leave_date;
	}
	public void setLeave_date(Date leave_date) {
		this.leave_date = leave_date;
	}
	public int getBlack_id() {
		return black_id;
	}
	public void setBlack_id(int black_id) {
		this.black_id = black_id;
	}
	
>>>>>>> origin/master
	
	

}
