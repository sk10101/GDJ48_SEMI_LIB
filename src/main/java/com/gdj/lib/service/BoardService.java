package com.gdj.lib.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdj.lib.dao.BoardDAO;

@Service
public class BoardService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardDAO dao;
}
