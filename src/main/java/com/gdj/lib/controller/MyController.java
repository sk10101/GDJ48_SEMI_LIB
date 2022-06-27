package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;

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
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		logger.info("mb_id : "+myUpdateDetail.getMb_id());
		logger.info("mb_pw : "+myUpdateDetail.getMb_pw());
		logger.info("name : "+myUpdateDetail.getName());
		logger.info("phone : "+myUpdateDetail.getPhone());
		
		model.addAttribute("myUpdateDetail", myUpdateDetail);
		
		return "myPage/info/memberDetail";
	}
	

	@RequestMapping(value = "/myUpdate")
	public String myUpdate(Model model, HttpServletRequest request, String Oripw_chk) {
		
	
		
		
		String mb_id = request.getParameter("mb_id");
		String mb_pw = request.getParameter("mb_pw");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		
		String pw_chk = request.getParameter("pw_chk");
		
		
		
		logger.info("수정할 아이디 : "+mb_id);
		logger.info("수정할 이름 : "+name);
		logger.info("수정할 비번 : "+mb_pw);
		logger.info("수정할 전화번호 : "+phone);
		
		logger.info("PW 확인 : "+pw_chk);
		logger.info("원래 비밀 번호 : "+Oripw_chk);
		
		
		 if(pw_chk.equals(Oripw_chk)) {
			
			 if(mb_pw == "") {
				 service.myUpdateTwo(mb_id,name,phone);
			 } else {
				 service.myUpdate(mb_id,mb_pw,name,phone);
			 }
				
		} else {
			// 알림창이 안뜸
			model.addAttribute("msg" , "비밀번호가 일치하지 않습니다.");
		}
		
		
		return "redirect:/myUpdateDetail?mb_id="+mb_id;
	}
	
	@RequestMapping(value = "/CancelMySecession.ajax")
	@ResponseBody
	public HashMap<String, Object> CancelMySecession() {
		
		return null;
	}
	
	
	@RequestMapping(value = "/MySecession.ajax")
	@ResponseBody
	public HashMap<String, Object> MySecession() {
		
		return null;
	}
	
	
	
	
}
