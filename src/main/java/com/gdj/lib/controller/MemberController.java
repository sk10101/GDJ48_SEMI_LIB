package com.gdj.lib.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;


import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.dto.MemberDTO;
import com.gdj.lib.service.MemberService;

@Controller
public class MemberController {
		
	@Autowired MemberService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/memberList.do")
	public String memberList( Model model) {

		logger.info("관리자페이지(회원리스트)이동 & 회원리스트 요청");
		
		ArrayList<MemberDTO> memberList = service.memberList();
		logger.info("회원 리스트 갯수 : "+memberList.size());	
		model.addAttribute("memberList", memberList);
			
		return "admin/member/memberList";
	}
	
	@RequestMapping(value = "/adminList.do")
	public String adminList( Model model) {

		logger.info("관리자페이지(관리자리스트)이동 & 관리자리스트 요청");
		ArrayList<MemberDTO> adminList = service.adminList();
		logger.info("관리자 리스트 수 : "+adminList.size());
		model.addAttribute("adminList", adminList);
		
		return "admin/admin/adminList";
	}
	
	@RequestMapping(value = "/memberDetail.do")
	public String memberDetail( Model model, @RequestParam String mb_id) {

		logger.info("회원상세페이지 요청");
		MemberDTO dto = service.detail(mb_id);
		model.addAttribute("dto",dto);
		
		return "admin/member/memberDetail";
	}	
	
	@RequestMapping(value = "/memberSearch.do")
	public String memberSearch( Model model, @RequestParam HashMap<String, String> params) {

		logger.info("검색 params : {}",params);
		//검색 값 받아오기
		//맵퍼 : select mb_id, name, mb_status from member where #{params} like '%#{params}%';
		//select mb_id, name, mb_status from member where mb_id, name, mb_status like '%#{params}%';
		//아니면 조건에 and 조건 붙여서?? 
		
		return "admin/member/memberList";
	}
	
	@RequestMapping(value = "/update.do")
	public String update(Model model,
			@RequestParam HashMap<String, String> params) {
		
		logger.info("params : {}", params);
		service.update(params);
		//관리자 사람 옵션 디폴트 어떻게 해놓는지, 상태 바꾸고 수정 눌렀을 때 그 값을 어떻게 업데이트 시키는지
		String page = "redirect:/memberDetail.do?mb_id="+params.get("mb_id");

		return page;
	}
		
	@RequestMapping(value = "/blackList.do")
	public String blackList(Model model) {

		logger.info("블랙리스트 컨트롤러");
		ArrayList<MemberDTO> blackList = service.blackList();
		logger.info("회원 리스트 갯수 : "+blackList.size());	
		model.addAttribute("blackList", blackList);

		return "admin/black/blackList";
	}

	@RequestMapping(value = "/blackAdd.go")
	public String blackAdd() {
		logger.info("블랙리스트 추가폼 도착");
		return "admin/black/blackAdd";
	}
	
	@RequestMapping(value = "/blackAdd.do")
	public String blackAdd(Model model, @RequestParam HashMap<String, String> params) {
		
		//1. 요청 들어온 회원 id랑 디비에 있는 회원 아이디가 실제 존재하는지 확인.
		String id = params.get("mb_id");
		String s_id = service.idget(id);
		String page = null;
		
		//2. 맞는 id라면 그 회원정보랑 블랙리스트 테이블 조인해서 블랙리스트 테이블에 값 넣어주기
		if(s_id != null) {
			logger.info("s_id 들어옴 : "+s_id);
			if (service.blackAdd(params) == true) { 
				page = "redirect:/blackList.do";
				model.addAttribute("msg","블랙리스트 목록에 추가되었습니다.");
			}else {	//3. 맞는 id가 아니라면 id 확인하라는 경고창이랑 페이지 유지
				logger.info("존재하지 않는 아이디");
				model.addAttribute("msg","입력한 회원 ID 를 다시 확인해주세요.");
				page = "admin/black/blackAdd";
			}
		}
		return page;
	}
	
	@RequestMapping(value = "/blackDetail.do")
	public String blackDetail( Model model, @RequestParam String black_id) {

		logger.info("블랙리스트 상세보기 요청 :"+black_id);
		MemberDTO dto = service.blackDetail(black_id);
		model.addAttribute("dto",dto);
		
		return "admin/black/blackDetail";
	}
	
	@RequestMapping(value = "/blackUpdate.do")
	   public String blackUpdate(Model model,
	         @RequestParam HashMap<String, String> params) {
	  
		
	      logger.info("params : {}", params);
	      if(params.get("black_cancel") == null) {
	         params.put("black_cancel", "false");  
	        
	      }else {
	    	 
	         params.put("admin_end", "tester");  
	         
	         
	      }
	      
	      if(params.get("clear") != null) {
	    	  params.put("end_reason", params.get("clear"));
	    	  
	      
	      }
	      
	      service.blackUpdate(params);
	      String page = "redirect:/blackDetail.do?black_id="+params.get("black_id");

	      return page;
	   }
	
	
	
	
	@RequestMapping(value = "/penaltyList.do")
	public String penaltyList(Model model) throws ParseException {
		logger.info("이용정지리스트 페이지");
		ArrayList<MemberDTO> penaltyList = service.penaltyList();
		logger.info("이용정지 회원 리스트 갯수 : "+penaltyList.size());	
		model.addAttribute("penaltyList", penaltyList);
		
		return "penalty/penaltyList";
	}
	
	@RequestMapping(value = "/penaltyDetail.do")
	public String penaltyDetail(Model model ,@RequestParam String penalty_id) {
		
		logger.info(penalty_id+"번 이용정지리스트 상세보기 요청 :");
		
		MemberDTO dto = service.penaltyDetail(penalty_id);
		model.addAttribute("dto", dto);
		return "penalty/penaltyDetail";

	}	
	
	
//	관리자 > 회원의 도서내역
	
	@RequestMapping("/memberBrw.go")
	public String memberBook(@RequestParam String mb_id, HttpSession session) {

		logger.info("관리자페이지 예약내역 요청 :"+mb_id);
		session.setAttribute("mb_id", mb_id);
		return "admin/member/memberBrw";
	}
	
	@RequestMapping("/memberBrw.ajax")
	@ResponseBody
	public HashMap<String, Object> memberBrw(HttpSession session) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String mb_id = (String) session.getAttribute("mb_id");
		logger.info("회원의 대출내역 목록 요청 :"+mb_id);
		ArrayList<BrwBookDTO> list = service.brwList(mb_id);
		map.put("list", list);
		logger.info("완료:"+list);
		return map;
	}

	@RequestMapping(value = "/penaltyUpdate.do")
	   public String penaltyUpdate(Model model,
	         @RequestParam HashMap<String, String> params) {
	       
	      logger.info("params : {}", params);
	      if(params.get("cancel") == null) {
	         params.put("cancel", "false");       
	      }else {
	         params.put("admin_cancel", "tester");  
	         
	      }
	      
	      service.penaltyUpdate(params);
	      String page = "redirect:/penaltyDetail.do?penalty_id="+params.get("penalty_id");

	      return page;
	   }
	
	
	
	
	/*
	 * @RequestMapping(value = "/penaltyUpdate.do") public String
	 * penaltyUpdateForm(Model model ,@RequestParam ) {
	 * 
	 * logger.info("수정 요청"+params); service.penaltyUpdate(params);
	 * 
	 * return "penalty/penaltyList";
	 * 
	 * }
	 */
	 


}
		
	

