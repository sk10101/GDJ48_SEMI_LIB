package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;

public interface BookDAO {
	
	ArrayList<BookDTO> bookSearch(HashMap<String, String> params);

	ArrayList<BookDTO> list();

<<<<<<< HEAD
=======
	

>>>>>>> de7789817d72ed16e56bc3d046f0a0516b7140d7
	int bookUpdate(HashMap<String, String> params);

	int bookAdd(HashMap<String, String> params);



	
}
