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
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.dto.MemberDTO;
import com.gdj.lib.service.MemberService;

@Controller
public class MemberController {
		
	@Autowired MemberService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	
	
	
	@RequestMapping("/adminPaging.ajax")
	@ResponseBody
	public HashMap<String, Object> adminPaging(@RequestParam HashMap<String, String>params ) {		
		logger.info("리스트 요청 : {}",params);
		return service.adminPaging(params);
	}
	  
	@RequestMapping("/memberPaging.ajax")
	@ResponseBody
	public HashMap<String, Object> memberPaging(@RequestParam HashMap<String, String>params ) {		
		logger.info("리스트 요청 : {}",params);
		return service.memberPaging(params);
	}
	
	@RequestMapping("/blackPaging.ajax")
	@ResponseBody
	public HashMap<String, Object> blackPaging(@RequestParam HashMap<String, String>params ) {		
		logger.info("리스트 요청 : {}",params);
		return service.blackPaging(params);
	}
	
	
	
	
	@RequestMapping(value = "/memberList.go")
	public String memberList( Model model, HttpSession session) {

		logger.info("관리자페이지(회원리스트)이동 & 회원리스트 요청");
		
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			//ArrayList<MemberDTO> memberList = service.memberList();
			//logger.info("회원 리스트 갯수 : "+memberList.size());	
			//model.addAttribute("memberList", memberList);	
			page = "admin/member/memberList";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		
		return page;
	}
	
	@RequestMapping(value = "/adminList.go")
	public String adminList( Model model, HttpSession session) {

		logger.info("관리자페이지(관리자리스트)이동 & 관리자리스트 요청");
		
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			//ArrayList<MemberDTO> adminList = service.adminList();
			//logger.info("관리자 리스트 수 : "+adminList.size());
			//model.addAttribute("adminList", adminList);
			page = "admin/admin/adminList";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		
		return page;
	}
	
	@RequestMapping(value = "/memberDetail.do") 
	public String memberDetail( Model model, HttpSession session, @RequestParam String mb_id) {

		logger.info("회원상세페이지 요청");
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			MemberDTO dto = service.detail(mb_id);
			model.addAttribute("dto",dto);
			page = "admin/member/memberDetail";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		
		return page;
	}	
	
	@RequestMapping(value = "/update.do")
	public String update(Model model, HttpSession session,
			@RequestParam HashMap<String, String> params) {
		
		logger.info("params : {}", params);
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			service.update(params);
			page = "redirect:/memberDetail.do?mb_id="+params.get("mb_id");
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}

		return page;
	}
	
	
	@RequestMapping(value = "/blackList.go")
	public String blackList(Model model, HttpSession session) {

		logger.info("블랙리스트 컨트롤러");
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			// ArrayList<MemberDTO> blackList = service.blackList();
			// logger.info("회원 리스트 갯수 : "+blackList.size());	
			// model.addAttribute("blackList", blackList);
			page = "admin/black/blackList";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}

		return page;
	}
	

	@RequestMapping(value = "/blackAdd.go")
	public String blackAdd(HttpSession session, Model model) {
		logger.info("블랙리스트 추가폼 도착");
		
		String page = "login/login";
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "admin/black/blackAdd";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/blackAdd.do")
	public String blackAdd(Model model, HttpSession session,@RequestParam HashMap<String, String> params) {
		
		String page = "login/login";
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			//1. 요청 들어온 회원 id랑 디비에 있는 회원 아이디가 실제 존재하는지 확인.
			String id = params.get("mb_id");
			String s_id = service.idget(id);
			//2. 맞는 id라면 그 회원정보랑 블랙리스트 테이블 조인해서 블랙리스트 테이블에 값 넣어주기
			if(s_id != null) {
				logger.info("s_id 들어옴 : "+s_id);
				int con = service.blackCon(s_id);
				if(con < 1) {
					logger.info("블랙리스트 중복확인 : " + con);
					if (service.blackAdd(params,session) == true) { 
						
						page = "redirect:/blackList.do";
					}else {	//3. 맞는 id가 아니라면 id 확인하라는 경고창이랑 페이지 유지
						logger.info("존재하지 않는 아이디");
						page = "admin/black/blackAdd";
					}
				}else {
					
					page = "redirect:/blackList.go";
				}
			}
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/blackDetail.do")
	public String blackDetail( Model model, HttpSession session,@RequestParam String black_id) {

		logger.info("블랙리스트 상세보기 요청 :"+black_id);
		
		String page = "login/login";
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			MemberDTO dto = service.blackDetail(black_id);
			model.addAttribute("dto",dto);
			page = "admin/black/blackDetail";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		
		return page;
	}
	
	@RequestMapping(value = "/blackUpdate.do")
	   public String blackUpdate(Model model, HttpSession session,
			   @RequestParam HashMap<String, String> params) {
		
		String page = "login/login";
		String admin_end = (String) session.getAttribute("loginId");
	      logger.info("params : {}", params);

	      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
	    	  if(params.get("black_cancel") == null) {
	    		  params.put("black_cancel", "false");  
	    		  
	    	  }else {
	    		  String loginId = (String) session.getAttribute("loginId");
	    		  params.put("admin_end", loginId);  
	    		  
	    		  
	    	  }

	      if(params.get("black_cancel") == null) {
	         params.put("black_cancel", "false");  
	        
	      }else {
	    	 
	         params.put("admin_end", admin_end);  
	         
	         
	      }
	      
	      if(params.get("clear") != null) {
	    	  params.put("end_reason", params.get("clear"));

	    	  
	    	  if(params.get("clear") != null) {
	    		  params.put("end_reason", "");
	    		  
	    		  
	    	  }
	    	  
	    	  service.blackUpdate(params);
	    	  page = "redirect:/blackDetail.do?black_id="+params.get("black_id");
	    	  
	      }else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
				model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
				page = "/main";
			}else {
				model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			}
	      }
	      return page;
	   }

	
	
	
	
	
	
	
	@RequestMapping(value = "/penaltyList.go")
	public String ad_penaltyList(Model model, HttpSession session)  {
		String page = "login/login";
		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "penalty/penaltyList";
		} else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자만 이용 가능한 서비스 입니다.");
			page = "main";
		} else {
			model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
			
		}
		
		
		return page;
		
		
	}
	
	
	@RequestMapping(value = "/penaltyList.ajax")
	@ResponseBody
	public HashMap<String, Object> penaltyList(
			@RequestParam HashMap<String, String> params
			) {		
		
		logger.info("리스트 요청 : {}",params);
		HashMap<String, Object> penaltyList = service.penaltyList(params);
		
		logger.info("컨트롤러 체크포인트");
		
		
		return penaltyList;
	}
	
	
	
	@RequestMapping(value = "/penaltyDetail.do")
	public String penaltyDetail(HttpSession session,Model model ,@RequestParam String penalty_id) {
		
		logger.info(penalty_id+"번 이용정지리스트 상세보기 요청");

		String page = "login/login";

		
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			MemberDTO dto = service.penaltyDetail(penalty_id);
			model.addAttribute("dto", dto);
			page = "penalty/penaltyDetail";
			
		} else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자만 이용 가능한 서비스 입니다.");
			page = "main";
		} else {
			model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
			
		}
		
		
		return page;
		
		

	}	
	

	@RequestMapping(value = "/penaltyUpdate.do")
	public String penaltyUpdate(HttpSession session,Model model,
			@RequestParam HashMap<String, String> params) {
		
		String page = "login/login";
		String admin_cancel = (String) session.getAttribute("loginId");
		logger.info("params : {}", params);
		   if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			   
			   if(params.get("cancel") == null) {
				   params.put("cancel", "false");       
			   }else {
				   params.put("admin_cancel", admin_cancel);  
				   
			   }
			   service.penaltyUpdate(params);
			    page = "redirect:/penaltyDetail.do?penalty_id="+params.get("penalty_id");
			   
			   
		   }else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
				model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
				page = "/main";
			}else {
				model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			}

		
		return page;
	}


	
	
	
	

	
//	관리자 > 회원의 도서내역
	
	@RequestMapping("/memberBrw.go")
	public String memberBook(@RequestParam String mb_id, HttpSession session, Model model) {

		logger.info("관리자 > 대출내역 요청 :"+mb_id);
		String page = "login/login";
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "admin/member/memberBrw";
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		//session.setAttribute("mb_id", mb_id);
		//String page = "admin/member/memberBrw?mb_id="+mb_id;
		return page;
	}
	
	@RequestMapping("/memberBrw.ajax")
	@ResponseBody
	public HashMap<String, Object> memberBrw(@RequestParam String mb_id) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		logger.info("회원의 대출내역 목록 요청 :"+mb_id);
		ArrayList<BrwBookDTO> list = service.brwList(mb_id);
		map.put("list", list);
		logger.info("완료:"+list+'/'+mb_id);
		return map;
	}
	
	@RequestMapping("/memberHis.go")
	public String memberHis(@RequestParam String mb_id, HttpSession session, Model model) {

		String page = "login/login";
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "admin/member/memberHis";
			logger.info("관리자 > 이전대출내역 요청 :"+mb_id);
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		return page;
	}
	
	@RequestMapping("/memberHis.ajax")
	@ResponseBody
	public HashMap<String, Object> memberHisList(
			@RequestParam HashMap<String, String> params) {

		HashMap<String, Object> map = service.hisList(params);
		
		logger.info("이전대출내역 목록 요청:"+params);
		
		return map;
	}
	
	@RequestMapping("/memberReserve.go")
	public String memberReserve(@RequestParam String mb_id, HttpSession session, Model model) {
		
		String page = "login/login";
		if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
			page = "admin/member/memberReserve";
			logger.info("관리자 > 예약내역 요청 :"+mb_id);
		}else if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
			page = "/main";
		}else {
			model.addAttribute("msg","관리자 회원만 이용가능한 서비스 입니다.");
		}
		//session.setAttribute("mb_id", mb_id);
		return page;
	}
	
	@RequestMapping("/memberReserve.ajax")
	@ResponseBody
	public HashMap<String, Object> memberReserveList(@RequestParam HashMap<String, String> params) {
		
		logger.info("예약내역 목록 요청:"+params);
		
		HashMap<String, Object> map = service.reserveList(params);
		logger.info("컨트롤러 체크포인트");
		return map;
	}
	
	@RequestMapping("/reserveCancel.ajax")
	@ResponseBody
	public int reserveCancel(@RequestParam String reserve_id) {
		
		logger.info("예약 취소 요청:"+reserve_id);
		int success = service.reserveCancel(reserve_id);
		logger.info("완료:"+success);
		return success;
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

		
	

