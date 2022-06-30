package com.gdj.lib.service;

import java.io.File;
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
import org.springframework.ui.Model;
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
		logger.info(row + " 공지사항 글 작성 성공");
		
		int notice_id = dto.getNotice_id();
		logger.info("방금 넣은 글 번호 : "+notice_id);
		logger.info("photos : "+ photos);
		
		if(row > 0) {
			noticeFileSave(photos, notice_id, 1);
		}
		
		return "redirect:/noticeList.do";
		
		
	}
	
	
	
	

	private void noticeFileSave(MultipartFile[] photos, int post_id, int category_id) {
		
		for(MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				
				String newFileName = System.currentTimeMillis() + ext;
				
				logger.info(oriFileName+ "===>" + newFileName);
				
				
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\" + newFileName);
					Files.write(path, arr);
					logger.info(newFileName + "저장 완료");
					dao.noticeFileWrite(oriFileName,newFileName,post_id, category_id);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		
	}

	
	public int noticeDelete(ArrayList<Integer> noticeDeleteList) {
		
		ArrayList<PhotoDTO> noticePhotoList = new ArrayList<PhotoDTO>();
		
		int cnt = 0;
		
		int photoCnt = 0;
		
		for (int notice_id : noticeDeleteList) {
			cnt += dao.noticeDelete(notice_id);
			noticePhotoList = dao.noticePhotoList(notice_id);
			photoCnt += dao.noticePhotoDelete(notice_id);
			
			logger.info(notice_id+" 번 게시물에 업로드된 사진 수 : "+noticePhotoList.size());
		}
		
		/*
		for(PhotoDTO post_id : noticePhotoList) {
			
		}
		*/
	
		// 지운 번호에 해당하는 사진을 가져오지 못해서 문제 
		logger.info("cnt 체크 : "+cnt + " / photoCnt : " +photoCnt );
		
		if (cnt > 0) {
			for (int i = 1; i <= cnt; i++) {
				
				for (PhotoDTO photo : noticePhotoList) {
					File f = new File("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\" +photo.getNewFileName());
					if(f.exists()) {
						boolean success = f.delete();
						logger.info(photo.getNewFileName() + " 의 삭제 여부 : "+ success);
					}
				}
				
			}
			noticePhotoList.clear();
		}
		
	
		
		return cnt;
	}

	
	public void noticeDetail(Model model, int notice_id) {
		BoardDTO dto = dao.noticeDetail(notice_id);
		logger.info(notice_id+" 공지사항 상세보기 서비스 요청");
		ArrayList<PhotoDTO> noticePhotoList = dao.noticePhotoList(notice_id);
		model.addAttribute("notice", dto);
		model.addAttribute("noticeList", noticePhotoList);
		
	}

	
	public HashMap<String, Object> noticePageList(HashMap<String, String> params) {
		
		HashMap<String, Object> noticePageMap = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : "+page);
		
		ArrayList<BoardDTO> noticeSearchList = new ArrayList<BoardDTO>();
		
		int allCnt = dao.noticeAllCount();
		logger.info("allCnt : "+allCnt);
		int pages = allCnt % cnt> 0 ? (allCnt / cnt)+1 : (allCnt/ cnt);
		logger.info("pages : "+pages);
		
		if(page > pages) {
			page = pages;
		}
		noticePageMap.put("pages", pages); //만들수있는 쵀대 페이지 수
		
		int offset = (page -1) * cnt;
		
		noticePageMap.put("offset", offset);
		noticePageMap.put("currPage", page); //현재 페이지
		
		
		logger.info("offset : "+offset);
		
		
		// 검색 관련 설정하는 조건문
		if(word == null || word.equals("")) {
			ArrayList<BoardDTO> noticeList = dao.noticeList(cnt, offset);
			
			noticePageMap.put("noticeList", noticeList);
		} else {
			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			
			// 검색 옵션에 따라 SQL 문이 달라지기 때문에 조건문으로 분리했음
			if(option.equals("제목")) {
				noticeSearchList = dao.subjectNoticeSearch(cnt,offset,word);
				logger.info("제목 옵션 설정");
			}
			
			logger.info("검색결과 건수 : " +noticeSearchList.size());
			noticePageMap.put("noticeList", noticeSearchList);
			
		}
		logger.info("서비스 체크포인트");
		
		return noticePageMap;
		
	}

}
