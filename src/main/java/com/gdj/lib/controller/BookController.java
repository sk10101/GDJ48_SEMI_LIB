package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

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

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BookService;

@Controller
public class BookController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BookService service;
	

	@RequestMapping(value = "/bookList.go")
	public String bookList(Model model) {
		
		model.addAttribute("도서목록페이지로 이동");
		
		logger.info("도서 목록 요청"); 
		ArrayList<BookDTO> list = service.list();
		logger.info("list 갯수 :"+list.size());
		model.addAttribute("list",list);				
		return "admin/book/bookList";
	}	

	
	
	@RequestMapping(value = "/bookUpdate.do")
	public String bookUpdate(Model model, 
			@RequestParam HashMap<String, String> params) {
		
		logger.info("params : {}",params); 
		String page = "redirect:/bookDetail.do?b_id="+params.get("b_id");
		logger.info(page);
		service.bookUpdate(params);
		return page;
	}
	
	@RequestMapping(value = "/bookAdd.go")
	public String bookAdd(Model model) {
		
		model.addAttribute("도서추가페이지로 이동");
		return "admin/book/bookAdd";
	}
	
	// 도서 검색 결과 ---->
	@RequestMapping(value = "/bookSearch.do")
	public String bookSearch(Model model, 
			@RequestParam HashMap<String, String> params) {
		
		model.addAttribute("도서검색결과로 이동");	
		logger.info("도서 목록 요청 : {}",params); 
		ArrayList<BookDTO> dto = service.bookSearch(params);
		logger.info("list 갯수 :"+dto.size());
		model.addAttribute("dto",dto);				
		return "book/bookSearch";
	}
	

	
	
	
}
