package com.gdj.lib.dao;

import java.util.ArrayList;

import com.gdj.lib.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> claimList();

	int claimWrite(BoardDTO dto);

}
