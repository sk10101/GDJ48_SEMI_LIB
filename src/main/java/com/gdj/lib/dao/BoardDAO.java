package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> noticelist();

	int noticewrite(HashMap<String, String> params);

	int noticedelete(String notice_id);

}
