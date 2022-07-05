package com.gdj.lib.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdj.lib.dto.KioskDTO;
import com.gdj.lib.service.KioskService;

@Controller
public class KioskController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired KioskService service;
	
	// 키오스크 로그인 페이지
	@RequestMapping(value = "/kiosk.login", method = RequestMethod.GET)
	public String kioskhome(Model model) {
		logger.info("키오스크 로그인 페이지");
		return "kiosk/login";
	}
	
	
	
	// 키오스크 로그인
	@RequestMapping(value = "/ki_login.do")	
	public String kioskLogin(HttpSession session, @RequestParam String id, @RequestParam String pw, Model model) {
		logger.info("키오스크 로그인 요청: {},{}",id,pw);
		String page="kiosk/loginFail";
		String loginId = service.login(id,pw);
		String loginIdSeat = service.loginSeat(id);
		String mb_class = service.getMbClass(id,pw);
		// logger.info(loginIdSeat);
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowTime = sdf.format(now);
		// logger.info(nowTime);
		
		
		// System.out.println(val1);
		// System.out.println(val2);
		
		if (loginId != null && mb_class != null) {
			session.setAttribute("loginId", loginId);
			session.setAttribute("mb_class", mb_class);
			
			if (loginIdSeat == null) {
				page = "kiosk/main";				
			} else {
				long val1 = Long.parseLong(loginIdSeat);
				long val2 = Long.parseLong(nowTime);
				
				if (val1 > val2) {
					page = "kiosk/mainSeatOut";
				} else {
					page = "kiosk/main";
				}
			}
			if(mb_class.equals("블랙리스트")) {
				session.removeAttribute("loginId");
				session.removeAttribute("mb_class");
				model.addAttribute("msg", "귀하는 블랙리스트로 선정되어 로그인이 불가합니다. 관리자에게 문의하세요.");
				page="kiosk/login";
			}
			
		}
		
		
		return page;
	}

	
	
	// 키오스크 로그아웃
	@RequestMapping(value="/ki_logout.do")
	public String kioskLogout(HttpSession session) {
		logger.info("로그아웃 요청");
		session.removeAttribute("loginId");
		return "kiosk/login";
	}
	
	
	
	
	// 키오스크 대출 신청 페이지
	@RequestMapping(value="/ki_borrow.go")
	public String kioskBorrowPage(HttpSession session, Model model) {
		logger.info("키오스크 대출신청 아이디: "+session.getAttribute("loginId"));
		String loginId = (String) session.getAttribute("loginId");
		
		String page = "kiosk/borrow";
		int chkPenalty = service.chkPenalty(loginId);
		logger.info("이용정지내역 건수 : " + chkPenalty);
		if(chkPenalty > 0) {
			page = "kiosk/main";
			model.addAttribute("msg","연체이력이 존재해 대출서비스를 이용할 수 없습니다.");
		}
		
		
		ArrayList<KioskDTO> list = service.list(loginId);
		logger.info("list 갯수: "+list.size());
		model.addAttribute("list", list);
		return page;
	}
	
	
	
	// 키오스크 메인 화면 돌아가기
	@RequestMapping(value = "/ki_main.go")
	public String kioskMain(Model model) {
		logger.info("키오스크 메인 페이지");
		return "kiosk/main";
	}
	
	// 키오스크 메인 화면 (좌석 반납) 돌아가기
	@RequestMapping(value = "/ki_mainSeatOut.go")
	public String kioskMainSeatOut(Model model) {
		logger.info("키오스크 메인 페이지");
		return "kiosk/mainSeatOut";
	}
	
	
	// 키오스크 대출하기
	@RequestMapping("/borrow.ajax")
	@ResponseBody
	public HashMap<String, Object> kioskborrow(HttpSession session, @RequestParam(value="borrowList[]") ArrayList<String> borrowList){
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("borrowList : "+borrowList);
		
		// 로그인 ID 확인
		String loginId = (String) session.getAttribute("loginId");
			
		// 대출테이블에 대출 내역 insert
		int borrowTable = service.borrowTable(loginId, borrowList);
		
		// 도서테이블에서 도서 상태를 대출중, 예약가능 여부를 1로
		int cnt = service.borrow(borrowList);
		// 예약테이블 사유 = 취소
		service.updateR(borrowList);
		map.put("cnt", cnt);
		
		return map;
	}
	
	
	
	// 키오스크 대출 성공 페이지 
	@RequestMapping(value = "/ki_borrowSuccess.go")
	public String kioskBorrowSuccess(Model model) {
		logger.info("키오스크 성공 알람 페이지");
		model.addAttribute("msg", "대출");
		return "kiosk/success";
	}
	
	
	
	// 키오스크 반납 페이지
	@RequestMapping(value="/ki_return.go")
	public String kioskReturnPage(HttpSession session, Model model) {
		logger.info("키오스크 반납 신청 아이디: "+session.getAttribute("loginId"));
		String loginId = (String) session.getAttribute("loginId");
		
		// loginId가 대출한 책이 연체 되었는지 확인
		int chkReturnOver = service.chkReturnOver(loginId);
		if(chkReturnOver > 0) {
			// 연체 페널티가 부과되었는지 확인
			int chkPenalty = service.chkPenalty(loginId);
			// 페널티 부과된 내용이 없다면
			if (chkPenalty == 0) {
				// 연체 페널티 부과
				service.insertPenalty(loginId);
			}
		}
		
		// loginId가 대출중인 목록 보여주기
		ArrayList<KioskDTO> returnList = service.returnList(loginId);
		logger.info("list 갯수: "+returnList.size());
		model.addAttribute("list", returnList);
		return "kiosk/return";
	}
	
	
	
	// 키오스크 반납하기
	@RequestMapping("/return.ajax")
	@ResponseBody
	public HashMap<String, Object> kioskReturn(HttpSession session, @RequestParam(value="returnList[]") ArrayList<String> returnList){
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("returnList : "+returnList);
		
		String loginId = (String) session.getAttribute("loginId");
		
		// 대출 테이블에 대출상태를 반납으로
		int cnt = service.bookReturn(returnList);
		map.put("cnt", cnt);
		
		// 도서 테이블에 도서상태를 도서준비중으로
		service.updateB(returnList);
		
		// 연체 확인 위해 대출테이블에 회원아이디를 이용해 남은 대출 조회
		int notReturn = service.notReturn(loginId);
		System.out.println("미반납: "+notReturn);
		
		// 책을 모두 반납했을 때
		if (notReturn == 0) {
			// 가장 마지막 반납 정보
			long returnDate = service.returnDate(loginId);
			// System.out.println("반납 예정일 : "+returnDate);
			long returnFinish = service.returnFinish(loginId);
			// System.out.println("반납 완료일 : "+returnFinish);
			
			// 반납완료일이 반납예정일보다 크면(연체라면)
			if (returnFinish > returnDate) {
				service.penaltyEndDate(loginId);
			}
		}
		
		return map;
		
	}
	
	
	// 키오스크 반납 성공 페이지 
	@RequestMapping(value = "/ki_returnSuccess.go")
	public String kioskReturnSuccess(Model model) {
		logger.info("키오스크 성공 알람 페이지");
		model.addAttribute("msg", "반납");
		return "kiosk/success";
	}
}
