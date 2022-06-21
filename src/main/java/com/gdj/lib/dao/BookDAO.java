package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;

public interface BookDAO {
<<<<<<< HEAD
	
=======

>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
	ArrayList<BookDTO> bookSearch(HashMap<String, String> params);

	ArrayList<BookDTO> list();

	BookDTO detail(String b_id);

	int bookUpdate(HashMap<String, String> params);

	int bookAdd(HashMap<String, String> params);

<<<<<<< HEAD
	//int brw(HashMap<String, String> params);


	
=======
>>>>>>> a1d146dffe57cad6b7cd1eac211aa25b84e992b9
}
