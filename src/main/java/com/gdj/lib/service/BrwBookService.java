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
import com.gdj.lib.dto.PhotoDTO;


@Service
public class BrwBookService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookDAO dao;

	public ArrayList<BrwBookDTO> detail(HashMap<String, String> params) {
		logger.info("도서상세보기 서비스 요청 : " + params);
		return dao.detail(params);
	}
	
	public ArrayList<PhotoDTO> photoList(HashMap<String, String> params) {
		logger.info("도서상세보기 이미지 : " + params);
		return dao.list(params);
	}



	public ArrayList<BrwBookDTO> history(HashMap<String, String> params, String mb_id) {
		logger.info("도서목록 서비스 요청");
		return dao.history(params,mb_id);
	}

	public ArrayList<BrwBookDTO> reserve(HashMap<String, String> params, String mb_id) {
		logger.info("예약목록 서비스 요청 : " + dao.reserve(params, mb_id));
		return dao.reserve(params,mb_id);
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
	
	
	public void bookreason(HashMap<String, String> params) {
		logger.info("도서 예약"+params);
		dao.bookreason(params);
		
	}
	
	public void reserve_able(HashMap<String, String> params) {
		logger.info("예약 가능 여부 0으로 바꿔요");
		dao.reserve_able(params);
		
	}
	
	
	public int reserveCheck(String mb_id) {
		int cnt =0;
		cnt = dao.reserveCheck(mb_id);
		return cnt;
	}


	public long expiry(String mb_id) {
		return dao.expiry(mb_id);
	}

	public void expiryPenalty(String mb_id) {
		dao.expiryPenalty(mb_id);
		
	}
	
	public void reserveCancel(String mb_id) {
		dao.reserveCancel(mb_id);
	}


	public void addPenalty(String mb_id) {
		dao.addPenalty(mb_id);

	}

	
	


	

	

	public void bookBrwDetail(String b_id) {
		logger.info("도서예약 취소"+b_id);
		dao.bookBrwDetail(b_id);
		
	}



	
	


	public HashMap<String, Object> myPageBrwList(HashMap<String, String> params) {
		
		HashMap<String, Object> brwBookPageMap = new HashMap<String, Object>();
		
		
		String mb_id = params.get("mb_id");
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
//		String option = params.get("option");
//		String word = params.get("word");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : "+page);
		logger.info("로그인한 아이디 : " + mb_id);
		
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
		
		ArrayList<BrwBookDTO> bookListPaing = dao.bookListPaing(cnt, offset, mb_id);
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
	
	
	public String reserveBookBrw(HashMap<String, String> params) {
		logger.info("예약된 책 대출신청"+params);
		//dao.reserveBookBrw(params.get("reserve_id"));
		dao.reserveBookBrw(params.get("reserve_id"));
		dao.bookStatusUpdate(params.get("b_id"));
		return "redirect:/reserve";
		
	}


	public void bookDetailBrw(HashMap<String, String> params) {
		logger.info("도서상세보기 대출신청 : " + params);
		dao.bookDetailBrw(params);
		dao.bookStatusUpdate(params.get("b_id"));
		
	}

	public void del(HashMap<String, String> params) {
		
		logger.info("도서예약 취소"+params);
		dao.bookdel(params.get("reserve_id"));
		dao.bookdelStatusUpdate(params.get("b_id"));
		
	}

	public int penaltyCheck(String mb_id) {
		logger.info("이용정지 리스트 찾기 서비스");
		return dao.penaltyCheck(mb_id);
	}

	

	

	

//	public ArrayList<BrwBookDTO> brwListMb_id(String mb_id) {
//		logger.info("서비스컨트롤러 회원아이디 : "+mb_id);
//		return dao.brwListMb_id(mb_id);
//		
//	}


	

	

	


	


	


	
	
	

	


	

	


}
