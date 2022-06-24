package com.gdj.lib.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.SeatDAO;
import com.gdj.lib.dto.SeatDTO;

@Service
public class SeatService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired SeatDAO dao;

	public ArrayList<SeatDTO> list() {
		logger.info("열람실 리스트 요청");
		return dao.list();
	}

}
