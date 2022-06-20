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
	
	
	@RequestMapping(value= "/notice.go")
	public String notice() {
		return "notice/notice";
	}
	
	@RequestMapping(value= "/noticeWrite.go")
	public String noticeWrite() {
		return "notice/noticeWrite";
	}
	
	@RequestMapping(value= "/noticeDetail.go")
	public String noticeDetail() {
		return "notice/noticeDetail";
	}
	
	
	
	
}
