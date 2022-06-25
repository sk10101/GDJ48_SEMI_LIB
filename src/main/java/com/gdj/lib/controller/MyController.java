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
	public String myUpdateList(Model model, HttpServletRequest request,  String mb_id) {
			String page = "main";
			HttpSession memberSession = request.getSession();
			if(memberSession.getAttribute("loginId") == null) {
				page = "login/login";
				model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			} else {
			ArrayList<MemberDTO> myUpdateList = service.myUpdateList();
			logger.info("memberList 갯수 : "+ myUpdateList.size());
			logger.info("세션 확인 : "+memberSession.getAttribute("loginId"));
			mb_id = (String) memberSession.getAttribute("loginId");
			model.addAttribute("myUpdateList", myUpdateList);
			page = "redirect:/myUpdateDetail?mb_id="+mb_id;
			}
		
		return page;
	}
	
	
	@RequestMapping(value = "/myUpdateDetail")
	public String myUpdateDetail(Model model, @RequestParam String mb_id) {
		
		
		logger.info("회원정보 상세보기 할 아이디 : "+mb_id);
		MemberDTO myUpdateDetail = service.myUpdateDetail(mb_id);
		
		
		model.addAttribute("myUpdateDetail", myUpdateDetail);
		
		return "myPage/info/memberDetail";
	}
	

	@RequestMapping(value = "/myUpdate")
	public String myUpdate(Model model, HttpServletRequest request, String mb_id,
			@RequestParam String mb_pw, @RequestParam String phone, @RequestParam String name) {
		
		HttpSession memberSession = request.getSession();
		
		mb_id = (String) memberSession.getAttribute("loginId");
		name = (String) memberSession.getAttribute("name");
		mb_pw = (String) memberSession.getAttribute("mb_pw");
		phone = (String) memberSession.getAttribute("phone");
		
		logger.info("수정할 아이디 : "+mb_id);
		logger.info("수정할 아이디 : "+name);
		logger.info("수정할 비번 : "+mb_pw);
		logger.info("수정할 이메일 : "+phone);
		
		
		service.myUpdate(mb_id,mb_pw,name,phone);
		
		return "redirect:/myUpdateDetail?mb_id="+mb_id;
	}
	
	
	
	
	
	
	
}
