package com.gdj.lib.dao;


import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.BrwBookDTO;

public interface BrwBookDAO {
	
	BrwBookDTO detail(String b_id);

	void brw(String loginId, String b_id);

	void reason(String loginId, String b_id);

	void bookreserve(String loginId, String b_id);

	ArrayList<BrwBookDTO> bookList(HashMap<String, String> params);

	ArrayList<BrwBookDTO> history(HashMap<String, String> params);

	ArrayList<BrwBookDTO> reserve(HashMap<String, String> params);

	void reserveBtn(String brw_id);

	void del(String reserve_id);

	void reserveBookBrw(String string);

	void bookStatusUpdate(String string);

	int reserveCheck(String mb_id);

	long expiry(String mb_id);

	long overExpiry(String mb_id);

	Object penaltyDate(String mb_id);

	

	

}
