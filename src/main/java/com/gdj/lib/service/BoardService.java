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
			// claimDto.setMb_id(params.get("mb_id")); ==========================
			// 일단 임시로 tester 계정 사용 ==========================
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
			
			if(row > 0) {
				claimFileSave(photos, claim_id);
			}
			// 일단 리스트로 보내고 나중에 detail 로 변경 ==========================
			return "redirect:/claimDetail?claim_id="+claim_id;
		}
		
		public void claimFileSave(MultipartFile[] photos, int claim_id) {
			
			// 이미지 파일 업로드
			for (MultipartFile photo : photos) {
				String oriFileName = photo.getOriginalFilename();
				
				// 이미지 파일을 업로드 안했을 때 조건문 처리
				if(!oriFileName.equals("")) {
					logger.info("업로드 진행");
					// 확장자 추출
					String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
					// 새 파일 이름으로 업로드 당시 시간을 붙인다.
					String newFileName = System.currentTimeMillis() + ext;
					
					logger.info(oriFileName + " ===> " + newFileName);
					
					try {
						byte[] arr = photo.getBytes();
						Path path = Paths.get("C:/upload/" + newFileName);
						// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
						Files.write(path, arr);
						logger.info(newFileName + " SAVE OK");
						// 4. 업로드 후 photo 테이블에 데이터 입력
						dao.claimFileWrite(oriFileName,newFileName,claim_id,2);
						
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		}

		
		public void claimDetail(Model model, int claim_id) {
			
			// 건의사항 글 정보
			BoardDTO dto = dao.claimDetail(claim_id);
			// 건의사항 글에 올려진 이미지 정보
			ArrayList<PhotoDTO> claimPhotoList = dao.claimPhotoList(claim_id);
			model.addAttribute("claim", dto);
			model.addAttribute("claimList", claimPhotoList);
		}


		public String claimUpdate(MultipartFile[] photos, HashMap<String, String> params) {
			
			int claim_id = Integer.parseInt(params.get("claim_id"));
			int row = dao.claimUpdate(params);
			
			if(row > 0) {
				claimFileSave(photos, claim_id);
			}
			
			return "redirect:/claimDetail?claim_id="+claim_id;
		}


		public void claimDel(int claim_id) {
			
			// 해당 claim_id 에 사진이 있는지 확인(어떤 사진들이 있는지 이름 확보)
			ArrayList<PhotoDTO> claimPhotoList = dao.claimPhotoList(claim_id);
			logger.info(claim_id + " 번 게시물에 업로드된 사진 수 : " + claimPhotoList.size());
			
			int delCount = dao.claimDel(claim_id);
			// Photo DB 에서도 지우고 싶어용
			dao.photoDel(claim_id);
			
			logger.info(delCount + " 건의 건의사항 삭제 완료");
			// claim 테이블의 데이터 삭제(이때, photo 도 자동으로 지워진다.)
			if(delCount>0) {// 성공하면 사진도 삭제
				for (PhotoDTO photo : claimPhotoList) {
					File f = new File("C:/upload/" + photo.getNewFileName());
					if(f.exists()) {
						boolean success = f.delete();
						logger.info(photo.getNewFileName() + " 의 삭제 여부 : " + success);
					}
				}
				// 이미지를 지워도 파일이름이 남아있어서 비워줌
				claimPhotoList.clear();
				logger.info(claim_id + " 번 게시물에 업로드된 사진 수 : " + claimPhotoList.size());
			}
		}


		public ArrayList<BoardDTO> claimSearch(String search, String option) {
			logger.info("검색 서비스 접속");
			ArrayList<BoardDTO> searchList;
			
			if(option.equals("제목")) {
				searchList = dao.subjectSearch(search);
				logger.info("제목 옵션 설정");
			} else {
				searchList = dao.statusSearch(search);
				logger.info("상태 옵션 설정");
			}
			
			return searchList;
		}
	
}
