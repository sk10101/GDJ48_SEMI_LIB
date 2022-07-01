package com.gdj.lib.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;

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

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.BrwBookDTO;
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
			}	
			
			else if(memberSession.getAttribute("mb_class").equals("관리자")) {
				model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
				page = "main";
			}
			
			else {
			// MemberDTO myUpdateList = service.myUpdateList();
			
			// logger.info("memberList 갯수 : "+ myUpdateList.size());
			// logger.info("세션 확인 : "+memberSession.getAttribute("loginId"));
			mb_id = (String) memberSession.getAttribute("loginId");
			
			MemberDTO myUpdateDetail = service.myUpdateList(mb_id);
			model.addAttribute("myUpdateDetail", myUpdateDetail);
			
			// logger.info("회원정보 상세보기 할 아이디 : "+mb_id);
			
			logger.info("mb_id : "+myUpdateDetail.getMb_id());
			logger.info("mb_pw : "+myUpdateDetail.getMb_pw());
			logger.info("name : "+myUpdateDetail.getName());
			logger.info("phone : "+myUpdateDetail.getPhone());
			logger.info("회원 상태 : "+myUpdateDetail.getMb_status());
			
			
			page = "myPage/info/memberDetail";
			
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
		logger.info("회원 상태 : "+myUpdateDetail.getMb_status());
		
		model.addAttribute("myUpdateDetail", myUpdateDetail);
		
		return "myPage/info/memberDetail";
	}
	

	@RequestMapping(value = "/myUpdate")
	public String myUpdate(Model model, HttpServletRequest request, String Oripw_chk) {
		

		
		String page = "redirect:/myUpdateList";
		
		String mb_id = request.getParameter("mb_id");
		String mb_pw = request.getParameter("mb_pw");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		
		String pw_chk = request.getParameter("pw_chk");
		
		MemberDTO myUpdateDetail = service.myUpdateList(mb_id);
		model.addAttribute("myUpdateDetail", myUpdateDetail);
		
		
		logger.info("수정할 아이디 : "+mb_id);
		logger.info("수정할 이름 : "+name);
		logger.info("수정할 비번 : "+mb_pw);
		logger.info("수정할 전화번호 : "+phone);
		
		logger.info("PW 확인 : "+pw_chk);
		logger.info("원래 비밀 번호 : "+Oripw_chk);
		
		
		String secession = request.getParameter("secession");
		//기본값 false 체크시 true 로 바뀜
		logger.info("회원탈퇴 체크 : "+secession);
		
		
		boolean password_check = Pattern.matches("^(?=.*[a-zA-Z]).{4,50}$", mb_pw);
		
		logger.info("비밀번호 체크 : " +password_check);
		
		/*
		if(password_check != true && mb_pw != "") {
			model.addAttribute("msg", "비밀번호 형식에 맞게 입력해 주세요.");
			 page = "myPage/info/memberDetail";
		}
		*/
		
		boolean phone_check = Pattern.matches("^[0-9]*$", phone);
		
		/*
		if(phone_check == false) {
			model.addAttribute("msg", "전화번호 형식에 맞게 입력해 주세요.");
			 page = "myPage/info/memberDetail";
		}
		*/
		
		logger.info("전화번호 체크 : "+phone_check);
		
		
		
		
		
		
		int row = service.notSecession(mb_id);
		
		if (row > 0 && secession.equals("true")) {
			model.addAttribute("msg", "※ 미반납된 도서가 있습니다. 확인후 탈퇴 신청해 주시기 바랍니다. "
					+ "  예약, 대출, 연체시 탈퇴 불가");
			
			
			// pw 확인 if 문
			 if(pw_chk.equals(Oripw_chk)) {
				// 비밀번호가 공백일때 if 문
				 if(mb_pw == "") {
					 if(phone_check == false) {
							model.addAttribute("msg", "전화번호 형식에 맞게 입력해 주세요.");
							 page = "myPage/info/memberDetail";
						} else {
							service.myUpdateTwo(mb_id,name,phone);	
						}
				 } else {
					 if(mb_pw.length() < 4) {
						 model.addAttribute("msg", "비밀번호 형식에 맞게 입력해 주세요.");
						 page = "myPage/info/memberDetail";
					 } else {
						 if(password_check == false) {
								model.addAttribute("msg", "비밀번호 형식에 맞게 입력해 주세요.");
								 page = "myPage/info/memberDetail";
							} else {
								if(phone_check == false) {
									model.addAttribute("msg", "전화번호 형식에 맞게 입력해 주세요.");
									 page = "myPage/info/memberDetail";
								} else {
									service.myUpdate(mb_id,mb_pw,name,phone);
								}
							}
					 }

				 }
					
			} else {
				model.addAttribute("msg" , "비밀번호가 일치하지 않습니다.");
				page = "myPage/info/memberDetail";
				
			}
			// 미반납 한사람이 회원 정보 변경시 새로고침 1번해야 내용 적용  why??
			model.addAttribute("myUpdateDetail", myUpdateDetail);
			page = "myPage/info/memberDetail";
			
			
		} else {
			
			if(secession.equals("true")) {
				service.mySecession(mb_id);
			} 
			
			if (secession.equals("false")) {
				service.cancelMySecession(mb_id);
			}
			
			
			// pw 확인 if 문
			 if(pw_chk.equals(Oripw_chk)) {
				// 비밀번호가 공백일때 if 문
				 if(mb_pw == "") {
					 if(phone_check == false) {
							model.addAttribute("msg", "전화번호 형식에 맞게 입력해 주세요.");
							 page = "myPage/info/memberDetail";
						} else {
							service.myUpdateTwo(mb_id,name,phone);
						}
				 } else {
					 if(mb_pw.length() < 4) {
						 model.addAttribute("msg", "비밀번호 형식에 맞게 입력해 주세요.");
						 page = "myPage/info/memberDetail";
					 } else {
						 if(password_check == false) {
								model.addAttribute("msg", "비밀번호 형식에 맞게 입력해 주세요.");
								 page = "myPage/info/memberDetail";
							} else {
								if(phone_check == false) {
									model.addAttribute("msg", "전화번호 형식에 맞게 입력해 주세요.");
									 page = "myPage/info/memberDetail";
								} else {
									service.myUpdate(mb_id,mb_pw,name,phone);
								}
							}
					 }
				 }
					
			} else {
				// 알림창이 안뜸 해결해야됨
				model.addAttribute("msg" , "비밀번호가 일치하지 않습니다.");
				page = "myPage/info/memberDetail";
				
			}
				
		}
		
		
		
			
		return page;
	}
	

	
	
}
