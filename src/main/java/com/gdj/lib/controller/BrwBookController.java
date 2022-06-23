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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BrwBookService;

@Controller
public class BrwBookController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookService service;
	
	@RequestMapping(value = "/brwHistory")
	public String brwHistory(Model model, HttpSession session) {
		
		
		logger.info("이전대출 목록"); 
		
		ArrayList<BookDTO> brwList = service.brwList();
		logger.info("list 갯수 :"+brwList);
		model.addAttribute("이전대출 페이지로 이동");

//		model.addAttribute("list",list);
//		
		return "myPage/bookList/brwHistory";
	}
	
	@RequestMapping(value = "/brwList")
	public String brwList(Model model) {
		logger.info("대출내역");
		return "myPage/bookList/brwList";
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
	
	
	@RequestMapping(value = "/bookbrw.ajax")
	@ResponseBody
	public String brw(HttpSession session, Model model,
			@RequestParam String b_id) {
		
		String page = "redirect:/";
		logger.info("기존 도서 상세보기 페이지"+b_id);
		service.brw(b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	
		
	}
	
	@RequestMapping(value = "/bookreason.ajax")
	@ResponseBody
	public String reason(HttpSession session, Model model,
			@RequestParam String b_id) {
		
		String page = "redirect:/";
		logger.info("예약신청 후 페이지"+b_id);
		service.reason(b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	
		
	}
	
	
	
}












