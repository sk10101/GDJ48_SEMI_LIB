package com.gdj.lib.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gdj.lib.dao.BoardDAO;
import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.PhotoDTO;

@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired BoardDAO dao;
	/*
	public ArrayList<BoardDTO> claimList() {
		logger.info("리스트 서비스 요청");
		
		return dao.claimList();
	}
	*/
	
	public HashMap<String, Object> claimList(@RequestParam HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		String mb_id = params.get("mb_id");
		String mb_class = params.get("mb_class");
		
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : " + page);
		logger.info("로그인한 아이디 : " + mb_id);
		
		ArrayList<BoardDTO> claimList = new ArrayList<BoardDTO>();
		ArrayList<BoardDTO> searchList = new ArrayList<BoardDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = dao.allCount();
		if(mb_id != null) {
			allCnt = dao.claimCount(mb_id);
		}
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
		
		
		// 검색 관련 설정하는 조건문
		if(word == null || word.equals("")) {
			// 관리자 건의사항 목록 페이지에선 아이디 상관없이 모두 보여줘야함
			if (mb_class.equals("관리자")) {
				claimList = dao.allClaimList(cnt, offset);
			} else {
				claimList = dao.claimList(cnt, offset, mb_id);
			}
			
			map.put("claimList", claimList);
			
		} else {
			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			
			if (mb_class.equals("관리자")) {
				if(option.equals("제목")) {
					searchList = dao.allSubjectSearch(cnt,offset,word);
					logger.info("제목 옵션 설정");
				} else if(option.equals("처리상태")) {
					searchList = dao.allStatusSearch(cnt,offset,word);
					logger.info("처리상태 옵션 설정");			
				} else {
					searchList = dao.allWriterSearch(cnt,offset,word);
					logger.info("작성자 옵션 설정");	
				}
			} else {
				// 검색 옵션에 따라 SQL 문이 달라지기 때문에 조건문으로 분리했음
				if(option.equals("제목")) {
					searchList = dao.subjectSearch(cnt,offset,word,mb_id);
					logger.info("제목 옵션 설정");
				} else if(option.equals("처리상태")) {
					searchList = dao.statusSearch(cnt,offset,word,mb_id);
					logger.info("처리상태 옵션 설정");			
				} else {
					searchList = dao.writerSearch(cnt,offset,word,mb_id);
					logger.info("작성자 옵션 설정");	
				}
			}
			
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("claimList", searchList);
			
		}
		logger.info("서비스 체크포인트");
		return map;
	}
	
	
	// 건의사항 글쓰기폼 (나중에 로그인했을 때 아이디 받아오는 것 추가해야함)
	public String claimWrite(MultipartFile[] photos, HashMap<String, String> params) {
		
		BoardDTO dto = new BoardDTO();
		
		dto.setClaim_title(params.get("claim_title"));
		// claimDto.setMb_id(params.get("mb_id")); ==========================
		// 일단 임시로 tester 계정 사용 ==========================
		dto.setMb_id(params.get("loginId"));
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
			claimFileSave(photos, claim_id, 2);
		}
		// 일단 리스트로 보내고 나중에 detail 로 변경 ==========================
		// return "redirect:/claimDetail?claim_id="+claim_id;
		return "redirect:/claimList";
	}
	
	public void claimFileSave(MultipartFile[] photos, int post_id, int category_id) {
		
		// 카테고리 번호 전달(1. 공지사항, 2. 건의사항, 3. 답변)
		int category = category_id;
		
		// 이미지 파일 업로드
		for (MultipartFile photo : photos) {
			String oriFileName = photo.getOriginalFilename();
			
			// 이미지 파일을 업로드 안했을 때를 제외하기 위한 조건문 처리
			if(!oriFileName.equals("")) {
				logger.info("업로드 진행");
				// 확장자 추출
				String ext = oriFileName.substring(oriFileName.lastIndexOf(".")).toLowerCase();
				// 새 파일 이름으로 업로드 당시 시간을 붙인다.
				String newFileName = System.currentTimeMillis() + ext;
				
				logger.info(oriFileName + " ===> " + newFileName);
				
				try {
					byte[] arr = photo.getBytes();
					Path path = Paths.get("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\" + newFileName);
					// 같은이름의 파일이 나올 수 없기 떄문에 옵션 설정 안해도된다.
					Files.write(path, arr);
					logger.info(newFileName + " SAVE OK");
					// 4. 업로드 후 photo 테이블에 데이터 입력
					dao.claimFileWrite(oriFileName,newFileName,post_id,category);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	
	public void claimDetail(Model model, int claim_id) {
		
		// 건의사항 글 정보
		BoardDTO dto = dao.claimDetail(claim_id);
		// 답변 글 정보
		// 건의사항 글에 올려진 이미지 정보
		ArrayList<PhotoDTO> claimPhotoList = dao.claimPhotoList(claim_id,2);
		model.addAttribute("claim", dto);
		model.addAttribute("claimList", claimPhotoList);
	}


	public String claimUpdate(MultipartFile[] photos, HashMap<String, String> params) {
		
		int claim_id = Integer.parseInt(params.get("claim_id"));
		String status = params.get("status");
		int row = 0;
		String page = "";
		
		if(status==null) {
			row = dao.claimUpdate(params);
			page = "redirect:/claimDetail?claim_id="+claim_id;
		} else {
			row = dao.adminClaimUpdate(status, claim_id);
			page = "redirect:/adminClaimDetail?claim_id="+claim_id;
		}
		if(row > 0) {
			claimFileSave(photos, claim_id, 2);
		}
		
		return page;
	}


	public void claimDel(int claim_id) {
		
		BoardDTO dto = new BoardDTO();
		// 해당 claim_id 에 사진이 있는지 확인(어떤 사진들이 있는지 이름 확보)
		ArrayList<PhotoDTO> claimPhotoList = dao.claimPhotoList(claim_id,2);
		logger.info(claim_id + " 번 게시물에 업로드된 사진 수 : " + claimPhotoList.size());
		
		// 답변이 있는지 확인
		ArrayList<BoardDTO> claimReplyId = dao.claimReplyList(claim_id);
		// 답변이 있다면 같이 삭제
		if(claimReplyId.size()!=0) {
			dto.setReply_id(dao.getReplyId(claim_id));
			ArrayList<PhotoDTO> replyPhotoList = dao.replyPhotoList(dto.getReply_id(),3);	
			int replyDelCount = dao.replyDel(dto.getReply_id());
			logger.info(replyDelCount + " 건의 답변 삭제 완료");
			dao.replyPhotoDel(dto.getReply_id());
			
			// 답변을 지우는데 성공하면 그때 사진도 함께 지운다.
			if(replyDelCount>0) {
				for (PhotoDTO photo : replyPhotoList) {
					File f = new File("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\" + photo.getNewFileName());
					if(f.exists()) {
						boolean success = f.delete();
						logger.info(photo.getNewFileName() + " 의 삭제 여부 : " + success);
					}
				}
				logger.info(dto.getReply_id() + " 번 게시물에 업로드된 사진 수 : " + replyPhotoList.size());
			}
		}
		int delCount = dao.claimDel(claim_id);
		// Photo DB 에서도 지워준다.
		dao.photoDel(claim_id);
		
		// 답변
		
		logger.info(delCount + " 건의 건의사항 삭제 완료");
		// claim 테이블의 데이터 삭제(이때, photo 도 자동으로 지워진다.)
		if(delCount>0) {// 성공하면 사진도 삭제
			for (PhotoDTO photo : claimPhotoList) {
				File f = new File("C:\\STUDY\\SPRING\\GDJ48_SEMI_LIB\\src\\main\\webapp\\resources\\photo\\" + photo.getNewFileName());
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

	
	// ================= 아래부터 답변 게시글 기능=============================
	
	
	
	public void replyDetail(Model model, int claim_id) {
		// 답변 글 정보
		BoardDTO dto = dao.replyDetail(claim_id);
		// 작성된 답변이 있다면 아래와 같이 실행
		if(dto!=null) {
			dto.setReply_id(dao.getReplyId(claim_id));
			// 답변 글에 올려진 이미지 정보
			ArrayList<PhotoDTO> replyPhotoList = dao.replyPhotoList(dto.getReply_id(),3);
			model.addAttribute("reply", dto);
			model.addAttribute("replyList", replyPhotoList);
		}
	}


	public String replyWrite(MultipartFile[] photos, HashMap<String, String> params) {
		
		BoardDTO dto = new BoardDTO();
		
		dto.setMb_id(params.get("loginId"));
		dto.setClaim_id(Integer.parseInt(params.get("claim_id")));
		// claimDto.setMb_id(params.get("mb_id")); ==========================
		// 일단 임시로 tester 계정 사용 ==========================
		dto.setReply_content(params.get("reply_content"));
		
		// 건의사항 글 작성 성공여부 확인
		int row = dao.replyWrite(dto);
		logger.info(row + "개의 답변 작성 성공");
		
		// 실행 후 Parameter 에 담긴 reply_id 추출
		int reply_id = dto.getReply_id();
		int claim_id = dto.getClaim_id();
		logger.info("방금 넣은 글 번호 : " + reply_id);
		logger.info("photos : " + photos);
		
		// 파일을 올리지 않아도 fileSave 가 진행되는 것을 방지하는 조건문
		if(row > 0) {
			claimFileSave(photos, reply_id, 3);
		}
		// 일단 리스트로 보내고 나중에 detail 로 변경 ==========================
		// return "redirect:/claimDetail?claim_id="+claim_id;
		return "redirect:/adminClaimDetail?claim_id="+claim_id;
	}


	public String replyUpdate(MultipartFile[] photos, HashMap<String, String> params) {
		int claim_id = Integer.parseInt(params.get("claim_id"));
		int reply_id = Integer.parseInt(params.get("reply_id"));
		int row = 0;
		
		row = dao.replyUpdate(params);
		
		if(row > 0) {
			claimFileSave(photos, reply_id, 3);
		}
		
		return "redirect:/adminClaimDetail?claim_id="+claim_id;
	}

}
