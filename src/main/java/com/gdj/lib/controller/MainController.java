package com.gdj.lib.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
	//공지사항 페이지 이동
	@RequestMapping(value= "/notice.go")
	public String notice() {
		logger.info("공지사항 페이지 이동");
		return "notice/notice";
	}
	
	//공지사항 작성 페이지 이동
	@RequestMapping(value= "/noticeWrite.go")
	public String noticeWrite() {
		logger.info("공지사항 작성 페이지 이동");
		return "notice/noticeWrite";
	}
	
	//공지사항 상세보기 페이지 이동
	@RequestMapping(value= "/noticeDetail.go")
	public String noticeDetail() {
		logger.info("공지사항 상세보기 페이지 이동");
		return "notice/noticeDetail";
	}
	
	
	
	
}
