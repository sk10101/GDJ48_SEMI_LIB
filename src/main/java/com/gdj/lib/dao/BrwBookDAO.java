package com.gdj.lib.dao;


import java.util.ArrayList;
import java.util.HashMap;

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

	

	long penaltyDate(String mb_id);

	void bookBrwDetail(String b_id);

	BrwBookDTO detail(String b_id);

	void bookreason(HashMap<String, String> params);	

	int allCount();


	void expiryPenalty(String mb_id);

	void reserveCancel(String mb_id);

	void addPenalty(String mb_id);

	void reserveBookBrw(String string);

	void bookDetailBrw(HashMap<String, String> params);

	ArrayList<PhotoDTO> list(String b_id);

	void bookdel(String string);

	void bookdelStatusUpdate(String string);


	ArrayList<BrwBookDTO> history(HashMap<String, String> params, String mb_id);

	void reserve_able(HashMap<String, String> params);

	int penaltyCheck(String mb_id);

	ArrayList<BrwBookDTO> brwBookList(int cnt, int offset, String mb_id);

	ArrayList<BrwBookDTO> brwSubjectSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<BrwBookDTO> brwStatusSearch(int cnt, int offset, String word, String mb_id);

	int brwBookCount(String mb_id);
	
	int chkReturnOver(String mb_id);

	int chkPenalty(String mb_id);

	void insertPenalty(String mb_id);

	ArrayList<BrwBookDTO> brwlist(HashMap<String, String> params);

	
	ArrayList<PhotoDTO> photoList(String b_id);

	BrwBookDTO aaa(String b_id);

	ArrayList<BrwBookDTO> duplicateCheck(HashMap<String, String> params);

	ArrayList<BrwBookDTO> bookCheck(HashMap<String, String> params);

	Object idCheck(HashMap<String, String> params);

	


	



	
	


	


	

	

}
