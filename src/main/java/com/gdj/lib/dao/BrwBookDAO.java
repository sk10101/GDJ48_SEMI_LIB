package com.gdj.lib.dao;


import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;

public interface BrwBookDAO {
	
	BookDTO detail(String b_id);

	int brw(HashMap<String, String> params);



}
