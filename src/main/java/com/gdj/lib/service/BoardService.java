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
	
	

	public ArrayList<BoardDTO> noticeList() {
		logger.info("공지사항 리스트 서비스 요청");
		return dao.noticeList();
	}

	public boolean noticeWrite(HashMap<String, String> params) {
		logger.info("공지사항 글쓰기 서비스 요청");
		
		BoardDTO dto = new BoardDTO();
		dto.setMb_id("admin");
		dto.setNotice_title(params.get("notice_title"));
		dto.setNotice_content(params.get("notice_content"));
		
		boolean success = false;
		
		if(dao.noticeWrite(params)>0) {
			success = true;
		}
		
		return success;
		
		
	}

	public int noticeDelete(ArrayList<String> noticeDeleteList) {
		
		int cnt = 0;
		
		for (String notice_id : noticeDeleteList) {
			cnt += dao.noticeDelete(notice_id);
		}
		
		return cnt;
	}

	public BoardDTO noticeDetail(String notice_id) {
		BoardDTO dto = null;
		logger.info(notice_id+"공지사항 상세보기 서비스 요청");
		dto = dao.noticeDetail(notice_id);
		logger.info("notice content: "+dto.getNotice_content());
		return dto;
	}
}
