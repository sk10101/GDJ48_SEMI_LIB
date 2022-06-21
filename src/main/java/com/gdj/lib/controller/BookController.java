package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;
<<<<<<< HEAD
import java.util.Locale;

import javax.servlet.http.HttpSession;
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.ResponseBody;
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BookService;

@Controller
public class BookController {
<<<<<<< HEAD
	
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BookService service;
	
<<<<<<< HEAD
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
	
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
	@RequestMapping(value = "/bookList.go")
	public String bookList(Model model) {
		
		model.addAttribute("도서목록페이지로 이동");
		
		logger.info("도서 목록 요청"); 
		ArrayList<BookDTO> list = service.list();
		logger.info("list 갯수 :"+list.size());
		model.addAttribute("list",list);				
		return "admin/book/bookList";
	}
	
	@RequestMapping(value = "/bookDetail.do")
	public String bookDetail(Model model, @RequestParam String b_id) {
		
		logger.info("도서 상세보기 요청"); 
		BookDTO dto = service.detail(b_id);
		model.addAttribute("dto",dto);
		
<<<<<<< HEAD
		return "book/bookDetail";
=======
		return "admin/book/bookDetail";
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
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
		
<<<<<<< HEAD
		model.addAttribute("도서추가페이지로 이동");
		return "admin/book/bookAdd";
	}
	
	// 도서 검색 결과 ---->
=======
		logger.info("도서추가페이지로 이동");
		return "admin/book/bookAdd";
	}
	
	@RequestMapping(value = "/bookAdd.do")
	public String bookAddForm(Model model, 
			@RequestParam HashMap<String, String> params) {
		logger.info("params : {}", params);
		service.bookAdd(params);
		//String page = "redirect:/bookList.go";
		return "redirect:/bookList.go";
	}
	
// 도서 검색 결과 ---->
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
	@RequestMapping(value = "/bookSearch.do")
	public String bookSearch(Model model, 
			@RequestParam HashMap<String, String> params) {
		
<<<<<<< HEAD
		model.addAttribute("도서검색결과로 이동");	
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
		logger.info("도서 목록 요청 : {}",params); 
		ArrayList<BookDTO> dto = service.bookSearch(params);
		logger.info("list 갯수 :"+dto.size());
		model.addAttribute("dto",dto);				
		return "book/bookSearch";
	}
<<<<<<< HEAD
	
//	@RequestMapping(value = "/brw.do")
//	public String write(HttpSession session, Model model,
//			@RequestParam HashMap<String, String> params) {
//		
//		String page = "redirect:/book/bookDetail?b_id="+params.get("b_id");
//		service.brw(params);
//	
//		return page;
//	}
	
	
	
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
}
