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
	
	@Autowired BoardService claimService;
	
	@RequestMapping(value = "/claimList", method = RequestMethod.GET)
	public String home(Model model) {
		
		// claimList 에 리스트 보내기
		logger.info("건의사항 리스트 요청");
		ArrayList<BoardDTO> claimList = claimService.claimList();
		logger.info("건의사항 게시글의 개수 : " + claimList.size());
		model.addAttribute("claimList",claimList);
		
		return "myPage/claim/claimList";
	}
	
	
	@RequestMapping(value = "/claimWrite.go")
	public String writeForm(Model model) {
		logger.info("건의사항 글쓰기 페이지 이동");
		
		return "myPage/claim/claimWrite";
	}
	
	
	// 글쓰기 + 파일 업로드 (MultipartFiel 변수명 input name 과 동일하게 설정)
		@RequestMapping(value = "/claimWrite.do")
		public String write(Model model, MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
			logger.info("글쓰기 요청 : " + params);
			
			return claimService.claimWrite(photos, params);
		}

}

