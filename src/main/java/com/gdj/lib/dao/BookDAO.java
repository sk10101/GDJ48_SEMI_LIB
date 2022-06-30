package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.dto.PhotoDTO;

public interface BookDAO {

	ArrayList<BookDTO> searchTitle(int cnt, int offset, String word);
	
	ArrayList<BookDTO> searchWriter(int cnt, int offset, String word);

	ArrayList<BookDTO> searchPublisher(int cnt, int offset, String word);

	ArrayList<BookDTO> bookList(int cnt, int offset);
	
	ArrayList<BookDTO> bookTitleSearch(int cnt, int offset, String word);
	
	ArrayList<BookDTO> bookWriterSearch(int cnt, int offset, String word);

	ArrayList<BookDTO> bookPublisherSearch(int cnt, int offset, String word);

	BookDTO detail(String b_id);

	int bookUpdate(BookDTO dto);

	int bookAdd(BookDTO dto);

	int allCount();

	void fileWrite(String oriFileName, String newFileName, int b_id);

	ArrayList<PhotoDTO> photoList(String b_id);

	void fileUpdate(String oriFileName, String newFileName, int b_id);

	int photoChk(BookDTO dto);

	

	

	


}
