package com.gdj.lib.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.BoardDAO;
import com.gdj.lib.dto.BoardDTO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardDAO dao;
	
	@Autowired BoardDTO dto;
	
	

	public ArrayList<BoardDTO> noticelist() {
		logger.info("공지사항 리스트 서비스 요청");
		return dao.noticelist();
	}

	public boolean noticewrite(HashMap<String, String> params) {
		logger.info("공지사항 글쓰기 서비스");
		dto.setMb_id("admin");
		
		boolean success = false;
		
		if(dao.noticewrite(params)>0) {
			success = true;
		}
		
		return success;
	}

	public int noticedelete(ArrayList<String> noticedeleteList) {
		
		int cnt = 0;
		
		for (String notice_id : noticedeleteList) {
			cnt += dao.noticedelete(notice_id);
		}
		
		return cnt;
	}
}
