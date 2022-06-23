package com.gdj.lib.service;



<<<<<<< HEAD
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
=======
>>>>>>> origin/master
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import com.gdj.lib.dao.BookDAO;
import com.gdj.lib.dto.BookDTO;


@Service
public class BookService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BookDAO dao;
<<<<<<< HEAD
	
	public HashMap<String, Object> bookSearch(HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("params :{}",params);
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		logger.info("보여줄 페이지 : "+page+option+word);
		
		int allCnt = dao.allCount();
		logger.info("allCnt : "+allCnt);		
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : "+pages);
		
		if(page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); // 만들 수 있는 최대 페이지 수
		map.put("currPage", page); // 현재 페이지
		
		int offset = (page-1)*cnt; //1p - 0 , 2p-5, 3p-10 , 4p-15
		logger.info("offset : " + offset);
		
		if (option.equals("writer")){
			logger.info("선택 옵션 :"+option +"/"+word);
			ArrayList<BookDTO> searchList = dao.searchWriter(word,cnt,offset);
			map.put("searchList", searchList);
		} else if (option.equals("publisher")) {
			logger.info("선택 옵션 :"+option);
			ArrayList<BookDTO> searchList = dao.searchPublisher(word,cnt,offset);
			map.put("searchList", searchList);
		} else {
			logger.info("선택 옵션 :"+option);
			ArrayList<BookDTO> searchList = dao.searchTitle(word,cnt,offset);
			map.put("searchList", searchList);
		}
		return map;
	}
	
	/*
	public HashMap<String, Object> bookSearch(
			HashMap<String, String> params) {
				
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : "+page);
		
		// 총갯수(allCnt) / 페이지당 보여줄 갯수(cnt) = 생성가능한 페이지(pages)
		int allCnt = dao.allCount();
		logger.info("allCnt : "+allCnt);		
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : "+pages);
		
		if(page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); // 만들 수 있는 최대 페이지 수
		map.put("currPage", page); // 현재 페이지
		
		int offset = (page-1)*cnt; //1p - 0 , 2p-5, 3p-10 , 4p-15
		logger.info("offset : " + offset);
		
		
		
		return null;	
	} */
	
	public ArrayList<BookDTO> reserveOK() {
		logger.info("예약여부서비스도착");
		return dao.reserveOk();
	}
=======
>>>>>>> origin/master

// 관리자 도서관리 서비스 시작
	public HashMap<String, Object> bookList(
			HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 : "+page);
		
		// 총 갯수(allCnt) / 페이지당 보여줄 갯수(cnt) = 생성가능한 페이지(pages)
		int allCnt = dao.allCount();
		logger.info("allCnt : "+allCnt);		
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : "+pages);
		
		if(page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); // 만들 수 있는 최대 페이지 수
		map.put("currPage", page); // 현재 페이지
		
		int offset = (page-1)*cnt; //1p - 0 , 2p-5, 3p-10 , 4p-15
		logger.info("offset : " + offset);
		
		ArrayList<BookDTO> bookList = dao.bookList(cnt, offset);
		
		logger.info("bookList : {}",bookList);
		map.put("bookList", bookList);
		
		return map;
	}

	

	public void bookUpdate(HashMap<String, String> params) {
		logger.info("도서 관리 수정 서비스 요청");
		int row = dao.bookUpdate(params);
		logger.info("수정완료 : "+row);
		
	}

	public String bookAdd(MultipartFile[] photos, HashMap<String, String> params) {
		logger.info("도서 추가 서비스 요청");
		BookDTO dto = new BookDTO();
		dto.setB_title(params.get("b_title"));
		dto.setWriter(params.get("writer"));
		dto.setPublisher(params.get("publisher"));
				
		int row = dao.bookAdd(dto);
		
		int b_id = dto.getB_id();		
		logger.info("도서추가 완료:"+b_id);
		
		/*
		if (row > 0) {
			fileSave(photos,b_id);
		}*/
		return "admin/book/bookList";
	}

	private void fileSave(MultipartFile[] photos, int b_id) {
		
		for(MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				// 3-2. 확장자 분리
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 3-3. 새 이름 만들기
				String newFileName = System.currentTimeMillis()+ext;
				
				logger.info(oriFileName + "=>" + newFileName); 
				
				// 3-4. 파일 받아서 저장하기
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("D:/upload/"+newFileName);
					Files.write(path,arr);
					logger.info(newFileName+" - save ok");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.fileWrite(oriFileName, newFileName, b_id);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
		}
		
	}

	
<<<<<<< HEAD
<<<<<<< HEAD
// 관리자 도서관리 서비스 끝
=======
//
//	public void brw(HashMap<String, String> params) {
//		logger.info("도서대출 서비스 신청"+params.get("b_id"));
//		int row = dao.brw(params);
//		logger.info("대출한 책 권수"+row);
//		
//	}
=======

>>>>>>> origin/master

	

>>>>>>> origin/master
	

	
	

}
	
	
