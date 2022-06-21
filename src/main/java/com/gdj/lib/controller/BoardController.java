package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.service.BoardService;

@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardService service;
	
	// 건의사항 목록 띄우기
	@RequestMapping(value = "/claimList", method = RequestMethod.GET)
	public String home(Model model) {
		
		// claimList 에 리스트 보내기
		logger.info("건의사항 리스트 요청");
		ArrayList<BoardDTO> claimList = service.claimList();
		logger.info("건의사항 게시글의 개수 : " + claimList.size());
		model.addAttribute("claimList",claimList);
		
		return "myPage/claim/claimList";
	}
	
	
	@RequestMapping(value = "/claimWrite.go")
	public String writeForm() {
		logger.info("건의사항 글쓰기 페이지 이동");
		
		return "myPage/claim/claimWrite";
	}
	
	
	// 건의사항 글쓰기 + 이미지 파일 업로드
	@RequestMapping(value = "/claimWrite.do")
	public String write(MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
		logger.info("글쓰기 요청 : " + params);
		
		return service.claimWrite(photos, params);
	}
	
	
	// 건의사항 글 상세 보기
	@RequestMapping(value = "/claimDetail")
	public String detail(Model model, @RequestParam int claim_id) {
		logger.info("상세보기 요청 : " + claim_id);
		
		service.claimDetail(model, claim_id);
		
		return "myPage/claim/claimDetail";
	}

}

