package com.gdj.lib.dao;


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

	ArrayList<BrwBookDTO> history(HashMap<String, String> params);

	ArrayList<BrwBookDTO> reserve(HashMap<String, String> params);

	void reserveBtn(String brw_id);

	void bookStatusUpdate(String string);

	void bookBrwDetail(String b_id);

	ArrayList<BrwBookDTO> detail(HashMap<String, String> params);

	void bookreason(HashMap<String, String> params);	

	ArrayList<BrwBookDTO> bookListPaing(int cnt, int offset);

	int allCount();

	void reserveBookBrw(String string);

	void bookDetailBrw(HashMap<String, String> params);

	ArrayList<PhotoDTO> list(HashMap<String, String> params);

	void bookdel(String string);

	void bookdelStatusUpdate(String string);

	void brwListMb_id(HashMap<String, String> params);



	
	

	

	

	

}
