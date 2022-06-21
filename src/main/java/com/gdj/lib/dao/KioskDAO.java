package com.gdj.lib.dao;

import java.util.ArrayList;

import com.gdj.lib.dto.KioskDTO;

public interface KioskDAO {

	String login(String id, String pw);

	ArrayList<KioskDTO> list(String loginId);

}
