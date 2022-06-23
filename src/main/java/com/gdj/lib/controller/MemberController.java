package com.gdj.lib.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdj.lib.dto.MemberDTO;
import com.gdj.lib.service.MemberService;

@Controller
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MemberService service;
	
	@RequestMapping(value = "/memberDetail.go")
	public String home(Model model) {
		
		return "redirect:/memberList";
	}
	
	@RequestMapping(value = "/memberList")
	public String memberList(Model model, HttpServletRequest request) {
		String page = "main";
		HttpSession memberSession = request.getSession();
		
			ArrayList<MemberDTO> memberList = service.memberList();
			logger.info("memberList 갯수 : "+ memberList.size());
			model.addAttribute("memberList", memberList);
			page  = "myPage/info/memberDetail";
		
		
		return page;
	}
	
	
	@RequestMapping(value = "/memberDetail.do")
	public String memberDetail(Model model, @RequestParam String mb_id) {
		
		
		logger.info("회원정보 상세보기 할 아이디 : "+mb_id);
		MemberDTO dto = service.memberDetail(mb_id);
		
		
		model.addAttribute("memberDetail", dto);
		
		return "myPage/info/memberDetail";
	}
	
	
	
	
	
	
	
	
	
}
