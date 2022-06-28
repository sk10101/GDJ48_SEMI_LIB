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
import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.service.BrwBookService;

@Controller
public class BrwBookController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BrwBookService service;
	
	@RequestMapping(value = "/brwHistory")
	public String history(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		
		
		logger.info("대출내역 목록"); 
		
		ArrayList<BrwBookDTO> history = service.history(params);
		logger.info("list 갯수 :"+history.size());
		model.addAttribute("history",history);
			
		return "myPage/bookList/brwHistory";
	}
	
	@RequestMapping(value = "/brwList")
	public String bookList(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		
		
		logger.info("이전대출 목록"); 
		
		ArrayList<BrwBookDTO> bookList = service.bookList(params);
		logger.info("list 갯수 :"+bookList.size());
		model.addAttribute("bookList",bookList);
			
		return "myPage/bookList/brwList";
		
	}
	
	@RequestMapping(value = "/reserve")
	public String reserve(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		
		
		logger.info("이전대출 목록"); 
		
		ArrayList<BrwBookDTO> reserve = service.reserve(params);
		logger.info("list 갯수 :"+reserve.size());
		model.addAttribute("reserve",reserve);
			
		return "myPage/bookList/reserve";
		
	}
	
	
	@RequestMapping(value = "/bookDetail.do")
	public String bookDetail(Model model, @RequestParam String b_id) {
		
		logger.info("도서 상세보기 요청 : "+ b_id); 
		BrwBookDTO dto = service.detail(b_id);
		model.addAttribute("dto",dto);
		
		return "redirect:/bookDetail.do?b_id="+b_id;
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
		
	@RequestMapping(value = "/bookreserve.ajax")
	@ResponseBody
	public String bookreserve(HttpSession session, Model model,
			@RequestParam String b_id) {
		
		String page = "redirect:/";
		logger.info("기존 도서 상세보기 페이지"+b_id);
		service.bookreserve(b_id);
		
		return "redirect:/bookDetail?b_id="+b_id;
	
		
	}
	
	@RequestMapping(value = "/reserveBtn.ajax")
	@ResponseBody
	public String reserveBtn(HttpSession session, Model model,
			@RequestParam String brw_id) {
		
		String page = "redirect:/";
		logger.info("예약기능"+brw_id);
		service.reserveBtn(brw_id);
		
		
		//service.bookreserve(b_id);
		
		return "myPage/bookList/reserve";
	
		
	}
	
	
	@RequestMapping(value = "/bookDel.ajax")
	@ResponseBody
	public String bookDel(HttpSession session, Model model,
			@RequestParam String reserve_id) {
		
		String page = "redirect:/myPage/bookList/reserve";
		logger.info("예약내역 리스트"+reserve_id);
		service.del(reserve_id);
		
		return "redirect:/reserve";
		
	}
	
	@RequestMapping(value = "/reserveBookbrw.ajax")
	@ResponseBody
	public String reserveBookBrw(HttpSession session, Model model, 
			@RequestParam HashMap<String, String> params) {
		
		String page = "redirect:/";
		logger.info("받아온 예약번호, 책번호 : "+ params );
		service.reserveBookBrw(params);
		
		return "redirect:/reserve";
		
		
	}
	
	
	@RequestMapping(value = "/bookBrwDetail.ajax")
	@ResponseBody
	public String bookBrwDetail(HttpSession session, Model model,
			@RequestParam String b_id) {
		
		String page = "redirect:/myPage/bookList/reserve";
		logger.info("대출신청 : "+b_id);
		service.bookBrwDetail(b_id);
		
		return "redirect:/reserve";
		
	}
	
	
	
}












