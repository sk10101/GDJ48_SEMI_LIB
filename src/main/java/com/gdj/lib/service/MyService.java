package com.gdj.lib.service;

import java.util.ArrayList;

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

	public ArrayList<MemberDTO> myUpdateList() {
		logger.info("리스트 서비스 요청");
		return dao.memberUpdateListMy();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}