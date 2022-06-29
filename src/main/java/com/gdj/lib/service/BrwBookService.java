package com.gdj.lib.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.BrwBookDAO;
import com.gdj.lib.dto.BrwBookDTO;


@Service
public class BrwBookService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookDAO dao;

	public ArrayList<BrwBookDTO> detail(HashMap<String, String> params) {
		logger.info("도서상세보기 서비스 요청 : " + params);
		return dao.detail(params);
	}


	public String brw (String b_id) {
		
		logger.info("도서대출 서비스 신청"+b_id);
		String loginId = "gustn0055";
		dao.brw(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	}

	public String reason(String b_id) {
		
		logger.info("도서예약 서비스 신청"+b_id);
		String loginId = "admin1";
		dao.reason(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	}


	public ArrayList<BrwBookDTO> history(HashMap<String, String> params) {
		logger.info("도서목록 서비스 요청");
		return dao.history(params);
	}


	public String bookreserve(String b_id) {
		logger.info("도서예약 서비스 신청"+b_id);
		String loginId = "gustn0055";
		dao.bookreserve(loginId, b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
		
	}


	public ArrayList<BrwBookDTO> bookList(HashMap<String, String> params) {
		logger.info("도서목록 서비스 요청");
		return dao.bookList(params);
	}


	public ArrayList<BrwBookDTO> reserve(HashMap<String, String> params) {
		logger.info("도서목록 서비스 요청");
		return dao.reserve(params);
	}


	public String reserveBtn(String brw_id) {
		
		BrwBookDTO dto = new BrwBookDTO();
		
		logger.info("도서연장 서비스 신청"+brw_id);
		Date return_date = dto.getReturn_date();
		dto.setReturn_date(return_date);
		dto.setRenew(true);
		dao.reserveBtn(brw_id);
		
		return "myPage/bookList/reserve";
		
	}


	public String del(String reserve_id) {
		
		logger.info("도서예약 취소"+reserve_id);
		dao.del(reserve_id);
		
		return "redirect:/reserve";
		
	}


	


	



	public int reserveCheck(String mb_id) {
		int cnt =0;
		cnt = dao.reserveCheck(mb_id);
		return cnt;
	}


	public long expiry(String mb_id) {
		return dao.expiry(mb_id);
	}


	public long overExpiry(String mb_id) {
		return dao.overExpiry(mb_id);
	}


	

	

	public void bookBrwDetail(String b_id) {
		logger.info("도서예약 취소"+b_id);
		dao.bookBrwDetail(b_id);
		
	}



	public void bookreason(HashMap<String, String> params) {
		logger.info("도서 예약"+params);
		dao.bookreason(params);
		
	}


	public HashMap<String, Object> myPageBrwList(HashMap<String, String> params) {
		
		HashMap<String, Object> brwBookPageMap = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
//		String option = params.get("option");
//		String word = params.get("word");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : "+page);
		
		//ArrayList<BoardDTO> noticeSearchList = new ArrayList<BoardDTO>();
		
		int allCnt = dao.allCount();
		logger.info("allCnt : "+allCnt);
		int pages = allCnt % cnt> 0 ? (allCnt / cnt)+1 : (allCnt/ cnt);
		logger.info("pages : "+pages);
		

		if(page > pages) {
			page = pages;
		};
		
		brwBookPageMap.put("pages", pages); //만들수있는 쵀대 페이지 수
		brwBookPageMap.put("currPage", page); //현재 페이지

		int offset = (page -1) * cnt;

		brwBookPageMap.put("offset", offset);
		logger.info("offset : "+offset);
		
		ArrayList<BrwBookDTO> bookListPaing = dao.bookListPaing(cnt, offset);
		brwBookPageMap.put("bookListPaing",bookListPaing);
		
		// 검색 관련 설정하는 조건문
//		if(word == null || word.equals("")) {
//			ArrayList<BoardDTO> noticeList = dao.noticeList(cnt, offset);
//			
//			noticePageMap.put("noticeList", noticeList);
//		} else {
//			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
//			
//			// 검색 옵션에 따라 SQL 문이 달라지기 때문에 조건문으로 분리했음
//			if(option.equals("제목")) {
//				noticeSearchList = dao.subjectNoticeSearch(cnt,offset,word);
//				logger.info("제목 옵션 설정");
//			}
//			
//			logger.info("검색결과 건수 : " +noticeSearchList.size());
//			noticePageMap.put("noticeList", noticeSearchList);
//			
//		}
//		logger.info("서비스 체크포인트");
//		
		
		
		return brwBookPageMap;
		
	}

	
	
	

	


	

	


}
