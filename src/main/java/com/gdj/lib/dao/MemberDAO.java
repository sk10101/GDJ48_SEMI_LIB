package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.MemberDTO;

public interface MemberDAO {

	ArrayList<MemberDTO> memberList();

	ArrayList<MemberDTO> adminList();

	MemberDTO detail(String mb_id);

	int update(HashMap<String, String> params);

	ArrayList<MemberDTO> memberBrw();


}
