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
import com.gdj.lib.service.MyService;

@Controller
public class MyController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired MyService service;
	
	@RequestMapping(value = "/memberUpdateDetail.go")
	public String memberUpdateDetail(Model model) {
		
		return "redirect:/memberUpdateList";
	}
	
	@RequestMapping(value = "/memberUpdateList")
	public String memberUpdateList(Model model, HttpServletRequest request) {
		String page = "main";
		HttpSession memberSession = request.getSession();
		
			ArrayList<MemberDTO> memberUpdateList = service.memberUpdateList();
			logger.info("membeUpdateList 갯수 : "+ memberUpdateList.size());
			model.addAttribute("memberUpdateList", memberUpdateList);
			page  = "myPage/info/memberDetail";
		
		
		return page;
	}
	
	
	@RequestMapping(value = "/memberUpdateDetail.do")
	public String memberUpdateDetail(Model model, @RequestParam String mb_id) {
		
		
		logger.info("회원정보 상세보기 할 아이디 : "+mb_id);
		MemberDTO dto = service.memberUpdateDetail(mb_id);
		
		
		model.addAttribute("memberUpdateDetail", dto);
		
		return "myPage/info/memberDetail";
	}
	
	
	
	
	
	
	
	
	
}
