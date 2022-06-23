package com.gdj.lib.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
			model.addAttribute("seatNo"+i, list.get(i).getSeat_status());
		}
		model.addAttribute("seat", list.get(0).getSeat_no());
//		model.addAttribute("seatNo1", list.get(0).getSeat_status());
//		model.addAttribute("seatNo30", list.get(29).getSeat_status());
		// model.addAttribute("list", list);
		return "seat/seat";
	}
	
	
	// 키오스크 열람실 현황보기
	@RequestMapping(value = "/ki_seat.go")
	public String kioskSeat(Model model) {
		return "seat/kioskSeat";	
	}
}
