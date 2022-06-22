package com.gdj.lib.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


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

	

	

	public void brw(HashMap<String, String> params) {
		logger.info("도서대출 서비스 신청"+params.get("b_id"));
		int row = dao.brw(params);
		logger.info("대출한 책 권수"+row);
		
	}

	


}
