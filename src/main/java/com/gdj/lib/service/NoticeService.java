package com.gdj.lib.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gdj.lib.dao.BoardDAO;
import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.PhotoDTO;

@Service
public class NoticeService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardDAO dao;
	
	

	public ArrayList<BoardDTO> noticeList() {
		logger.info("공지사항 리스트 서비스 요청");
		return dao.noticeList();
	}

	public String noticeWrite(MultipartFile[] photos, HashMap<String, String> params) {
		logger.info("공지사항 글쓰기 서비스 요청");
		
		BoardDTO dto = new BoardDTO();
		dto.setMb_id("admin"); //mb_id 를 일단 admin 으로 설정
		dto.setNotice_title(params.get("notice_title"));
		dto.setNotice_content(params.get("notice_content"));
		
		int row = dao.noticeWrite(dto);
		logger.info(row + "공지사항 글 작성 성공");
		
		int notice_id = dto.getNotice_id();
		logger.info("방금 넣은 글 번호 : "+notice_id);
		logger.info("photos : "+ photos);
		
		if(row > 0) {
			noticeFileSave(photos, notice_id);
		}
		
		return "redirect:/noticeList.do";
		
		
	}
	
	
	
	

	private void noticeFileSave(MultipartFile[] photos, int notice_id) {
		for(MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				
				String newFileName = System.currentTimeMillis() + ext;
				
				logger.info(oriFileName+ "===>" + newFileName);
				
				
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:/upload/" + newFileName);
					Files.write(path, arr);
				} catch (IOException e) {
					e.printStackTrace();
				}
				logger.info(newFileName + "저장 완료");
				dao.noticeFileWrite(oriFileName,newFileName,notice_id,1);
			}
			
		}
		
	}

	public int noticeDelete(ArrayList<String> noticeDeleteList) {
		
		int cnt = 0;
		
		for (String notice_id : noticeDeleteList) {
			cnt += dao.noticeDelete(notice_id);
		}
		
		return cnt;
	}

	public BoardDTO noticeDetail(String notice_id) {
		BoardDTO dto = null;
		logger.info(notice_id+"공지사항 상세보기 서비스 요청");
		dto = dao.noticeDetail(notice_id);
		logger.info("notice content: "+dto.getNotice_content());
		return dto;
	}
}
