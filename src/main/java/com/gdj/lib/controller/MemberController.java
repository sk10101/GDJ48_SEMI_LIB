package com.gdj.lib.controller;

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
		
		return "redirect:/memberDetail.do";
	}
	
	
	@RequestMapping(value = "/memberDetail.do")
	public String memberDetail(Model model, @RequestParam String mb_id) {
		
		
		logger.info("회원정보 상세보기 할 아이디 : "+mb_id);
		MemberDTO dto = new MemberDTO();
		dto.setMb_id("admin");
		service.memberDetail(dto);
		
		
		model.addAttribute("memberDetail", dto);
		return "myPage/info/memberDetail";
	}
	
	
	
	
	
	
	
	
	
}
