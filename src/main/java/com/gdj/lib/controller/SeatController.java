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
import org.springframework.web.bind.annotation.RequestMethod;
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
	public String kioskSeat(Model model) {
		logger.info("키오스크 열람실 페이지 이동");
		ArrayList<SeatDTO> list = service.list();
		logger.info("list 개수: "+list.size());
		for (int i = 0; i < list.size(); i++) {
			logger.info(i+"번 : "+list.get(i).getSeat_status());
			model.addAttribute("seatStatus"+i, list.get(i).getSeat_status());
		}
		return "seat/kioskSeat";	
	}
	
	
	
	// 키오스크 열람실 시간 선택 페이지
	@RequestMapping("/ki_selectTime.go")
	public String kioskSelectTime(@RequestParam String seatNo, Model model) {
		logger.info("키오스크 시간 선택 페이지 요청: "+seatNo);
		model.addAttribute("seatNo", seatNo);
		
		return "seat/kioskSelectTime";
	}
	
	
	
}
