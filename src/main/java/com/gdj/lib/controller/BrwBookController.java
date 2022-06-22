package com.gdj.lib.controller;


import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BrwBookService;

@Controller
public class BrwBookController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookService service;
	
	@RequestMapping(value = "/brwHistory")
	public String brwHistory(Model model) {
		logger.info("이전 대출내역");
		return "myPage/bookList/brwHistory";
	}
	
	@RequestMapping(value = "/brwList")
	public String brwList(Model model) {
		logger.info("대출내역");
		return "myPage/bookList/brwHistory";
	}
	
	@RequestMapping(value = "/reserve")
	public String reserve(Model model) {
		logger.info("예약내역");
		return "myPage/bookList/reserve";
	}	
	
	@RequestMapping(value = "/bookDetail.do")
	public String bookDetail(Model model, @RequestParam String b_id) {
		
		logger.info("도서 상세보기 요청"); 
		BookDTO dto = service.detail(b_id);
		model.addAttribute("dto",dto);
		
		return "book/bookDetail";
	}
	
	
	@RequestMapping(value = "/bor.do")
	public String write(HttpSession session, Model model,
			@RequestParam HashMap<String, String> params) {
		
		String page = "redirect:/book/bookDetail?b_id="+params.get("b_id");
		logger.info(params.get("b_id"));
		service.brw(params);
	
		return page;
	}
	
	
	
}

