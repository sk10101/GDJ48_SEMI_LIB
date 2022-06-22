package com.gdj.lib.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.KioskDAO;
import com.gdj.lib.dto.KioskDTO;

@Service
public class KioskService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired KioskDAO dao;
	
	public String login(String id, String pw) {
		logger.info("키오스크 로그인 서비스 도착");
		return dao.login(id,pw);
	}

	public ArrayList<KioskDTO> list(String loginId) {
		logger.info("키오스크 대출 신청 리스트 요청");
		return dao.list(loginId);
	}

	public int borrow(ArrayList<String> borrowList) {
		int cnt = 0;
		for (String b_id: borrowList) {
			cnt += dao.borrow(b_id);
		}
		return cnt;
	}
	
	public void updateR(ArrayList<String> borrowList) {
		for (String b_id: borrowList) {
			dao.updateR(b_id);
		}
	}

	public int borrowTable(String loginId, ArrayList<String> borrowList) {
		logger.info("대출 테이블 추가 서비스");
		int borrowTable = 0;
		for(String b_id: borrowList) {
			borrowTable += dao.borrowTable(loginId, b_id);
		}
		return borrowTable;
		
	}

	public ArrayList<KioskDTO> returnList(String loginId) {
		logger.info("키오스크 반납 페이지 리스트 요청");
		return dao.returnList(loginId);
	}


}
