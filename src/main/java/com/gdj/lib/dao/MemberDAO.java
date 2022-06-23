package com.gdj.lib.dao;


import com.gdj.lib.dto.MemberDTO;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemberDAO {

	MemberDTO memberUpdateDetailMy(String mb_id);

	int memberjoin(HashMap<String, String> params);

	String memberoverlay(String chkId);

	String memberoverlays(String chkEmail);

	String idFind(String email);

	String pwFind(String id, String email);

	String login(String id, String pw);

	ArrayList<MemberDTO> memberUpdateListMy();

	

	



}
