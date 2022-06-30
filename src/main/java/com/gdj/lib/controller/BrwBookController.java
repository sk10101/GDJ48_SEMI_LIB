package com.gdj.lib.controller;


import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.mapping.ParameterMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.dto.PhotoDTO;
import com.gdj.lib.service.BrwBookService;

@Controller
public class BrwBookController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookService service;
	
	//대출내역
	@RequestMapping(value = "/brwHistory")
	public String history(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		String mb_id = (String) session.getAttribute("loginId");
		logger.info("대출내역 목록");
		logger.info(mb_id);
		model.addAttribute("mb_id",mb_id);
		ArrayList<BrwBookDTO> history = service.history(params,mb_id);
		logger.info("list 갯수 :"+history.size());
		model.addAttribute("history",history);

		
		
		
		
			
		return "myPage/bookList/brwHistory";
	}
	
	
	
	//예약내역
	@RequestMapping(value = "/reserve")
	public String reserve(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		String mb_id = (String) session.getAttribute("loginId");
		
		logger.info("예약내역 목록"); 
		model.addAttribute("mb_id",mb_id);
		ArrayList<BrwBookDTO> reserve = service.reserve(params,mb_id);
		logger.info("list 갯수 :"+reserve.size());
		model.addAttribute("reserve",reserve);
			
		return "myPage/bookList/reserve";
		
	}
	
	//도서 상세보기
	@RequestMapping(value = "/bookDetail.do")
	public String bookDetail(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		
		
		
		logger.info("이전대출 목록" + params); 
		ArrayList<BrwBookDTO> detail = service.detail(params);
		ArrayList<PhotoDTO> list = service.photoList(params); //photo 정보 가져옴
		model.addAttribute("detail",detail);
		model.addAttribute("list",list);
			
		return "book/bookDetail";
		
	}
	
	
	//대출내역 연장신청
	@RequestMapping(value = "/reserveBtn.ajax")
	@ResponseBody
	public String reserveBtn(HttpSession session, Model model,
			@RequestParam String brw_id) {
		
		logger.info("예약기능"+brw_id);
		service.reserveBtn(brw_id);
		
		
		//service.bookreserve(b_id);
		
		return "myPage/bookList/reserve";
	
		
	}
	
	//현재 예약내역 예약취소
	@RequestMapping(value = "/bookDel.ajax")
	@ResponseBody
	public String bookDel(HttpSession session, Model model,
			@RequestParam HashMap<String, String> params) {
		
		logger.info("예약내역 리스트"+params);
		service.del(params);
		
		return "redirect:/reserve";
		
	}
	
	//도서 상세보기 대출신청
		@RequestMapping(value = "/bookDetailBrw.ajax")
		@ResponseBody
		public String bookDetailBrw(HttpSession session, Model model, 
				@RequestParam HashMap<String, String> params) {
			
			logger.info("책번호 아이디 : "+ params );
			service.bookDetailBrw(params);
			
			return "myPage/bookList/reserve";
			
			
		}
	
	//예약내역에 대출신청
	@RequestMapping(value = "/reserveBookbrw.ajax")
	@ResponseBody
	public String reserveBookBrw(HttpSession session, Model model, 
			@RequestParam HashMap<String, String> params) {
		
		logger.info("받아온 예약번호, 책번호 : "+ params );
		service.reserveBookBrw(params);
		
		return "redirect:/reserve";
		
		
	}
	
	//도서상세보기 대출예약 
	@RequestMapping(value = "/bookreason.ajax")
	@ResponseBody
	public String bookreason(HttpSession session, Model model, 
			@RequestParam HashMap<String, String> params) {
		
		logger.info("받아온 책번호 : "+ params );
		service.bookreason(params);
		return "book/bookDetail";
		
		
	}

	/*
	 * @RequestMapping(value = "/bookreason.ajax")
	 * 
	 * @ResponseBody public String bookreason(HttpSession session, Model model,
	 * 
	 * @RequestParam HashMap<String, String> params) {
	 * 
	 * String page = "redirect:/"; logger.info("받아온 책번호 : "+ params ); String msg =
	 * ""; long miliseconds = System.currentTimeMillis(); Date date = new
	 * Date(miliseconds);
	 * 
	 * 
	 * // 예약 내역 확인을 위해 예약 테이블에서 회원 id 를 통해 예약 조회 int reserveCheck =
	 * service.reserveCheck("gustn0055"); logger.info("예약한 수: "+reserveCheck);
	 * if(reserveCheck == 1) { long expiry = service.expiry("gustn0055"); // 만료일이
	 * 지났을 경우
	 * 
	 * // expiry db 에서 데이트 타입으로 가져와야 비교 가능 if(expiry>date.) { msg = "이용정지 3일입니다";
	 * }else { msg = "예약신청이 완료되었습니다."; service.bookreason(params); } } // 예약 기간이
	 * 지났는데 반납을 안한 경우
	 * 
	 * return msg;
	 * 
	 * 
	 * }
	 */
	
	
		//이전대출 내역
		@RequestMapping(value = "/brwList")
		public String bookList(Model model, HttpSession session,
				@RequestParam HashMap<String, String> params) {
			
			
			logger.info("이전대출 목록");
			
			
//			String mb_id = (String) session.getAttribute("loginId");
//			ArrayList<BrwBookDTO> bookList = service.brwListMb_id(mb_id);
//			logger.info("list 갯수 :"+bookList.size());
//			model.addAttribute("bookList",bookList);
//			
//			
//			logger.info(mb_id);
//			model.addAttribute("mb_id",mb_id);
			//service.brwListMb_id(mb_id);
				
			return "myPage/bookList/brwList";
			
		}
		
	//brwList 페이징 처리
	@RequestMapping("/myPageBrwList.ajax")
	@ResponseBody
	public HashMap<String, Object> myPageBrwList(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		logger.info("리스트 요청 : {}",params);
		HashMap<String, Object> brwList = service.myPageBrwList(params);
		logger.info("컨트롤러 체크포인트");
		
		return brwList;
	}

	
	
	
}












