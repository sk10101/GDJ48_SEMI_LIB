package com.gdj.lib.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.service.NoticeService;

@Controller
public class NoticeController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired NoticeService service;
	
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
			ArrayList<BoardDTO> noticeList = service.noticeList();
			logger.info("noticeList 갯수 : "+noticeList.size());
			model.addAttribute("noticeList", noticeList);
			return "notice/notice";
		}
		
		//공지사항 글 작성 + 이미지 파일 업로드
		@RequestMapping(value = "/noticeWrite.do")
		public String noticeWrite(MultipartFile[] photos,
		@RequestParam HashMap<String, String>	params) {
		
			logger.info("공지사항 글쓰기 요청 : "+params);
			return service.noticeWrite(photos,params);
		}
		
		//공지사항 삭제 서비스
		@RequestMapping(value = "/noticeDelete.ajax")
		@ResponseBody
		public HashMap<String, Object> noticedelete(HttpSession session,
		@RequestParam(value="noticedeleteList[]") ArrayList<String> noticeDeleteList) {
			
			
			HashMap<String, Object> noticeMap = new HashMap<String, Object>();
			logger.info("noticedeleteList : "+noticeDeleteList);
			
			int cnt = service.noticeDelete(noticeDeleteList);
			noticeMap.put("msg",noticeDeleteList.size()+"개 중"+cnt+" 개 삭제 완료");
			
			return noticeMap;
			
		}
		
		//공지사항 상세보기 서비스
		@RequestMapping(value= "/noticeDetail.do")
		public String noticedetail(Model model, @RequestParam int notice_id) {
			
			logger.info("공지사항 상세보기 서비스 요청 : "+notice_id);
			service.noticeDetail(model, notice_id);
			
			return "notice/noticeDetail";
		}
		
		
		//공지사항 페이징 처리
		@RequestMapping("/noticeList.ajax")
		@ResponseBody
		public HashMap<String, Object> noticePageList(@RequestParam HashMap<String, String> params) {
			logger.info("리스트 요청 : {}",params);
			
			return service.noticePageList(params);
		}
		
		//공지사항 검색 기능
		@RequestMapping("/noticeSearch.ajax")
		@ResponseBody
		public HashMap<String, Object> noticeSearchList(@RequestParam HashMap<String, String> params) {
			logger.info("검색한 내용 : {}", params);
			return service.noticeSearchList(params);
		}
		
		
		
		
}