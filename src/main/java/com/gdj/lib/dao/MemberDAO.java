package com.gdj.lib.dao;

import java.util.HashMap;

public interface MemberDAO {

	int memberjoin(HashMap<String, String> params);

	String memberoverlay(String chkId);

	String memberoverlays(String chkEmail);

	String idFind(String email);

	String pwFind(String id, String email);

	String login(String id, String pw);

	

	

	

	

}
