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
	
	// 키오스크 로그인
	public String login(String id, String pw) {
		logger.info("키오스크 로그인 서비스 도착");
		return dao.login(id,pw);
	}

	// 키오스크 대출할 리스트
	public ArrayList<KioskDTO> list(String loginId) {
		logger.info("키오스크 대출 신청 리스트 요청");
		return dao.list(loginId);
	}

	// 키오스크 대출하기
	public int borrow(ArrayList<String> borrowList) {
		int cnt = 0;
		for (String b_id: borrowList) {
			cnt += dao.borrow(b_id);
		}
		return cnt;
	}
	
	// 키오스크 대출 - 예약 테이블에 사유=정상
	public void updateR(ArrayList<String> borrowList) {
		for (String b_id: borrowList) {
			dao.updateR(b_id);
		}
	}

	// 키오스크 대출 - 대출테이블 insert
	public int borrowTable(String loginId, ArrayList<String> borrowList) {
		logger.info("대출 테이블 추가 서비스");
		int borrowTable = 0;
		for(String b_id: borrowList) {
			borrowTable += dao.borrowTable(loginId, b_id);
		}
		return borrowTable;
		
	}

	// 키오스크 반납할 리스트 
	public ArrayList<KioskDTO> returnList(String loginId) {
		logger.info("키오스크 반납 페이지 리스트 요청");
		return dao.returnList(loginId);
	}

	// 키오스크 반납
	public int bookReturn(ArrayList<String> returnList) {
		int cnt = 0;
		for (String b_id: returnList) {
			cnt += dao.bookReturn(b_id);
		}
		return cnt;
	}

	public void updateB(ArrayList<String> returnList) {
		for (String b_id: returnList) {
			dao.updateB(b_id);
		}
	}

	public String loginSeat(String id) {
		return dao.loginSeat(id);
	}

	public int notReturn(String loginId) {
		int cnt = 0;
		cnt = dao.notReturn(loginId);
		return cnt;
	}

	public long returnDate(String loginId) {
		return dao.returnDate(loginId);
	}

	public long returnFinish(String loginId) {
		return dao.returnFinish(loginId);
	}

	public void penaltyEndDate(String loginId) {
		dao.penaltyEndDate(loginId);
	}

	public int chkReturnOver(String loginId) {
		return dao.chkReturnOver(loginId);
	}

	public int chkPenalty(String loginId) {
		return dao.chkPenalty(loginId);
	}

	public void insertPenalty(String loginId) {
		dao.insertPenalty(loginId);
		
	}

	public String getMbClass(String id, String pw) {
		
		return dao.getMbClass(id,pw);
	}



}
