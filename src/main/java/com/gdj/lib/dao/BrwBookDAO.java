package com.gdj.lib.dao;


import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BookDTO;
import com.gdj.lib.service.BrwBookDTO;

public interface BrwBookDAO {
	
	BookDTO detail(String b_id);

	void brw(String loginId, String b_id);

<<<<<<< HEAD
	void reason(String loginId, String b_id);

	ArrayList<BookDTO> brwList();




=======
	void bookreserve(String loginId, String b_id);
>>>>>>> de7789817d72ed16e56bc3d046f0a0516b7140d7

	

}
