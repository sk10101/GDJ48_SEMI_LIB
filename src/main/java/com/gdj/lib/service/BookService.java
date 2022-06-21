package com.gdj.lib.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.BookDAO;
import com.gdj.lib.dto.BookDTO;

@Service
public class BookService {
	
	@Autowired BookDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ArrayList<BookDTO> list() {
		logger.info("리스트 서비스 요청");
		return dao.list();
	}

	public BookDTO detail(String b_id) {
		BookDTO dto = null;
		logger.info(b_id+"상세보기 서비스 요청");
		dto = dao.detail(b_id);
		logger.info("b_title :"+dto.getB_title());
		return dto;
	}

	public void bookUpdate(HashMap<String, String> params) {
		logger.info("도서 관리 수정 서비스 요청");
		int row = dao.bookUpdate(params);
		logger.info("수정완료 : "+row);
		
	}

	public ArrayList<BookDTO> bookSearch(HashMap<String, String> params) {
		logger.info("검색결과요청서비스");
		return dao.bookSearch(params);
	}

	public void bookAdd(HashMap<String, String> params) {
		logger.info("도서 추가 서비스 요청");
		int row = dao.bookAdd(params);
		logger.info("도서추가 완료:"+row);
	}
	
	
	
}
