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
	
	@RequestMapping(value = "/myUpdateDetail.go")
	public String myUpdateDetail(Model model) {
		
		return "redirect:/myUpdateList";
	}
	
	@RequestMapping(value = "/myUpdateList")
	public String myUpdateList(Model model, HttpServletRequest request) {
		String page = "main";
		HttpSession memberSession = request.getSession();
		
			ArrayList<MemberDTO> myUpdateList = service.myUpdateList();
			logger.info("membeUpdateList 갯수 : "+ myUpdateList.size());
			model.addAttribute("myUpdateList", myUpdateList);
			page  = "myPage/info/memberDetail";
		
		
		return page;
	}
	
	
	@RequestMapping(value = "/myUpdateDetail.do")
	public String myUpdateDetail(Model model, @RequestParam String mb_id) {
		
		
		logger.info("회원정보 상세보기 할 아이디 : "+mb_id);
		MemberDTO dto = service.myUpdateDetail(mb_id);
		
		
		model.addAttribute("myUpdateDetail", dto);
		
		return "myPage/info/memberDetail";
	}
	
	
	
	
	
	
	
	
	
}
