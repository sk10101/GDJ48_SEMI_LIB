package com.gdj.lib.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.PhotoDTO;

public interface BoardDAO {
	/*
	ArrayList<BoardDTO> claimList();
	*/
	ArrayList<BoardDTO> claimList(int cnt, int offset);

	int allCount();
	
	int claimWrite(BoardDTO dto);

	void claimFileWrite(String oriFileName, String newFileName, int claim_id, int i);

	BoardDTO claimDetail(int claim_id);

	ArrayList<PhotoDTO> claimPhotoList(int claim_id);

	int claimUpdate(HashMap<String, String> params);

	int claimDel(int claim_id);
	
	int photoDel(int claim_id);

	ArrayList<BoardDTO> subjectSearch(int cnt, int offset, String search);

	ArrayList<BoardDTO> statusSearch(int cnt, int offset, String search);

	
}
