package com.gdj.lib.controller;


import java.sql.Date;
import java.text.SimpleDateFormat;
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
import com.gdj.lib.dto.KioskDTO;
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
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			logger.info("대출내역 목록");
			logger.info(mb_id);
			model.addAttribute("mb_id",mb_id);
			ArrayList<BrwBookDTO> history = service.history(params,mb_id);
			logger.info("list 갯수 :"+history.size());
			model.addAttribute("history",history);
			page = "myPage/bookList/brwHistory";
		} else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
			page = "main";
		} else {
			model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
		}
				
		return page;	

	}
	
	
	
	//예약내역
	@RequestMapping(value = "/reserve")
	public String reserve(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		String mb_id = (String) session.getAttribute("loginId");
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			logger.info("예약내역 목록"); 
			model.addAttribute("mb_id",mb_id);
			ArrayList<BrwBookDTO> reserve = service.reserve(params,mb_id);
			logger.info("list 갯수 :"+reserve.size());
			model.addAttribute("reserve",reserve);
			page = "myPage/bookList/reserve";
		} else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
			page = "main";
		} else {
			model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
		}		
		
		return page; 
		
	}
	
	//도서 상세보기
	@RequestMapping(value = "/bookDetail.do")
	public String bookDetail(Model model, HttpSession session,
			@RequestParam String b_id) {
		
		logger.info("도서 상세보기" + b_id); 
		service.detail(model, b_id);
				
		return "book/bookDetail";
				
	}
	

	//대출내역 연장신청
	@RequestMapping(value = "/reserveBtn.ajax")
	@ResponseBody
	public String reserveBtn(HttpSession session, Model model,
			@RequestParam String brw_id) {
		
		logger.info("예약기능"+brw_id);
		service.reserveBtn(brw_id);	
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
	public HashMap<String, String> bookDetailBrw(HttpSession session, Model model, 
			@RequestParam HashMap<String, String> params) {
			
			String msg = "도서대출이 완료되었습니다.";
			HashMap<String, String> map = new HashMap<String, String>();
		
			//현재대출신청 기간..
			long miliseconds = System.currentTimeMillis(); 
			Date date = new Date(miliseconds);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String nowTime = sdf.format(date);
			long nowtime = Long.parseLong(nowTime);
				
			String mb_id = (String) session.getAttribute("loginId");
			logger.info(mb_id);
			logger.info("책번호 아이디 : "+ params);
			
			if (mb_id != null && session.getAttribute("mb_class").equals("일반회원")) {
				logger.info("회원 : 도서대출 서비스 컨트롤러");
				// loginId가 대출한 책이 연체 되었는지 확인
				int chkReturnOver = service.chkReturnOver(mb_id);
				if(chkReturnOver > 0) {
					// 연체 페널티가 부과되었는지 확인
					int chkPenalty = service.chkPenalty(mb_id);
					// 페널티 부과된 내용이 없다면
					if (chkPenalty == 0) {
						// 연체 페널티 부과
						service.insertPenalty(mb_id);
					}
					
				ArrayList<BrwBookDTO> brwlist = service.brwlist(params);
				model.addAttribute("brwlist", brwlist);
				logger.info("list 갯수: "+brwlist.size());
				if(brwlist.size() <= 5 ) {
					service.bookDetailBrw(params);
					msg = "도서대출 신청완료";
				} else {
					msg = "도서권수가 초과되었습니다.";
				}
					
				} 
			
				} else { // 회원x 관리자
				msg = "일반회원만 이용가능한 서비스입니다.";
				}
			
			
			map.put("msg", msg);
			return map;
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
 
	  @RequestMapping(value = "/bookreason.ajax")
	  @ResponseBody 
	  public String bookreason(HttpSession session, Model model, @RequestParam HashMap<String, String> params) {  
		  String mb_id = (String) session.getAttribute("loginId");
		  logger.info(mb_id);
		  model.addAttribute("mb_id",mb_id);
		  String page = "redirect:/"; logger.info("받아온 책번호 : "+ params ); 
		  String msg =""; 
	  
		  long miliseconds = System.currentTimeMillis(); 
		  Date date = new Date(miliseconds);
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		  String nowTime = sdf.format(date);
		  long nowtime = Long.parseLong(nowTime);
		
	  // 이용정지 내역에 해당 아이디가 있나 조회
	  int penaltyCheck = service.penaltyCheck(mb_id);
	  model.addAttribute("penaltyCheck",penaltyCheck);
	  logger.info("이용정지 리스트에 있나?"+ penaltyCheck +"건");
	  
	  if(penaltyCheck >=1 ) {
	  // 이용정지 내역에 아이디 있으면 ㄱㄱ
		  
		  long penaltyDate = service.penaltyDate(mb_id);
		  logger.info("이용정지 끝나는 날 : "+penaltyDate+"오늘 날짜 :"+nowtime);
		  if(penaltyDate > nowtime) {
			  // 이용정지 날짜가 지났으면 다시 예약 가능
			  
			  // 예약 내역 확인을 위해 예약 테이블에서 회원 id 를 통해 예약 조회 
			  int reserveCheck =service.reserveCheck(mb_id); 
			  logger.info("예약만료인 책 권수: "+reserveCheck);
			  if(reserveCheck >= 1) {
				  long expiry = service.expiry(mb_id); 
				  logger.info("예약 만료일 "+expiry);
				 // expiry == 예약날 +22
				  
				  // 예약 신청을 하려고 할 때 예약 후 22일이 지난 날짜와 현재날짜를 비교	  
				  if(expiry < nowtime) { 
					  service.expiryPenalty(mb_id);
					  service.reserveCancel(mb_id);
					  service.addPenalty(mb_id);
					  msg = "이용정지 3일입니다";
					  logger.info(msg);
					  model.addAttribute("msg", msg);
				  }else { 		
					  msg = "예약신청이 완료되었습니다."; 
					  model.addAttribute("msg", msg);
					  service.bookreason(params);
					  service.reserve_able(params);
				  }
			  }  else{  	 
				  service.bookreason(params);
				  service.reserve_able(params);
				  msg = "예약신청이 완료되었습니다."; 
				  model.addAttribute("msg", msg);
				 }
	  
		  }else {
			 logger.info("아직 정지중입니다 ㅠㅠ");
			 msg = penaltyDate+"까지 정지기간입니다.";
		  }
	  
	  }else{  	 
		  service.bookreason(params);
		  service.reserve_able(params);
		  msg = "예약신청이 완료되었습니다."; 
		  model.addAttribute("msg", msg);
	  }
	 
	  
	  return msg;
	  
	  
	  
	  }

		//이전대출 내역
		@RequestMapping(value = "/brwList")
		public String bookList(Model model, HttpSession session,
				@RequestParam HashMap<String, String> params) {
			
			String page = "login/login";
			
			if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
				logger.info("이전대출 목록");
				page = "myPage/bookList/brwList";
			} else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
				model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
				page = "main";
			} else {
				model.addAttribute("msg","로그인이 필요한 서비스 입니다.");

			}				
			return page;			
		}
		
	//brwList 페이징 처리
	@RequestMapping("/myPageBrwList.ajax")
	@ResponseBody
	public HashMap<String, Object> myPageBrwList(
			@RequestParam HashMap<String, String> params) {
		logger.info("리스트 요청 : {}",params);
		HashMap<String, Object> brwList = service.myPageBrwList(params);
		logger.info("컨트롤러 체크포인트");
		
		return brwList;
	}

	
	
	
	
}

