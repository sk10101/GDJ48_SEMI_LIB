package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;

public interface BookDAO {

	ArrayList<BookDTO> searchTitle(String word, int cnt, int offset);
	
	ArrayList<BookDTO> searchWriter(String word, int cnt, int offset);

	ArrayList<BookDTO> searchPublisher(String word, int cnt, int offset);

	ArrayList<BookDTO> bookList(int cnt, int offset);

	BookDTO detail(String b_id);

	int bookUpdate(HashMap<String, String> params);

	int bookAdd(BookDTO dto);

	ArrayList<BookDTO> reserveOk();

	int allCount();

	void fileWrite(String oriFileName, String newFileName, int b_id);


}
