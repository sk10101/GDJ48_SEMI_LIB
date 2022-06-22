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
	public String claimList(Model model) {
		
		// claimList 에 리스트 보내기
		logger.info("건의사항 리스트 요청");
		ArrayList<BoardDTO> claimList = service.claimList();
		logger.info("건의사항 게시글의 개수 : " + claimList.size());
		model.addAttribute("claimList",claimList);
		
		return "myPage/claim/claimList";
	}
	
	
	@RequestMapping(value = "/claimWrite.go")
	public String claimWriteForm() {
		logger.info("건의사항 글쓰기 페이지 이동");
		
		return "myPage/claim/claimWrite";
	}
	
	
	// 건의사항 글쓰기 + 이미지 파일 업로드
	@RequestMapping(value = "/claimWrite.do")
	public String claimWrite(MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
		logger.info("글쓰기 요청 : " + params);
		
		return service.claimWrite(photos, params);
	}
	
	
	// 건의사항 글 상세 보기
	@RequestMapping(value = "/claimDetail")
	public String claimDetail(Model model, @RequestParam int claim_id) {
		logger.info("상세보기 요청 : " + claim_id);
		
		service.claimDetail(model, claim_id);
		
		return "myPage/claim/claimDetail";
	}
	
	
	// 수정 상세 보기
	@RequestMapping(value = "/claimUpdate.go")
	public String claimUpdateForm(Model model, @RequestParam int claim_id) {
		logger.info("수정 상세보기 요청 : " + claim_id);
		// update 할땐, upHit 을 사용하지 않는 것으로 설정하기위해 아래와 같이 인자값을 추가(detail 에도 추가)
		service.claimDetail(model, claim_id);
		
		return "myPage/claim/claimUpdate";
	}
	
	
	// 건의사항 수정 상세보기 + 파일 업로드
	@RequestMapping(value = "/claimUpdate.do")
	public String claimUpdate(Model model, MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
		logger.info("수정 요청 : " + params);
		
		return service.claimUpdate(photos, params);
	}
	
	
	// 건의사항 삭제
	@RequestMapping(value = "/claimDel.do")
	public String claimDel(Model model, @RequestParam int claim_id) {
		logger.info("삭제 요청 : " + claim_id);
		
		service.claimDel(claim_id);
		
		return "redirect:/claimList";
	}
	
	
	@RequestMapping(value = "/claimSearch.do")
	public String claimSearch(Model model, @RequestParam String search, @RequestParam String option) {
		logger.info("입력한 검색어 : " + search +" ("+option+")");
		
		ArrayList<BoardDTO> searchList = service.claimSearch(search,option);
		logger.info("검색 결과의 수 : " + searchList.size());
		model.addAttribute("claimList",searchList);
		
		return "myPage/claim/claimList";
	}

}

