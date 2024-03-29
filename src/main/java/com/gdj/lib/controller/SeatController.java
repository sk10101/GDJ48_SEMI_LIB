package com.gdj.lib.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdj.lib.dto.SeatDTO;
import com.gdj.lib.service.SeatService;

@Controller
public class SeatController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired SeatService service;
	
	// 웹 열람실 현황보기
	@RequestMapping(value = "/seat.go")
	public String webSeat(Model model) {
		logger.info("열람실 페이지 이동");
		service.seatTime();
		ArrayList<SeatDTO> list = service.list();
		logger.info("list 개수: "+list.size());
		for (int i = 0; i < list.size(); i++) {
			logger.info(i+"번 : "+list.get(i).getSeat_status());
			model.addAttribute("seatStatus"+i, list.get(i).getSeat_status());
		}
		return "seat/seat";
	}
	
	
	
	// 키오스크 열람실 현황보기
	@RequestMapping(value = "/ki_seat.go")
	public String kioskSeat(Model model, HttpSession session) {
		logger.info("키오스크 열람실 페이지 이동");
		String loginId = (String) session.getAttribute("loginId");
		String page = "seat/kioskSeat";
		
		// 열람실 하루이용 제한
		String seatChk = service.seatChk(loginId);
		logger.info("마지막 이용 날짜: "+seatChk);
		
		if (seatChk != null) {
		 
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String nowDay = sdf.format(now);
			
			long today = Long.parseLong(nowDay);
			long seatDate = Long.parseLong(seatChk);
//			System.out.println(today);
//			System.out.println(seatDate);
	
			if (today == seatDate) {
				page = "kiosk/seatWarn";
			}
		}
			
		
		ArrayList<SeatDTO> list = service.list();
		service.seatTime();
		logger.info("list 개수: "+list.size());
		for (int i = 0; i < list.size(); i++) {
			logger.info(i+"번 : "+list.get(i).getSeat_status());
			model.addAttribute("seatStatus"+i, list.get(i).getSeat_status());
		}
		
		return page;			
	}
	
	
	
	// 키오스크 열람실 시간 선택 페이지
	@RequestMapping("/ki_selectTime.go")
	public String kioskSelectTime(@RequestParam String seatNo, Model model) {
		logger.info("키오스크 시간 선택 페이지 요청: "+seatNo);
		model.addAttribute("seatNo", seatNo);
		
		return "seat/kioskSelectTime";
	}
	
	
	
	// 키오스크 열람실 좌석 사용
	@RequestMapping("/seatUse.ajax")
	@ResponseBody
	public String kioskSeatUse(@RequestParam String useTime, @RequestParam String seatNo, HttpSession session) {
		logger.info("선택 좌석번호: "+seatNo);
		logger.info("선택 사용시간: "+useTime);
		logger.info("사용자 id: "+session.getAttribute("loginId"));
		String loginId = (String) session.getAttribute("loginId");
		service.seatUse(loginId, seatNo, useTime);
		service.updateSeat(seatNo,useTime);
		return null;
	}
	
	
	
	// 키오스크 열람실 퇴실하기
	@RequestMapping(value = "/ki_seatOut.do")
	public String kioskSeatOut(Model model, HttpSession session) {
		logger.info("키오스크 열람실 퇴실하기");
		String loginId = (String) session.getAttribute("loginId");
		logger.info("퇴실요청 아이디:"+loginId);
		service.seatOut(loginId);
		return "kiosk/main";	
	}
	
	
	
	
}
