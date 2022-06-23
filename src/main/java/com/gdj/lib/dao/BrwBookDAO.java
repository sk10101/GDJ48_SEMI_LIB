package com.gdj.lib.dao;


import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BrwBookDTO;

public interface BrwBookDAO {
	
	BookDTO detail(String b_id);

	void brw(String loginId, String b_id);

	void reason(String loginId, String b_id);

	ArrayList<BookDTO> brwList();





	

}
