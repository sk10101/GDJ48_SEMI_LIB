package com.gdj.lib.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.service.BoardService;

@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardService service;
	
	//공지사항 페이지 이동
		@RequestMapping(value= "/notice.go")
		public String notice() {
			logger.info("공지사항 페이지 이동");
			return "redirect:/list.do";
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
		
		//공지사항 리스트 요청
		@RequestMapping(value="/list.do")
		public String list(Model model, HttpSession session) {
			logger.info("리스트 요청");
			ArrayList<BoardDTO> list = service.list();
			logger.info("list 갯수 : "+list.size());
			model.addAttribute("list", list);
			return "notice/notice";
		}
		
}