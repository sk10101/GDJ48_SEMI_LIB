package com.gdj.lib.service;

import java.util.ArrayList;

import org.apache.ibatis.exceptions.TooManyResultsException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdj.lib.dao.MemberDAO;
import com.gdj.lib.dto.MemberDTO;

@Service
public class MyService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MemberDAO dao;

	public MemberDTO myUpdateDetail(String mb_id) {
			
		logger.info(mb_id+" 의 상세정보 DB 에 요쳥");
		
		return dao.memberUpdateDetailMy(mb_id);
	}

	public MemberDTO myUpdateList(String mb_id) {
		logger.info("리스트 서비스 요청");
		return dao.memberUpdateListMy(mb_id);
	}

	public void myUpdate(String mb_id, String mb_pw, String name ,String phone) {
		logger.info(mb_id+ " 의 수정 DB 에 요청");
		
		int row =  dao.myUpdate(mb_id,mb_pw,name,phone);
		logger.info("수정한 데이터 수 : "+row);
	}

	public void myUpdateTwo(String mb_id, String name, String phone) {
		logger.info(mb_id+ " 의 수정 DB 에 요청");
		
		int row =  dao.myUpdateTwo(mb_id,name,phone);
		logger.info("수정한 데이터 수 : "+row);
		
	}

	public void cancelMySecession(String mb_id) {
		logger.info(mb_id+" 의 회원탈퇴 취소 요청");
		dao.cancelMySecession(mb_id);
	}

	public void mySecession(String mb_id) {
		logger.info(mb_id+" 의 회원탈퇴 요청");
		dao.mySecession(mb_id);
		// dao.MySecessionTwo(mb_id);
	}

	public int notSecession(String mb_id) {
		logger.info("예약 대출 확인할 아이디 : "+mb_id);
		
		 Integer row = dao.notSecession(mb_id);
		 logger.info(mb_id+" 의 예약 대출 내역 : "+row);
		 
		 return row;
		
	}



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
