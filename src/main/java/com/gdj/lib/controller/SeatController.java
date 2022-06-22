package com.gdj.lib.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gdj.lib.service.SeatService;

@Controller
public class SeatController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired SeatService service;
	
	// 웹 열람실 현황보기
	@RequestMapping(value = "/seat.go")
	public String webSeat(Model model) {
		logger.info("열람실 페이지 이동");
		return "seat/seat";
	}
}
