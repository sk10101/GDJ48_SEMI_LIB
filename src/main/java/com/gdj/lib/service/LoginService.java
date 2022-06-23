package com.gdj.lib.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.MemberDAO;

@Service
public class LoginService {
	 Logger logger = LoggerFactory.getLogger(this.getClass());
	 @Autowired MemberDAO dao;
	public HashMap<String, Object> memberjoin(HashMap<String, String> params) {
		logger.info("회원 가입 요청 서비스");
		HashMap<String, Object> result = new HashMap<String, Object>();
		int row = dao.memberjoin(params);
		boolean success = false;
		
		if(row>0) {
			success = true;
		}

		result.put("success", success);
		
		return result;
	}
	
	public HashMap<String, Object> memberoverlay(String chkId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String overId = dao.memberoverlay(chkId);
		logger.info("중복 아이디가 있나? "+overId);
		boolean over = overId == null ? false : true;
		map.put("overlay", over);
		
		return map;
	}
	
	public HashMap<String, Object> memberoverlays(String chkEmail) {
		HashMap<String, Object> maps = new HashMap<String, Object>();
		String overEmail = dao.memberoverlays(chkEmail);
		logger.info("중복 이메일이 있나? "+overEmail);
		boolean overs = overEmail == null ? false : true;
		maps.put("overlays", overs);
		
		return maps;
	}

	public String idFind(String email) {
		String idFind = dao.idFind(email);
		logger.info("아이디 :"+idFind);
	
		return idFind;
	}

	public String pwFind(String id, String email) {
		String pwFind = dao.pwFind(id,email);
		logger.info("비밀번호 :"+pwFind);
		
		return pwFind;
	}

	public String login(String id, String pw) {
		logger.info("로그인  서비스");
		return dao.login(id,pw);
	}

	
	 

	
	

}
