package com.gdj.lib.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.BrwBookDAO;
import com.gdj.lib.dto.BrwBookDTO;


@Service
public class BrwBookService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookDAO dao;

	public BrwBookDTO detail(String b_id) {
		BrwBookDTO dto = null;
		logger.info(b_id+"상세보기 서비스 요청");
		dto = dao.detail(b_id);
		logger.info("b_title :"+dto.getB_title());
		return dto;
	}


	public String brw (String b_id) {
		
		logger.info("도서대출 서비스 신청"+b_id);
		String loginId = "gustn0055";
		dao.brw(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	}

	public String reason(String b_id) {
		
		logger.info("도서예약 서비스 신청"+b_id);
		String loginId = "admin1";
		dao.reason(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	}


	public ArrayList<BrwBookDTO> history(HashMap<String, String> params) {
		logger.info("도서목록 서비스 요청");
		return dao.history(params);
	}


	public String bookreserve(String b_id) {
		logger.info("도서예약 서비스 신청"+b_id);
		String loginId = "gustn0055";
		dao.bookreserve(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
		
	}


	public ArrayList<BrwBookDTO> bookList(HashMap<String, String> params) {
		logger.info("도서목록 서비스 요청");
		return dao.bookList(params);
	}


	public ArrayList<BrwBookDTO> reserve(HashMap<String, String> params) {
		logger.info("도서목록 서비스 요청");
		return dao.reserve(params);
	}


	public String reserveBtn(String brw_id) {
		
		BrwBookDTO dto = new BrwBookDTO();
		
		logger.info("도서연장 서비스 신청"+brw_id);
		Date return_date = dto.getReturn_date();
		dto.setReturn_date(return_date);
		dto.setRenew(true);
		dao.reserveBtn(brw_id);
		
		return "myPage/bookList/reserve";
		
	}


	public String del(String reserve_id) {
		
		logger.info("도서예약 취소"+reserve_id);
		dao.del(reserve_id);
		
		return "redirect:/reserve";
		
	}


	


	public String reserveBookBrw(HashMap<String, String> params) {
		logger.info("예약된 책 대출신청"+params);
		dao.reserveBookBrw(params.get("reserve_id"));
		dao.bookStatusUpdate(params.get("b_id"));
		return "redirect:/reserve";
		
	}


	public int reserveCheck(String mb_id) {
		int cnt =0;
		cnt = dao.reserveCheck(mb_id);
		return cnt;
	}


	public long expiry(String mb_id) {
		return dao.expiry(mb_id);
	}


	public long overExpiry(String mb_id) {
		return dao.overExpiry(mb_id);
	}


	public void penaltyDate(String mb_id) {
		 dao.penaltyDate(mb_id);
		
	}


	




	


//	public ArrayList<BookDTO> list() {
//		logger.info("도서목록 서비스 요청");
//		return dao.list();
//	}


	


	

	


}
