package com.gdj.lib.dao;

import java.util.ArrayList;

import com.gdj.lib.dto.BoardDTO;
import com.gdj.lib.dto.PhotoDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> claimList();

	int claimWrite(BoardDTO dto);

	void claimFileWrite(String oriFileName, String newFileName, int claim_id, int i);

	BoardDTO claimDetail(int claim_id);

	ArrayList<PhotoDTO> claimPhotoList(int claim_id);

}
