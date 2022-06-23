package com.gdj.lib.dao;


import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BrwBookDTO;

public interface BrwBookDAO {
	
	BookDTO detail(String b_id);

	void brw(String loginId, String b_id);

	void bookreserve(String loginId, String b_id);

	

}
