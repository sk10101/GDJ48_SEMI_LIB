package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;

public interface BookDAO {

	ArrayList<BookDTO> bookSearch(HashMap<String, String> params);

	ArrayList<BookDTO> list();

	BookDTO detail(String b_id);

	int bookUpdate(HashMap<String, String> params);

	int bookAdd(HashMap<String, String> params);

}
