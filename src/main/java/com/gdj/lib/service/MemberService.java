package com.gdj.lib.service;

import java.util.ArrayList;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestParam;

import com.gdj.lib.dao.MemberDAO;
import com.gdj.lib.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired MemberDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ArrayList<MemberDTO> memberList() {
		
		return dao.memberList();
	}

	public MemberDTO detail(String mb_id) {
	
		MemberDTO dto = null;
		logger.info(mb_id+" 상세보기 서비스 요청");
		dto = dao.detail(mb_id);
		
		return dto;
	}
	
	public ArrayList<MemberDTO> adminList() {
		
		return dao.adminList();
	}

	public void update(HashMap<String, String> params) {
		logger.info("회원상태 수정 서비스");
		dao.update(params);
	}

	public ArrayList<MemberDTO> memberBrw() {
		
		return dao.memberBrw();
	}

	public ArrayList<MemberDTO> blackList() {
		
		return dao.blackList();
	}

	public MemberDTO blackDetail(String black_id) {
		logger.info("블랙리스트 상세보기 서비스 : "+black_id);
		return dao.blackDetail(black_id);
	}

	public String idget(String id) {

		return dao.idget(id);
	}

	public boolean blackAdd(HashMap<String, String> params) {
		
		MemberDTO dto = new MemberDTO();
		dto.setAdmin_start("admin");
		dto.setMb_id(params.get("mb_id"));
		dto.setBlack_reason(params.get("black_reason"));
		
		boolean success = false;
		
		if(dao.blackAdd(dto) > 0) {
			success = true;
			logger.info("성공여부 : "+success);
		}
		// 나중에 로그인 기능 추가하면 params 넣을것 (추후 수정)
		return success;
	}


	public MemberDTO blackCancel(String black_id) {
		
		logger.info("블랙리스트 해제 서비스");
		MemberDTO dto = new MemberDTO();
		dto.setAdmin_end("admin");
		
		return dao.blackCancel(black_id);
	}




}

