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
			return "redirect:/noticelist.do";
		}
		
		//공지사항 작성 페이지 이동
		@RequestMapping(value = "/noticeWrite.go")
		public String noticewriteForm() {
			logger.info("공지사항 작성 페이지 이동");
			return "notice/noticeWrite";
		}
		
		//공지사항 상세보기 페이지 이동
		@RequestMapping(value = "/noticeDetail.go")
		public String noticedetailForm() {
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
		
		//공지사항 글 작성 (일단 보류 'mb_id' cannot be null)
		@RequestMapping(value = "/noticeWrite.do")
		public String noticewrite(HttpSession session, Model model,
		@RequestParam HashMap<String, String>	params) {
		
			String page = "noticeWirte";
			
			if(service.noticewrite(params) == true) {
				page = "redirect:/noticelist.do";
			} else {
				model.addAttribute("msg", "글쓰기에 실패 했습니다.");
			}		
			
			return page;
		}
		
		//삭제 서비스
		@RequestMapping(value = "/noticedelete.ajax")
		@ResponseBody
		public HashMap<String, Object> noticedelete(HttpSession session,
		@RequestParam(value="noticedeleteList[]") ArrayList<String> noticedeleteList) {
			
			String page = "redirect:/noticelist.do";
			HashMap<String, Object> noticemap = new HashMap<String, Object>();
			logger.info("noticedeleteList : "+noticedeleteList);
			
			int cnt = service.noticedelete(noticedeleteList);
			noticemap.put("msg",noticedeleteList.size()+"개 중"+cnt+" 개 삭제 완료");
			
			return noticemap;
			
		}
		
		
		
		
		
}