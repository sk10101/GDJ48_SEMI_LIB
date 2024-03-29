package com.gdj.lib.dao;


import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.BookDTO;

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


	MemberDTO memberUpdateListMy(String mb_id);




	int myUpdate(String mb_id, String mb_pw, String name,String phone);


	int myUpdateTwo(String mb_id, String name, String phone);


	ArrayList<BrwBookDTO> brwList(String mb_id);



	MemberDTO penaltyDetail(String penalty_id);


	void penaltyUpdate(HashMap<String, String> params);


	void blackUpdate(HashMap<String, String> params);

	ArrayList<MemberDTO> memberUpdateListMy();



	void cancelMySecession(String mb_id);


	void mySecession(String mb_id);


	void mySecessionCheck(String loginId);

	String getMbClass(String id, String pw);

	
	
	// =====================================
	ArrayList<BoardDTO> allCount(HashMap<String, Object> map);

	ArrayList<MemberDTO> blackList (int cnt, int offset);

	ArrayList<MemberDTO> memberList(int cnt, int offset);

	ArrayList<MemberDTO> adminList(int cnt, int offset);







	ArrayList<MemberDTO> penaltyList(int cnt, int offset);


	//ArrayList<BrwBookDTO> hisList(HashMap<String, String> params);


	ArrayList<BookDTO> reserveList(int cnt, int offset, String mb_id);


	int reserveCancel(String reserve_id);

	ArrayList<MemberDTO> allBlackCount(HashMap<String, Object> map);

	
	
	ArrayList<MemberDTO> blackIDSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adStartSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adEndSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> allMemeberCount(HashMap<String, Object> map);

	// int allAdminCount();


	ArrayList<MemberDTO> mbIDSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> mbNameSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> mbStatusSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adIDSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adNameSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> adPhoneSearch(int cnt, int offset, String word);


	int allReserveCount(String mb_id);

	ArrayList<BookDTO> reserveReasonSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<BookDTO> reserveTitleSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<MemberDTO> memberSearch(int cnt, int offset, String word);

	ArrayList<MemberDTO> penaltySearch(int cnt, int offset, String word);


	int allHisCount(String mb_id);

	ArrayList<BrwBookDTO> hisList(int cnt, int offset, String mb_id);

	ArrayList<BrwBookDTO> allBookTSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<BrwBookDTO> allBookRSearch(int cnt, int offset, String word, String mb_id);


	
	int notSecession(String mb_id);

	int blackCon(String s_id);


	

	String mb_status(String id);

	long leave_date(String loginId);

	int cancelUpdate(String b_id);

	int bookStatus(String b_id);

	Object reserveUpdate(String b_id);

	void updateMember(String id);

	void blackClass(String id);

	String getId(HashMap<String, String> params);


	



	


}
