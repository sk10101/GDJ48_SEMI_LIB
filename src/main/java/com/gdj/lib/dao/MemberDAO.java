package com.gdj.lib.dao;


import com.gdj.lib.dto.MemberDTO;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.MemberDTO;

public interface MemberDAO {

<<<<<<< HEAD
	MemberDTO memberUpdateDetailMy(String mb_id);
=======

	MemberDTO memberDetail(String mb_id);
>>>>>>> origin/master


	ArrayList<MemberDTO> memberList();

	ArrayList<MemberDTO> adminList();

	MemberDTO detail(String mb_id);

	int update(HashMap<String, String> params);

	ArrayList<MemberDTO> memberBrw();

	ArrayList<MemberDTO> blackList();

	MemberDTO blackDetail(String black_id);

	String idget(String id);

	int blackAdd(MemberDTO dto);

	
	
	
	//====================================================
	
	
	
	
	int memberjoin(HashMap<String, String> params);

	String memberoverlay(String chkId);

	String memberoverlays(String chkEmail);

	String idFind(String email);

	String pwFind(String id, String email);

	String login(String id, String pw);

<<<<<<< HEAD
	ArrayList<MemberDTO> memberUpdateListMy();
=======
>>>>>>> origin/master

	


}
