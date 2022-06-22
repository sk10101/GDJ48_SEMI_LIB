package com.gdj.lib.controller;

import java.util.ArrayList;
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
	public String home(Model model) {
		logger.info("키오스크 로그인 페이지");
		return "kiosk/login";
	}
	
	
	
	// 키오스크 로그인
	@RequestMapping(value = "/ki_login.do")	
	public String kioskLogin(HttpSession session, @RequestParam String id, @RequestParam String pw) {
		logger.info("키오스크 로그인 요청: {},{}",id,pw);
		String page="kiosk/loginFail";
		String loginId = service.login(id,pw);
		
		if (loginId != null) {
			session.setAttribute("loginId", loginId);
			page = "kiosk/main";
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
		ArrayList<KioskDTO> list = service.list(loginId);
		logger.info("list 갯수: "+list.size());
		model.addAttribute("list", list);
		return "kiosk/borrow";
	}
	
	
	
	// 키오스크 메인 화면 돌아가기
	@RequestMapping(value = "/ki_main.go")
	public String kioskMain(Model model) {
		logger.info("키오스크 메인 페이지");
		return "kiosk/main";
	}
	
	
	
	// 키오스크 대출하기
	@RequestMapping("/borrow.ajax")
	@ResponseBody
	public HashMap<String, Object> borrow(HttpSession session, @RequestParam(value="borrowList[]") ArrayList<String> borrowList){
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("borrowList : "+borrowList);
		
		
		String loginId = (String) session.getAttribute("loginId");
		int borrowTable = service.borrowTable(loginId, borrowList);
		
		int cnt = service.borrow(borrowList);
		service.updateR(borrowList);
		map.put("cnt", cnt);
		return map;
		
	}
	
	
	
	// 키오스크 성공 페이지 
	@RequestMapping(value = "/ki_success.go")
	public String kioskSuccess(Model model) {
		logger.info("키오스크 성공 알람 페이지");
		return "kiosk/success";
	}
	
	
	
	// 키오스크 반납 페이지
	@RequestMapping(value="/ki_return.go")
	public String kioskReturnPage(HttpSession session, Model model) {
		logger.info("키오스크 반납 신청 아이디: "+session.getAttribute("loginId"));
		String loginId = (String) session.getAttribute("loginId");
		ArrayList<KioskDTO> list = service.list(loginId);
		logger.info("list 갯수: "+list.size());
		model.addAttribute("list", list);
		return "kiosk/return";
	}
}
