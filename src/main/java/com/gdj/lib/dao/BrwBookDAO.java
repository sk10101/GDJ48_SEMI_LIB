package com.gdj.lib.dao;


import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.dto.PhotoDTO;

public interface BrwBookDAO {
	

	void brw(String loginId, String b_id);

	void reason(String loginId, String b_id);

	void bookreserve(String loginId, String b_id);

	ArrayList<BrwBookDTO> bookList(HashMap<String, String> params);

	ArrayList<BrwBookDTO> reserve(HashMap<String, String> params, String mb_id);

	void reserveBtn(String brw_id);


	void del(String reserve_id);


	void bookStatusUpdate(String string);


	int reserveCheck(String mb_id);

	long expiry(String mb_id);

	

	Object penaltyDate(String mb_id);

	void bookBrwDetail(String b_id);

	ArrayList<BrwBookDTO> detail(HashMap<String, String> params);

	void bookreason(HashMap<String, String> params);	

	int allCount();


	void expiryPenalty(String mb_id);

	void reserveCancel(String mb_id);

	void addPenalty(String mb_id);

	void reserveBookBrw(String string);

	void bookDetailBrw(HashMap<String, String> params);

	ArrayList<PhotoDTO> list(HashMap<String, String> params);

	void bookdel(String string);

	void bookdelStatusUpdate(String string);


	ArrayList<BrwBookDTO> history(HashMap<String, String> params, String mb_id);

	ArrayList<BrwBookDTO> brwBookList(int cnt, int offset, String mb_id);

	ArrayList<BrwBookDTO> brwSubjectSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<BrwBookDTO> brwStatusSearch(int cnt, int offset, String word, String mb_id);

	int brwBookCount(String mb_id);
	int chkReturnOver(String mb_id);

	int chkPenalty(String mb_id);

	void insertPenalty(String mb_id);

	



	
	


	


	

	

}
