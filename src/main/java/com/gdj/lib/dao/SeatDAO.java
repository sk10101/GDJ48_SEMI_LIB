package com.gdj.lib.dao;

import java.util.ArrayList;

import com.gdj.lib.dto.SeatDTO;

public interface SeatDAO {

	ArrayList<SeatDTO> list();

	void seatUse(String loginId, String seatNo, String useTime);

	void updateSeat(String seatNo, String useTime);

	void seatTime();

	void seatOut(String loginId);

	String seatChk(String loginId);

}
