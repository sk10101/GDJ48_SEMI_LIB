package com.gdj.lib.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gdj.lib.dao.BoardDAO;
import com.gdj.lib.dto.BoardDTO;

@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired BoardDAO dao;
	
	public ArrayList<BoardDTO> claimList() {
		logger.info("리스트 서비스 요청");
		
		return dao.claimList();
	}
	
	
	// 건의사항 글쓰기폼 (나중에 로그인했을 때 아이디 받아오는 것 추가해야함)
		public String claimWrite(MultipartFile[] photos, HashMap<String, String> params) {
			
			BoardDTO dto = new BoardDTO();
			dto.setClaim_title(params.get("claim_title"));
			// claimDto.setMb_id(params.get("mb_id"));
			// 일단 임시로 tester 계정 사용
			dto.setMb_id("tester");
			dto.setClaim_content(params.get("claim_content"));
			// 기본적으로 건의사항을 작성하면 status 는 미처리가 된다.
			dto.setStatus("미처리");
			
			// 건의사항 글 작성 성공여부 확인
			int row = dao.claimWrite(dto);
			logger.info(row + "개의 건의사항 작성 성공");
			
			// 실행 후 Parameter 에 담긴 claim_id 추출
			int claim_id = dto.getClaim_id();
			logger.info("방금 넣은 글 번호 : " + claim_id);
			logger.info("photos : " + photos);
			
			// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
			/*
			if(row > 0) {
			}
			*/
			return "redirect:/claimList";
		}
	
}
