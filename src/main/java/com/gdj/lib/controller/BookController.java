package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.condition.ParamsRequestCondition;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BookService;

@Controller
public class BookController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BookService service;
	
	// 도서 검색 결과 ---->
	@RequestMapping(value = "/bookSearch.go")
	public String bookSearch(HttpSession session,
			@RequestParam HashMap<String, String> params) {
		
		//session.setAttribute("option", params.get("option"));
		//session.setAttribute("word", params.get("word"));
		logger.info("도서 목록 요청 : {}",params);
		
		return "book/bookSearch";
	}
	
	@RequestMapping(value = "/searchList.ajax")
	@ResponseBody
	public HashMap<String, Object> searchList(HttpSession session,
			@RequestParam HashMap<String, String> params) {		
		
		logger.info("컨트롤러 리스트 요청 : {}", params);
		
		HashMap<String, Object> searchMap = service.bookSearch(params);
		//String option = (String) session.getAttribute("option");
		//String word = (String) session.getAttribute("word");
		//session.removeAttribute("option");
		//session.removeAttribute("word");
		
		//ArrayList<BookDTO> searchList = service.bookSearch(option,word);
		return searchMap;
	}
		
	//관리자 도서관리 페이지 시작--->
	
		//도서목록
	@RequestMapping(value = "/bookList.go")
	public String ad_bookList(Model model, HttpSession session) {
		logger.info("관리자 > 도서목록페이지로 이동");
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "admin/book/bookList";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		
	
		return page;
	}
	
	@RequestMapping(value = "/bookList.ajax")
	@ResponseBody
	public HashMap<String, Object> bookList(
			@RequestParam HashMap<String, String> params
			) {		
		
		logger.info("리스트 요청 : {}",params);
		HashMap<String, Object> map = service.bookList(params);
		logger.info("컨트롤러 체크포인트");
		return map;
	}
	
	@RequestMapping(value = "/AdbookDetail.do")
	public String bookDetail(Model model, @RequestParam String b_id, HttpSession session) {
		
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			logger.info("도서 상세보기 요청 : "+b_id);
			service.detail(model, b_id);
			page = "admin/book/bookDetail";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/bookAdd.go")
	public String bookAdd(Model model, HttpSession session) {
		
		logger.info("도서추가페이지로 이동");
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "admin/book/bookAdd";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/bookAdd.do")
	public String bookAddForm(Model model,  MultipartFile[] b_img,
			@RequestParam HashMap<String, String> params) {
		logger.info("도서추가요청 : {} / {}", b_img, params);
		service.bookAdd(b_img,params);
		//String page = "redirect:/bookList.go";
		return "redirect:/bookList.go";
	}
	
	@RequestMapping(value = "/bookUpdate.do")
	public String bookUpdate(Model model, MultipartFile[] b_img,
			@RequestParam HashMap<String, String> params) {
		logger.info("도서정보 수정 요청 : {} / {}",b_img, params);
		service.bookUpdate(b_img, params);
		String page = "redirect:/AdbookDetail.do?b_id="+params.get("b_id");
		return page;
	}
	

	@RequestMapping(value = "/delPhoto.ajax")
	public String delPhoto(
			@RequestParam HashMap<String, String> params) {
		logger.info("사진삭제 요청 : {}",params);
		service.delPhoto(params);
		String page = "redirect:/AdbookDetail.do?b_id="+params.get("b_id");
		logger.info("사진 삭제 완료");
		return page;
	}
	
	@RequestMapping("/bookHide.ajax")
	@ResponseBody
	public HashMap<String, Object> bookHide(HttpSession session, 
			@RequestParam(value="hideList[]") ArrayList<String> hideList) {
		
		String msg = "";
		String mb_id = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("hideList : "+hideList);
		
		if (mb_id != null && session.getAttribute("mb_class").equals("관리자")) {
			logger.info("관리자 : 도서 숨김 기능 컨트롤러");
			int cnt = service.bookHide(hideList);
			msg = hideList.size()+"개 중 " +cnt+"개 삭제 완료";
		} else {
			msg = "관리자만 이용가능합니다.";
		}
		map.put("msg", msg);
		
		return map;
	}	
	
}
