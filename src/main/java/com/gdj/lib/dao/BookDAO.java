package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.PhotoDTO;

public interface BookDAO {

	ArrayList<BookDTO> searchTitle(String word, int cnt, int offset);
	
	ArrayList<BookDTO> searchWriter(String word, int cnt, int offset);

	ArrayList<BookDTO> searchPublisher(String word, int cnt, int offset);

	ArrayList<BookDTO> bookList(int cnt, int offset);

	BookDTO detail(String b_id);

	int bookUpdate(BookDTO dto);

	int bookAdd(BookDTO dto);

	ArrayList<BookDTO> reserveOk();

	int allCount();

	void fileWrite(String oriFileName, String newFileName, int b_id);

	ArrayList<PhotoDTO> photoList(String b_id);


}