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
		@RequestMapping(value = "/notice.go")
		public String notice() {
			logger.info("공지사항 페이지 이동");
			return "redirect:/noticelist.do";
		}
		
		//공지사항 작성 페이지 이동
		@RequestMapping(value = "/noticeWrite.go")
		public String noticeWriteForm() {
			logger.info("공지사항 작성 페이지 이동");
			return "notice/noticeWrite";
		}
		
		//공지사항 상세보기 페이지 이동
		@RequestMapping(value = "/noticeDetail.go")
		public String noticeDetailForm() {
			logger.info("공지사항 상세보기 페이지 이동");
			return "notice/noticeDetail";
		}
		
		//공지사항 리스트 요청
		@RequestMapping(value = "/noticelist.do")
		public String noticelist(Model model, HttpSession session) {
			logger.info("리스트 요청");
			ArrayList<BoardDTO> noticelist = service.noticelist();
			logger.info("noticelist 갯수 : "+noticelist.size());
			model.addAttribute("noticelist", noticelist);
			return "notice/notice";
		}
		
		@RequestMapping(value = "/noticeWrite.do")
		public String noticeWrite() {
			return "notice/noticeWrite";
		}
		
		
		
		
}