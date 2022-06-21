package com.gdj.lib.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class KioskController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/kiosk.login", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("키오스크 로그인 페이지");
		return "kiosk/login";
	}
	
}
