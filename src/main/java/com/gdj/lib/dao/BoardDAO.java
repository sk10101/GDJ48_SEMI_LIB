package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.PhotoDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> noticeList();

	int noticeWrite(BoardDTO dto);

	int noticeDelete(String notice_id);

	BoardDTO noticeDetail(int notice_id);

	void noticeFileWrite(String oriFileName, String newFileName, int notice_id, int i);

	ArrayList<PhotoDTO> noticePhotoList(int notice_id);

	int allCount();

	ArrayList<BoardDTO> noticePageList(int cnt, int offset);

}
