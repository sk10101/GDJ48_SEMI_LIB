package com.gdj.lib.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String kiosklogin(HttpSession session, @RequestParam String id, @RequestParam String pw) {
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
	public String kiosklogout(HttpSession session) {
		logger.info("로그아웃 요청");
		session.removeAttribute("loginId");
		return "kiosk/login";
	}
	
}
