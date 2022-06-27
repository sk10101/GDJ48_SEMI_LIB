package com.gdj.lib.dao;

import java.util.ArrayList;

import com.gdj.lib.dto.KioskDTO;

public interface KioskDAO {

	String login(String id, String pw);

	ArrayList<KioskDTO> list(String loginId);

	int borrow(String b_id);

	int borrowTable(String loginId, String b_id);

	void updateR(String b_id);

	ArrayList<KioskDTO> returnList(String loginId);

	int bookReturn(String b_id);

	void updateB(String b_id);

	String loginSeat(String id);

	int notReturn(String loginId);

	long returnDate(String loginId);

	long returnFinish(String loginId);

	void penaltyEndDate(String loginId);

}
