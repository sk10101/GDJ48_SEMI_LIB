package com.gdj.lib.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.dao.MemberDAO;
import com.gdj.lib.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired MemberDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	/*
	 * public ArrayList<MemberDTO> memberList() {
	 * 
	 * return dao.memberList(); }
	 */

	public MemberDTO detail(String mb_id) {
	
		MemberDTO dto = null;
		logger.info(mb_id+" 상세보기 서비스 요청");
		dto = dao.detail(mb_id);
		
		return dto;
	}
	
	/*
	 * public ArrayList<MemberDTO> adminList() {
	 * 
	 * return dao.adminList(); }
	 */

	public void update(HashMap<String, String> params) {
		logger.info("회원상태 수정 서비스");
		dao.update(params);
	}


	
	/*

	public ArrayList<MemberDTO> blackList() {
		
		return dao.blackList();
	}
	*/

	public MemberDTO blackDetail(String black_id) {
		logger.info("블랙리스트 상세보기 서비스 : "+black_id);
		return dao.blackDetail(black_id);
	}

	public String idget(String id) {

		return dao.idget(id);
	}

	public boolean blackAdd(HashMap<String, String> params, HttpSession session) {
		
		MemberDTO dto = new MemberDTO();
		String admin_start = (String) session.getAttribute("loginId");
		dto.setAdmin_start(admin_start);
		dto.setMb_id(params.get("mb_id"));
		dto.setBlack_reason(params.get("black_reason"));
		
		boolean success = false;
		
		if(dao.blackAdd(dto) > 0) {
			success = true;
			logger.info("성공여부 : "+success);
		}
		// 나중에 로그인 기능 추가하면 params 넣을것 (추후 수정)
		return success;
	}







	public MemberDTO penaltyDetail(String penalty_id) {
		logger.info("이용정지 리스트 상세보기 서비스 : "+penalty_id);
		return dao.penaltyDetail(penalty_id);
	}

	public void penaltyUpdate(HashMap<String, String> params) {
	      logger.info("이용정지리스트 수정 서비스");
	      dao.penaltyUpdate(params);
	   }

	public void blackUpdate(HashMap<String, String> params) {
		logger.info("블랙리스트 수정 서비스");
	      dao.blackUpdate(params);
		
	}


	public HashMap<String, Object> penaltyList(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : " + page);
		
		ArrayList<MemberDTO> searchList = new ArrayList<MemberDTO>();
		
		// 총 게시글의 개수(allCnt) / 페이지당 보여줄 개수(cnt) = 생성할 수 있는 총 페이지 수(pages)
		int allCnt = 0;
		
		map.put("cnt", cnt);
		
		if (word != null && word != "") {
			map.put("word", word);
			map.put("option", option);
		}
		// 출력할 게시글의 개수를 세어준다.
		ArrayList<BoardDTO> allCount = dao.allCount(map);
		allCnt = allCount.size();
		logger.info("allCnt : " + allCnt);
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		
		
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
			
		//검색 관련 설정하는 조건문
		if(word == null || word.equals("")) {
			ArrayList<MemberDTO> penaltyList = dao.penaltyList(cnt, offset);
			
			map.put("penaltyList", penaltyList);
		} else {
			
			  logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			  
			  // 검색 옵션에 따라 SQL 문이 달라지기 때문에 조건문으로 분리했음 
			  if(option.equals("회원ID")) { 
				  searchList= dao.memberSearch(cnt,offset,word); 
				  logger.info("회원 옵션 설정"); 
			  }  else { 
				  searchList = dao.penaltySearch(cnt,offset,word);
			  	  logger.info("제한내역 옵션 설정"); 
			  }
			 
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("penaltyList", searchList);
			
		}
		logger.info("서비스 체크포인트");
		return map;
	
	}




	
	
	

	public HashMap<String, Object> blackPaging(HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		
		logger.info("보여줄 페이지 : "+page);
		
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		ArrayList<MemberDTO> searchList = new ArrayList<MemberDTO>();
		
		//총 갯수(allCnt) / 페이지 당 보여줄 갯수(cnt) = 생성 가능한 페이지(pages)
		int allCnt = 0;
		if (word != null && word != "") {
			map.put("word", word);
			map.put("option", option);
		}
		// 출력할 게시글의 개수를 세어준다.
		ArrayList<MemberDTO> allBlackCount = dao.allBlackCount(map);
		allCnt = allBlackCount.size();
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			logger.info("검색결과가 없어 임의로 예외처리함");
			allCnt = 1;
		}
		logger.info("allCnt : " + allCnt);
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		
		int pages = allCnt % cnt > 0 ? (allCnt / cnt)+1 : (allCnt / cnt);
		if (page > pages) {
			page = pages;
		}
		logger.info("pages : "+pages);
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지
		
		int offset = (page - 1) * cnt;
		logger.info("offset : "+offset);
		
		
		// 검색 관련 설정 조건문
		if(word == null || word.equals("")) {
			list = dao.blackList(cnt, offset);
			map.put("list", list);
			
		} else {
			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			
			
			if(option.equals("회원ID")) {
				searchList = dao.blackIDSearch(cnt,offset,word);
				logger.info("회원ID 옵션 설정");
			} else if(option.equals("지정한관리자ID")) {
				searchList = dao.adStartSearch(cnt,offset,word);
				logger.info("지정한관리자ID 옵션 설정");			
			} else {
				searchList = dao.adEndSearch(cnt,offset,word);
				logger.info("해제한관리자ID 옵션 설정");	
			}	
			
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("list", searchList);
			
		}
		logger.info("서비스 체크포인트");
		return map;
	}

	public HashMap<String, Object> memberPaging(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		String mb_id = params.get("mb_id");
		String mb_class = params.get("mb_class");
		
		logger.info("보여줄 페이지 : "+page);
		
		ArrayList<MemberDTO> memberList = new ArrayList<MemberDTO>();
		ArrayList<MemberDTO> searchList = new ArrayList<MemberDTO>();
		
		map.put("cnt", cnt);
		map.put("mb_id", mb_id);
		map.put("mb_class", mb_class);
		
		//총 갯수(allCnt) / 페이지 당 보여줄 갯수(cnt) = 생성 가능한 페이지(pages)
		if (word != null && word != "") {
			map.put("word", word);
			map.put("option", option);
		}
		// 출력할 게시글의 개수를 세어준다.
		ArrayList<MemberDTO> allMemeberCount = dao.allMemeberCount(map);
		
		int allCnt = allMemeberCount.size();
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		logger.info("allCnt : "+allCnt);
		
		int pages = allCnt % cnt > 0 ? (allCnt / cnt)+1 : (allCnt / cnt);
		if (page > pages) {
			page = pages;
		}
		logger.info("pages : "+pages);
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지
		
		int offset = (page - 1) * cnt;
		logger.info("offset : "+offset);
		
		
		// 검색 관련 설정 조건문
		if(word == null || word.equals("")) {
			memberList = dao.memberList(cnt, offset);
			map.put("memberList", memberList);
			
		} else {
			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			
			
			if(option.equals("회원ID")) {
				searchList = dao.mbIDSearch(cnt,offset,word);
				logger.info("회원 옵션 설정");
			} else if(option.equals("회원이름")) {
				searchList = dao.mbNameSearch(cnt,offset,word);
				logger.info("회원이름 옵션 설정");			
			} else {
				searchList = dao.mbStatusSearch(cnt,offset,word);
				logger.info("회원상태 옵션 설정");	
			}	
			
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("memberList", searchList);
			
		}
		logger.info("서비스 체크포인트");
		
		return map;
	}

	public HashMap<String, Object> adminPaging(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		String mb_id = params.get("mb_id");
		String mb_class = params.get("mb_class");
		
		logger.info("보여줄 페이지 : "+page);
		
		ArrayList<MemberDTO> adminList = new ArrayList<MemberDTO>();
		ArrayList<MemberDTO> searchList = new ArrayList<MemberDTO>();
		
		map.put("cnt", cnt);
		map.put("mb_id", mb_id);
		map.put("mb_class", mb_class);
		
		//총 갯수(allCnt) / 페이지 당 보여줄 갯수(cnt) = 생성 가능한 페이지(pages)
		if (word != null && word != "") {
			map.put("word", word);
			map.put("option", option);
		}
		// 출력할 게시글의 개수를 세어준다.
		ArrayList<MemberDTO> allMemeberCount = dao.allMemeberCount(map);
		
		int allCnt = allMemeberCount.size();
		logger.info("allCnt : "+allCnt);
		
		// 검색결과가 없다면 SQL 문 오류가 뜨는 현상이 있음
		if(allCnt == 0) {
			// 임시 예외 처리... 다음에 코드 작성할 때 처리해봐야 할 듯
			allCnt = 1;
		}
		
		int pages = allCnt % cnt > 0 ? (allCnt / cnt)+1 : (allCnt / cnt);
		if (page > pages) {
			page = pages;
		}
		logger.info("pages : "+pages);
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); //현재 페이지
		
		int offset = (page - 1) * cnt;
		logger.info("offset : "+offset);
		
		
		// 검색 관련 설정 조건문
		if(word == null || word.equals("")) {
			adminList = dao.adminList(cnt, offset);
			map.put("adminList", adminList);
			
		} else {
			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			
			
			if(option.equals("관리자ID")) {
				searchList = dao.adIDSearch(cnt,offset,word);
				logger.info("관리자 옵션 설정");
			} else if(option.equals("관리자이름")) {
				searchList = dao.adNameSearch(cnt,offset,word);
				logger.info("관리자이름 옵션 설정");			
			} else {
				searchList = dao.adPhoneSearch(cnt,offset,word);
				logger.info("전화번호 옵션 설정");	
			}	
			
			
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("adminList", searchList);
			
		}
		logger.info("서비스 체크포인트");
		
		
		return map;
	}

	
	

	
// 관리자 > 회원 도서 관련 서비스
	
	public ArrayList<MemberDTO> memberBrw() {
		
		logger.info("관리자 > 회원 도서내역 서비스 도착");
		return dao.memberBrw();
	}	
	
	public ArrayList<BrwBookDTO> brwList(String mb_id) {
		logger.info("회원대출내역 조회 서비스 도착 :"+mb_id);
		return dao.brwList(mb_id);
	}
	
	public HashMap<String, Object> hisList(HashMap<String, String> params) {
		logger.info("이전대출내역 조회 서비스 도착 :"+params);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String option = params.get("option");
		String word = params.get("word");
		String mb_id = params.get("mb_id");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : " + page);
		
		ArrayList<BrwBookDTO> hisList = new ArrayList<BrwBookDTO>();
		ArrayList<BrwBookDTO> searchList = new ArrayList<BrwBookDTO>();
		
		
		int allCnt = dao.allHisCount(mb_id);
		
		logger.info("allCnt : "+allCnt);	
		
		int pages = allCnt%cnt > 0 ? (allCnt/cnt)+1 : (allCnt/cnt);
		logger.info("pages : "+pages);
		
		if(page > pages) {
			page = pages;
		}
		
		map.put("pages", pages); // 만들 수 있는 최대 페이지 수
		map.put("currPage", page); // 현재 페이지
		
		int offset = (page-1)*cnt; //1p - 0 , 2p-5, 3p-10 , 4p-15

		map.put("offset", offset);
		
		logger.info("offset : " + offset);
		
		// 검색 관련 설정하는 조건문
		if(word == null || word.equals("")) {
			hisList = dao.hisList(cnt,offset,mb_id);
			map.put("hisList", hisList);
			logger.info("검색결과 없을 경우");
		} else {
			logger.info("검색어 (옵션) : " + word+ " (" + option + ")");
			if(option.equals("도서제목")) {
				searchList = dao.allBookTSearch(cnt,offset,word,mb_id);
			} else if (option.equals("연체여부")) {
				searchList = dao.allBookRSearch(cnt,offset,word,mb_id);
			}
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("hisList", searchList);
		}
		
		logger.info("서비스 체크포인트");
		
		return map;
	}
	
	public HashMap<String, Object> reserveList(
			HashMap<String, String> params) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		String mb_id = params.get("mb_id");
		String word = params.get("word");
		String option = params.get("option");
		logger.info("서비스 리스트 요청 : {}", params);
		logger.info("보여줄 페이지 : " + page);
		
		ArrayList<BookDTO> reserveList = new ArrayList<BookDTO>();
		ArrayList<BookDTO> searchList = new ArrayList<BookDTO>();
		
		// 총 갯수(allCnt) / 페이지당 보여줄 갯수(cnt) = 생성가능한 페이지(pages)
		int allCnt = dao.allReserveCount(mb_id);
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
		
		if(word == null || word.equals("")) {
			reserveList = dao.reserveList(cnt,offset,mb_id);
			map.put("reserveList", reserveList);
		}else {
			if(option.equals("b_title")) {
				logger.info("옵션 선택 :" +option);
				searchList = dao.reserveTitleSearch(cnt,offset,word,mb_id);				
			} else {
				logger.info("옵션 선택 :" +option);
				searchList = dao.reserveReasonSearch(cnt,offset,word,mb_id);	
			}
			logger.info("검색결과 건수 : " +searchList.size());
			map.put("reserveList", searchList);
		}		
		return map;
	}
	
	public int reserveCancel(String reserve_id) {
		logger.info("예약 취소 서비스 도착"+reserve_id);
		return dao.reserveCancel(reserve_id);
		
	}

	public int blackCon(String s_id) {
		
		return dao.blackCon(s_id);
	}

	public int cancelUpdate(String b_id) {
		
		return dao.cancelUpdate(b_id);
		
	}

	public int bookStatus(String b_id) {
		
		return dao.bookStatus(b_id);
	}

	public Object reserveUpdate(String b_id) {
		// TODO Auto-generated method stub
		return dao.reserveUpdate(b_id);
	}

	public void updateMember(String id) {
		dao.updateMember(id);
		
	}

	public void blackClass(String id) {
		dao.blackClass(id);
		
	}

	public String getId(HashMap<String, String> params) {
		
		return dao.getId(params);
	}

	
	
	
	
	
}



