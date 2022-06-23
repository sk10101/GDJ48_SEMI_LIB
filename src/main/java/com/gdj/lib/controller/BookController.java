package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

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
<<<<<<< HEAD
import org.springframework.web.multipart.MultipartFile;
=======
>>>>>>> origin/master

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BookService;

@Controller
public class BookController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BookService service;
	
<<<<<<< HEAD
	// 도서 검색 결과 ---->
	/*
	@RequestMapping(value = "/book.go")
	@ResponseBody
	public String bookSearch(@RequestParam String option, 
			@RequestParam String word) {
		
		logger.info("도서 검색결과로 이동 :" + option +" / "+ word);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<BookDTO> dto = service.bookSearch(option,word);
		map.put("dto",dto);
		logger.info("dto :"+dto);
		return "book/bookSearch";
	}*/
	
	@RequestMapping("/bookSearch.ajax")
	public String searchList(HttpSession session,
			@RequestParam String option, @RequestParam String word
			) {		
		session.setAttribute("option", option);
		session.setAttribute("word", word);
		logger.info("리스트 요청 : {}",option +"/"+word);
		return "/bookSearch.go";
	}
	
	@RequestMapping("/bookSearch.go")
	public String detailPage(HttpSession session) {
		
		return "book/bookSearch";
	}
	
	@RequestMapping("/searchList.ajax")
	@ResponseBody
	public HashMap<String, Object> searchList(HttpSession session,
			@RequestParam HashMap<String, String> params) {
		logger.info("검색 도서 목록 요청 :{}",params);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String option = (String)session.getAttribute("option");
		String word = (String)session.getAttribute("word");
		params.put("option", option);
		params.put("word", word);
		//session.removeAttribute("option");
		//session.removeAttribute("word");
		
		HashMap<String, Object> searchList = service.bookSearch(params);
		map.put("searchList", searchList);
		logger.info("검색완성 : "+map.size());
		return map;
	}
	
	
	//관리자 도서관리 페이지 시작--->
	
		//도서목록
=======
	
	
>>>>>>> origin/master
	@RequestMapping(value = "/bookList.go")
	public String ad_bookList(Model model) {
		
		logger.info("관리자 > 도서목록페이지로 이동");
		return "admin/book/bookList";
	}
	
<<<<<<< HEAD
	@RequestMapping(value = "/bookList.ajax")
	@ResponseBody
	public HashMap<String, Object> bookList(
			@RequestParam HashMap<String, String> params
			) {		
		
		logger.info("리스트 요청 : {}",params);
		return service.bookList(params);
	}
	
	@RequestMapping(value = "/bookDetail.do")
	public String bookDetail(Model model, @RequestParam String b_id) {
		
		logger.info("도서 상세보기 요청"); 
		BookDTO dto = service.detail(b_id);
		model.addAttribute("dto",dto);
		
		return "admin/book/bookDetail";
	}
=======
	
>>>>>>> origin/master
	
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
	
<<<<<<< HEAD
	@RequestMapping(value = "/bookAdd.do")
	public String bookAddForm(Model model,  MultipartFile[] photos,
			@RequestParam HashMap<String, String> params) {
		logger.info("도서추가요청 : {}", params);
		service.bookAdd(photos,params);
		//String page = "redirect:/bookList.go";
		return "redirect:/bookList.go";
	}
	
=======
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
