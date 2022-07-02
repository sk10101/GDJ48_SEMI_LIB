package com.gdj.lib.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import com.gdj.lib.dao.MemberDAO;
import com.gdj.lib.service.LoginService;
import com.gdj.lib.service.MyService;

@Controller
public class LoginController {
	@Autowired LoginService service;
	 Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 로그인 페이지
	@RequestMapping(value = "login.go")
	public String memberhome( Model model) {
		logger.info("로그인 페이지 이동");
		
		return "/login/login";
	}
	
	
	// 회원가입 페이지
	@RequestMapping(value = "member/joinForm.go")
	public String memberjoinForm( Model model) {
		logger.info("회원가입 페이지 이동");
		
		
		return "/login/joinForm";
	}
	
	// 회원가입 시도
	@RequestMapping("member/join.ajax")
	@ResponseBody
	public HashMap<String, Object> memberjoin(
			@RequestParam HashMap<String, String> params) {
		logger.info("회원가입 : "+params);
		return service.memberjoin(params);
	}
	
	
	// 아이디 중복 체크
		@RequestMapping("member/overaly.ajax")
		@ResponseBody
		public HashMap<String, Object> memberoveraly(@RequestParam String chkId) {
			
			logger.info("아이디 중복 체크 : "+chkId);
			return service.memberoverlay(chkId);
		}
		
		
	// 이메일 중복 체크
		@RequestMapping("member/overalys.ajax")
		@ResponseBody
		public HashMap<String, Object> memberoveralys(@RequestParam String chkEmail) {
			
			logger.info("이메일 중복 체크 : "+chkEmail);
			return service.memberoverlays(chkEmail);
		}
	
	
	
		
		  @RequestMapping(value = "member/idFind") public String memberidFind(Model
		  model) { logger.info("id 찾기 페이지 이동");
		  
		  
		  return "/login/idFind"; }
		 
	
		@RequestMapping(value = "member/pwFind")
		public String pwFind( Model model) {
			logger.info("pw 찾기 페이지 이동");
			
			
			return "/login/pwFind";
		}
	
		@RequestMapping("member/idFind.ajax")
		@ResponseBody
		public String idFind(@RequestParam String email) {
			
			logger.info("아이디 찾기 : "+email);
			return service.idFind(email);
		}
		
		@RequestMapping("member/pwFind.ajax")
		@ResponseBody
		public String pwFind(@RequestParam String id,@RequestParam String email) {
			
			logger.info("비밀번호 찾기 : "+id+"/"+email);
			return service.pwFind(id,email);
		}
		
		
		
		// 로그인 
		@RequestMapping(value = "login.do")
		public String login(Model model,HttpSession session ,@RequestParam String id, @RequestParam String pw) {
			logger.info("로그인 요청 :{},{}",id,pw);
			String page="login/login"; 
			
			String loginId =service.login(id,pw); 
			String mb_class = service.getMbClass(id,pw);
			logger.info("로그인한 아이디 : "+loginId+" > "+mb_class);
			
			
			// 회원탈퇴 신청을 탈퇴로 만드는 기능
			String mb_status = String.valueOf(service.mb_status(id));
			
			logger.info(loginId+" 의 회원 상태 : "+mb_status);
			
			SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
			
			String format_time1 = format1.format(System.currentTimeMillis());
			
			logger.info("현재 시간 :"+format_time1);
			
			if(mb_status.equals("탈퇴신청")) {
				
				long leave_date = Long.valueOf(service.leave_date(loginId));
				logger.info("탈퇴신청 한 날짜 : "+leave_date);
				
				long seven = 7;
				
				long leave_dateTwo = leave_date + seven;
				
				logger.info(" + 7 은 :"+leave_dateTwo);
				
				
				if(leave_dateTwo < Integer.valueOf(format_time1)) {
					service.mySecessionCheck(id);
					model.addAttribute("msg", "탈퇴완료가 된 아이디 입니다.");
					return "main";
				}
				
				
			}
			
			if(mb_status.equals("탈퇴완료")) {
				model.addAttribute("msg", "탈퇴완료가 된 아이디 입니다.");
				return "main";
			}
			
			
			
			
			
			if(loginId != null) {
				session.setAttribute("loginId", loginId);
				// 관리자와 일반 사용자가 이용할 수 있는 서비스가 다르기 때문에 회원 등급도 같이 가져온다.
				session.setAttribute("mb_class", mb_class);
				page="main"; // 테스트용 페이지 만들어서 로그아웃 기능 확인
			}else {
				model.addAttribute("msg", "아이디 또는 비밀번호를 확인하세요");
			}
			
			return page;
		}
	
		
		// 로그아웃
		@RequestMapping(value = "logout.do")
		public String logout(Model model,HttpSession session) {
				session.removeAttribute("loginId");
				model.addAttribute("msg", "로그아웃 되었습니다");
				
			return "login/login"; 
		}
	
}
