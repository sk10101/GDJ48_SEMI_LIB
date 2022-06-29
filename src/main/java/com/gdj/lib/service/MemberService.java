package com.gdj.lib.service;

import java.util.ArrayList;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestParam;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.BrwBookDTO;
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
		
		logger.info("관리자 > 회원 도서내역 서비스 도착");
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


	public ArrayList<BrwBookDTO> brwList(String mb_id) {
		logger.info("회원대출내역 조회 서비스 도착 :"+mb_id);
		return dao.brwList(mb_id);
	}

	
	

	public MemberDTO penaltyDetail(String penalty_id) {
		logger.info("이용정지 리스트 상세보기 서비스 : "+penalty_id);
		return dao.penaltyDetail(penalty_id);
	}

	public void penaltyUpdate(HashMap<String, String> params) {
	      logger.info("이용정지리스트 수정 서비스");
	      dao.penaltyUpdate(params);
	   }

	public void blackUpdate(HashMap<String, String> params) {
		logger.info("블랙리스트 수정 서비스");
	      dao.blackUpdate(params);
		
	}

	public HashMap<String, Object> penaltyList(HashMap<String, String> params) {
HashMap<String, Object> map = new HashMap<String, Object>();


int cnt = Integer.parseInt(params.get("cnt"));
int page = Integer.parseInt(params.get("page"));
String option = params.get("option");
String word = params.get("word");
logger.info("서비스 리스트 요청 : {}", params);
logger.info("보여줄 페이지 : " + page);

ArrayList<MemberDTO> searchList = new ArrayList<MemberDTO>();

// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
int allCnt = dao.allCount();
logger.info("allCnt : " + allCnt);

int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);

logger.info("pages : " + pages);
if (page > pages) {
	page = pages;
}
map.put("pages", pages); // 최대 페이지 수

int offset = cnt * (page-1);

map.put("offset", offset);
map.put("currPage", page); // 현재 페이지

logger.info("offset : "+offset);
	
//검색 관련 설정하는 조건문
		if(word == null || word.equals("")) {
			ArrayList<MemberDTO> penaltyList = dao.penaltyList(cnt, offset);
			
			map.put("penaltyList", penaltyList);
		} else {
			/*
			 * logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			 * 
			 * // 검색 옵션에 따라 SQL 문이 달라지기 때문에 조건문으로 분리했음 if(option.equals("제목")) { searchList
			 * = dao.subjectSearch(cnt,offset,word); logger.info("제목 옵션 설정"); } else
			 * if(option.equals("처리상태")) { searchList = dao.statusSearch(cnt,offset,word);
			 * logger.info("처리상태 옵션 설정"); } else { searchList =
			 * dao.writerSearch(cnt,offset,word); logger.info("작성자 옵션 설정"); }
			 */
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("penaltyList", searchList);
			
		}
		logger.info("서비스 체크포인트");
		return map;
	
	}
}
	

