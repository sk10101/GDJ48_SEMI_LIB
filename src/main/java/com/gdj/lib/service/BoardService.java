package com.gdj.lib.service;

import java.util.ArrayList;

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
	
	public ArrayList<BoardDTO> list() {
		logger.info("리스트 서비스 요청");
		
		return dao.list();
	}
	
	
}
