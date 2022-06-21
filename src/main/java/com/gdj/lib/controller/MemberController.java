package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdj.lib.dto.MemberDTO;
import com.gdj.lib.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired MemberService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/")
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
		logger.info("관리자 리스트 갯수 : "+adminList.size());
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
	
	@RequestMapping(value = "/memberBrw.do")
	public String memberBrw(Model model) {

		logger.info("관리자페이지 대출내역 요청");
		
		ArrayList<MemberDTO> memberBrw = service.memberBrw();
		logger.info("회원 리스트 갯수 : "+memberBrw.size());	
		model.addAttribute("memberBrw", memberBrw);
		
		return "admin/member/memberBrw";
	}
	
	
	@RequestMapping(value = "/memberReserve.do")
	public String memberReserve(Model model) {

		logger.info("관리자페이지 예약내역 요청");

		return "admin/member/memberReserve";
	}
	
	@RequestMapping(value = "/blackList.do")
	public String blackList(Model model) {

		logger.info("블랙리스트 컨트롤러");
		ArrayList<MemberDTO> blackList = service.blackList();
		logger.info("회원 리스트 갯수 : "+blackList.size());	
		model.addAttribute("blackList", blackList);

		return "admin/black/blackList";
	}
	
	
	
	
	
	
	
	
	
		
}
	