package com.gdj.lib.dao;


import java.util.ArrayList;
import java.util.HashMap;


import com.gdj.lib.dto.BrwBookDTO;
import com.gdj.lib.dto.MemberDTO;


public interface MemberDAO {


	MemberDTO memberUpdateDetailMy(String mb_id);

	MemberDTO memberDetail(String mb_id);

	//ArrayList<MemberDTO> memberList();

	//ArrayList<MemberDTO> adminList();

	MemberDTO detail(String mb_id);

	int update(HashMap<String, String> params);

	ArrayList<MemberDTO> memberBrw();
	
	
	// ArrayList<MemberDTO> blackList();

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





	int myUpdate(String mb_id, String mb_pw, String name,String phone);


	int myUpdateTwo(String mb_id, String name, String phone);


	ArrayList<BrwBookDTO> brwList(String mb_id);



	MemberDTO penaltyDetail(String penalty_id);


	void penaltyUpdate(HashMap<String, String> params);


	void blackUpdate(HashMap<String, String> params);

	ArrayList<MemberDTO> memberUpdateListMy();



	void cancelMySecession(String mb_id);


	void MySecession(String mb_id);


	void MySecessionTwo(String mb_id);

	String getMbClass(String id, String pw);

	
	
	// =====================================
	int allCount();

	ArrayList<MemberDTO> blackList (int cnt, int offset);

	ArrayList<MemberDTO> memberList(int cnt, int offset);

	ArrayList<MemberDTO> adminList(int cnt, int offset);







	ArrayList<MemberDTO> penaltyList(int cnt, int offset);


	ArrayList<BrwBookDTO> hisList(String mb_id);


	ArrayList<BrwBookDTO> reserveList(String mb_id);


	int reserveCancel(String reserve_id);

	int allBlackCount();

	
	
	
	
	
	ArrayList<MemberDTO> blackIDSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adStartSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adEndSearch(int cnt, int offset, String word);

	int allMemeberCount();

	int allAdminCount();


	ArrayList<MemberDTO> mbIDSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> mbNameSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> mbStatusSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adIDSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adNameSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adPhoneSearch(int cnt, int offset, String word);



	




	


}
