package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> noticeList();

	int noticeWrite(BoardDTO dto);

	int noticeDelete(String notice_id);

	BoardDTO noticeDetail(String notice_id);

}
