package com.gdj.lib.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdj.lib.dao.BookDAO;
import com.gdj.lib.dao.BrwBookDAO;
import com.gdj.lib.dto.BookDTO;


@Service
public class BrwBookService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookDAO dao;

	public BookDTO detail(String b_id) {
		BookDTO dto = null;
		logger.info(b_id+"상세보기 서비스 요청");
		dto = dao.detail(b_id);
		logger.info("b_title :"+dto.getB_title());
		return dto;
	}


	public String brw (String b_id) {
		
		logger.info("도서대출 서비스 신청"+b_id);
		String loginId = "gustn0055";
		dao.brw(loginId, b_id);
		
//		
//		BrwBookDTO dto = new BrwBookDTO();
//		//맴버 아이디
//		dto.setMb_id("admin1");
//		int row = dao.brw(dto);
//		logger.info(row+ "번의 책 대출");
//		
		return "redirect:/bookDetail?b_id="+b_id;
	}


	public String bookreserve(String b_id) {
		logger.info("도서예약 서비스 신청"+b_id);
		String loginId = "tester";
		dao.bookreserve(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
		
	}

	

	

	


}
