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

	public void seatUse(String loginId, String seatNo, String useTime) {
		logger.info(loginId+" / "+seatNo+" / "+useTime);
		dao.seatUse(loginId,seatNo,useTime);
	}

	public void updateSeat(String seatNo, String useTime) {
		logger.info(seatNo+" / "+useTime);
		dao.updateSeat(seatNo,useTime);
		
	}

	public void seatTime() {
		logger.info("열람실 좌석 업데이트");
		dao.seatTime();
	}

	public void seatOut(String loginId) {
		logger.info("열람실 퇴실 서비스");
		dao.seatOut(loginId);
		
	}

}
