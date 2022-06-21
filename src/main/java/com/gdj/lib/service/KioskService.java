package com.gdj.lib.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.KioskDAO;

@Service
public class KioskService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired KioskDAO dao;
	
	public String login(String id, String pw) {
		logger.info("키오스크 로그인 서비스 도착");
		return dao.login(id,pw);
	}

}
