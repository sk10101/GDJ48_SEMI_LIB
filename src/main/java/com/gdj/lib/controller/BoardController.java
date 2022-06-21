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
			return "redirect:/noticeList.do";
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
		@RequestMapping(value = "/noticeList.do")
		public String noticeList(Model model, HttpSession session) {
			logger.info("리스트 요청");
			ArrayList<BoardDTO> noticelist = service.noticeList();
			logger.info("noticeList 갯수 : "+noticelist.size());
			model.addAttribute("noticelist", noticelist);
			return "notice/notice";
		}
		
		//공지사항 글 작성 (미완성 에러남)
		@RequestMapping(value = "/noticeWrite.do")
		public String noticeWrite(HttpSession session, Model model,
		@RequestParam HashMap<String, String>	params) {
		
			String page = "noticeWirte";
			
			logger.info("글쓰기 요청");
			logger.info("params : {}",params);
			
			if(service.noticeWrite(params) == true) {
				page = "redirect:/noticeList.do";
			}
			
			return page;
		}
		
		//공지사항 삭제 서비스
		@RequestMapping(value = "/noticeDelete.ajax")
		@ResponseBody
		public HashMap<String, Object> noticedelete(HttpSession session,
		@RequestParam(value="noticedeleteList[]") ArrayList<String> noticeDeleteList) {
			
			String page = "redirect:/noticeList.do";
			HashMap<String, Object> noticeMap = new HashMap<String, Object>();
			logger.info("noticedeleteList : "+noticeDeleteList);
			
			int cnt = service.noticeDelete(noticeDeleteList);
			noticeMap.put("msg",noticeDeleteList.size()+"개 중"+cnt+" 개 삭제 완료");
			
			return noticeMap;
			
		}
		
		//공지사항 상세보기 서비스
		@RequestMapping(value= "/noticeDetail.do")
		public String noticedetail(Model model, HttpSession session, @RequestParam String notice_id) {
			
			String page = "redirect:/noticeList.do";
			logger.info("공지사항 상세보기 서비스 요청 : "+notice_id);
			
			BoardDTO dto = service.noticeDetail(notice_id);
			model.addAttribute("dto",dto);
			page = "notice/noticeDetail";
			
			return page;
		}
		
		
		
}