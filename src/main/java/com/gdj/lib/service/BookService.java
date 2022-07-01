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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gdj.lib.dao.BookDAO;
import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.PhotoDTO;


@Service
public class BookService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BookDAO dao;
	
	public HashMap<String, Object> bookSearch(
			@RequestParam HashMap<String, String> params) {
		
		logger.info("검색 서비스 도착: {}",params);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		
		logger.info("보여줄 페이지 :" + page);
		
		ArrayList<BookDTO> searchList = new ArrayList<BookDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = dao.allCount();
		logger.info("allCnt : " + allCnt);
		
		int pages = allCnt%cnt != 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		
		logger.info("pages : " + pages);
		if (page > pages) {
			page = pages;
		}
		map.put("pages", pages); // 최대 페이지 수
		
		int offset = cnt * (page-1);
		
		map.put("offset", offset);
		map.put("currPage", page); // 현재 페이지
		
		logger.info("offset : "+offset);		
		
		// 검색 옵션 설정
		if (option.equals("저자")){
			logger.info("선택 옵션 :"+option);
			searchList = dao.searchWriter(cnt,offset,word);
		} else if (option.equals("출판사")) {
			logger.info("선택 옵션 :"+option);
			searchList = dao.searchPublisher(cnt,offset,word);
		} else {
			logger.info("선택 옵션 :"+option);
			searchList = dao.searchTitle(cnt,offset,word);
		}
		
		logger.info("검색 결과 건수 : " + searchList.size());
		map. put("searchList",searchList);
		return map;
	}
	

	// 관리자 도서관리 서비스 시작
		public HashMap<String, Object> bookList(
				HashMap<String, String> params) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int cnt = Integer.parseInt(params.get("cnt"));
			int page = Integer.parseInt(params.get("page"));
			String word = params.get("word");
			String option = params.get("option");
			logger.info("서비스 리스트 요청 : {}", params);
			logger.info("보여줄 페이지 : " + page);
			
			ArrayList<BookDTO> bookList = new ArrayList<BookDTO>();
			ArrayList<BookDTO> searchList = new ArrayList<BookDTO>();
			
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
			//map.put("offset", offset);
			logger.info("offset : " + offset);
			
			//검색 관련 설정하는 조건문
			if(word == null || word.equals("")) {
				bookList = dao.bookList(cnt,offset);
				map.put("bookList", bookList);
			}else {
				logger.info("검색어 (옵션): "+word+ " ( " + option + ") ");
				
				if(option.equals("b_title")) {
					searchList = dao.bookTitleSearch(cnt,offset,word);
				} else if (option.equals("writer")) {
					searchList = dao.bookWriterSearch(cnt,offset,word);
				} else {
					searchList = dao.bookPublisherSearch(cnt,offset,word);
				}		
				map.put("bookList", searchList);
			}
			
			logger.info("검색결과 건수 : " +searchList.size());		
			return map;
		}

	public void detail(Model model, String b_id) {
		
		BookDTO dto = dao.detail(b_id); //book 정보 가져옴
		ArrayList<PhotoDTO> list = dao.photoList(b_id); //photo 정보 가져옴
		model.addAttribute("book", dto);
		model.addAttribute("list", list);

		logger.info("b_title :"+dto.getB_title());
		logger.info("photo:"+list);
	}

	public String bookAdd(MultipartFile[] b_img, HashMap<String, String> params) {
		logger.info("도서 추가 서비스 요청 도착");
		BookDTO dto = new BookDTO();
		dto.setB_title(params.get("b_title"));
		dto.setWriter(params.get("writer"));
		dto.setPublisher(params.get("publisher"));
		dto.setIssue(Integer.parseInt((params.get("issue"))));
				
		int row = dao.bookAdd(dto);
		
		int b_id = dto.getB_id();		
		logger.info("도서추가 완료:"+b_id);
		
		if (row > 0) {
			fileSave(b_img, b_id);
		}
		return "admin/book/bookList";
	}

	private void fileSave(MultipartFile[] b_img, int b_id) {
		// 3. 파일 업로드
		logger.info("확인 {}",b_id);
		for(MultipartFile photo : b_img) {
			String oriFileName = photo.getOriginalFilename();
			if(!oriFileName.equals("")) {
				logger.info("이미지 업로드 진행");
				// 3-2. 확장자 분리
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 3-3. 새 이름 만들기
				String newFileName = System.currentTimeMillis()+ext;
				
				logger.info(oriFileName + "=>" + newFileName); 
				
				// 3-4. 파일 받아서 저장하기
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\"+newFileName);
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
	
	public void bookUpdate(MultipartFile[] b_img, HashMap<String, String> params) {
		logger.info("도서 관리 수정 서비스 요청");
		BookDTO dto = new BookDTO();
		dto.setB_id(Integer.parseInt(params.get("b_id")));
		dto.setB_title(params.get("b_title"));
		dto.setWriter(params.get("writer"));
		dto.setPublisher(params.get("publisher"));
		dto.setIssue(Integer.parseInt((params.get("issue"))));
		dto.setB_status(params.get("b_status"));
		
		int row = dao.bookUpdate(dto);
		int b_id = dto.getB_id();
		int chk = dao.photoChk(dto);
		logger.info("파일체크 :" +chk);
		logger.info("도서수정 완료:"+b_id);
		
		if (row > 0) {
			if (chk > 0) {
				fileUpdate(b_img, b_id);
			} else {
				fileSave(b_img, b_id);
			}
		}
	}
	
	private void fileUpdate(MultipartFile[] b_img, int b_id) {
		// 3. 파일 업로드
		logger.info("수정 {}",b_id);
		for(MultipartFile photo : b_img) {
			String oriFileName = photo.getOriginalFilename();
			if(!oriFileName.equals("")) {
				logger.info("이미지 업로드 진행");
				// 3-2. 확장자 분리
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 3-3. 새 이름 만들기
				String newFileName = System.currentTimeMillis()+ext;
				
				logger.info(oriFileName + "=>" + newFileName); 
				
				// 3-4. 파일 받아서 저장하기
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\"+newFileName);
					Files.write(path,arr);
					logger.info(newFileName+" - save ok");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.fileUpdate(oriFileName, newFileName, b_id);
					
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
		}
		
	}

	

	
// 관리자 도서관리 서비스 끝
	

	
}
	
	
