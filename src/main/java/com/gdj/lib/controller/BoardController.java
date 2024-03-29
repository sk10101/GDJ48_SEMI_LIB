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
import org.springframework.web.multipart.MultipartFile;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.service.BoardService;

@Controller
public class BoardController {
   
   Logger logger = LoggerFactory.getLogger(this.getClass());
   
   @Autowired BoardService service;
   
   // 건의사항 목록페이지 이동
   @RequestMapping(value = "/claimList", method = RequestMethod.GET)
   public String claimList(Model model, HttpSession session) {
      // claimList 에 리스트 보내기
      /*
      logger.info("건의사항 리스트 요청");
      ArrayList<BoardDTO> claimList = service.claimList();
      logger.info("건의사항 게시글의 개수 : " + claimList.size());
      model.addAttribute("claimList",claimList);
      */
      
      String page = "myPage/claim/claimList";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         logger.info("건의사항 목록 페이지 이동 (일반회원만 가능)");
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      
      return page;
   }

   
   // 페이징 처리
   @RequestMapping(value = "/claimList.ajax")
   public @ResponseBody HashMap<String, Object> claimList(@RequestParam HashMap<String, String> params) {
      
      logger.info("컨트롤러 리스트 요청 : {}", params);
      
      // model.addAttribute("claimList",service.claimListPaging(params));
      HashMap<String, Object> claimMap = service.claimList(params);
      logger.info("컨트롤러 체크포인트");
      /*
      ArrayList<BoardDTO> claimList = (ArrayList<BoardDTO>) claimMap.get("claimList");
      model.addAttribute("claimList", claimList);
      */
      
      return claimMap;
   }
   
   
   @RequestMapping(value = "/claimWrite.go")
   public String claimWriteForm(Model model, HttpSession session) {
      logger.info("건의사항 글쓰기 페이지 이동");
      
      String page = "myPage/claim/claimWrite";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         logger.info("건의사항 글쓰기 페이지 이동 (일반회원만 가능)");
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      return page;
   }
   
   
   // 건의사항 글쓰기 + 이미지 파일 업로드
   @RequestMapping(value = "/claimWrite.do")
   public String claimWrite(MultipartFile[] photos, @RequestParam HashMap<String, String> params, HttpSession session) {
      logger.info("글쓰기 요청 : " + params);
      
      params.put("loginId", (String) session.getAttribute("loginId"));
      
      return service.claimWrite(photos, params);
   }
   
   
   // 건의사항 글 상세 보기
   @RequestMapping(value = "/claimDetail")
   public String claimDetail(Model model, HttpSession session, @RequestParam int claim_id) {
      logger.info("상세보기 요청 : " + claim_id);
      
      String page = "myPage/claim/claimDetail";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         logger.info("건의사항 상세보기 페이지 이동 (일반회원만 가능)");
         service.claimDetail(model, claim_id);
         service.replyDetail(model, claim_id);
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      
      return page;
   }
   
   
   // 수정 상세 보기
   @RequestMapping(value = "/claimUpdate.go")
   public String claimUpdateForm(Model model, HttpSession session, @RequestParam int claim_id) {
      logger.info("수정 상세보기 요청 : " + claim_id);

      String page = "myPage/claim/claimUpdate";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         logger.info("건의사항 수정 상세보기 페이지 이동 (일반회원만 가능)");
         service.claimDetail(model, claim_id);
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         model.addAttribute("msg","일반 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      return page;
   }
   
   
   // 건의사항 수정 상세보기 + 파일 업로드
   @RequestMapping(value = "/claimUpdate.do")
   public String claimUpdate(Model model, MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
      logger.info("수정 요청 : " + params);
      
      return service.claimUpdate(photos, params);
   }
   
   
   // 건의사항 삭제
   @RequestMapping(value = "/claimDel.do")
   public String claimDel(Model model, HttpSession session, @RequestParam int claim_id) {
      logger.info("삭제 요청 : " + claim_id);

      String page = "redirect:/claimList";
      service.claimDel(claim_id);
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
    	  page = "redirect:/adminClaimList";
      }
      
      return page;
   }
   
   /*
   // 검색 기능 (옵션 추가)
   @RequestMapping(value = "/claimSearch.do")
   public @ResponseBody HashMap<String, Object> claimSearch(Model model, @RequestParam HashMap<String, String> params) {
      logger.info("리스트 검색 : {}", params);
      logger.info("건의사항 목록 검색");
      
      HashMap<String, Object> searchList = service.claimSearch(params);
      
      return searchList;
   }
   */
   
   
   
   // ================== 아래부터 관리자 건의사항 페이지 ============================
   
   // 관리자 건의사항 목록페이지 이동
   @RequestMapping(value = "/adminClaimList", method = RequestMethod.GET)
   public String adminClaimList(Model model, HttpSession session) {
      
      String page = "admin/claim/adminClaimList";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         logger.info("건의사항 전체 목록 페이지 이동 (관리자만 가능)");
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         model.addAttribute("msg","관리자 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      return page;
   }
   
   
   // 관리자 건의사항 수정 상세보기
   @RequestMapping(value = "/adminClaimDetail")
   public String adminClaimDetail(Model model, @RequestParam int claim_id, HttpSession session) {
      logger.info("상세보기 요청 : " + claim_id);
      
      String page = "admin/claim/adminClaimDetail";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         logger.info("건의사항 상세보기 이동 (관리자만 가능)");
         service.claimDetail(model, claim_id);
         service.replyDetail(model, claim_id);
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         model.addAttribute("msg","관리자 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      
      return page;
   }
   
   
   // 관리자 건의사항 수정(처리상태만 수정가능)
   @RequestMapping(value = "/adminClaimUpdate.do")
   public String adminClaimUpdate(Model model, MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
      logger.info("건의사항 수정 요청 : " + params);
      
      return service.claimUpdate(photos, params);
   }
   
   
   // 답변 쓰기 페이지 이동
   @RequestMapping(value = "/replyWrite.go")
   public String replyWriteForm(Model model, @RequestParam int claim_id, HttpSession session) {
      
      String page = "admin/claim/replyWrite";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         logger.info("건의사항 답변 글쓰기 페이지 이동 (관리자만 가능)");
         model.addAttribute("claim_id",claim_id);
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         model.addAttribute("msg","관리자 회원만 이용 가능한 서비스 입니다.");
         page = "/main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      return page;
   }
   
   
   // 관리자 답변 작성
   @RequestMapping(value = "/replyWrite.do")
   public String replyWrite(MultipartFile[] photos, @RequestParam HashMap<String, String> params, HttpSession session) {
      logger.info("답변 글쓰기 : " + params);
      params.put("loginId", (String) session.getAttribute("loginId"));
      
      return service.replyWrite(photos, params);
   }
   
   
   // 관리자 답변 수정
   @RequestMapping(value = "/replyUpdate.go")
   public String replyUpdateForm(Model model, HttpSession session, @RequestParam int claim_id, @RequestParam int reply_id) {
      
      String page = "admin/claim/replyUpdate";
      
      if(session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("관리자")) {
         logger.info("답변 수정 요청 : " + reply_id);
         service.claimDetail(model, claim_id);
         service.replyDetail(model, claim_id);
      } else if (session.getAttribute("loginId") != null && session.getAttribute("mb_class").equals("일반회원")) {
         model.addAttribute("msg","관리자 회원만 이용 가능한 서비스 입니다.");
         page = "main";
      } else {
         model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
         page = "login/login";
      }
      
      // return "admin/claim/replyUpdate?reply_id="+reply_id+"&claim_id="+claim_id;
      return page;
   }
   
   
   // 답변 수정 상세보기 + 파일 업로드
   @RequestMapping(value = "/replyUpdate.do")
   public String replyUpdate(Model model, MultipartFile[] photos, @RequestParam HashMap<String, String> params) {
      logger.info("답변 수정 요청 : " + params);
      
      return service.replyUpdate(photos, params);
   }
   
}
