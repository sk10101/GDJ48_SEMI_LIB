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

	int noticeAllCount();

	ArrayList<BoardDTO> noticeList(int cnt, int offset);

	ArrayList<BoardDTO> subjectNoticeSearch(int cnt, int offset, String word);
	
	
	
	
	
	
	
	
	
	
	/*
	ArrayList<BoardDTO> claimList();
	*/
	ArrayList<BoardDTO> claimList(int cnt, int offset, String mb_id);

	int allCount();
	
	int claimWrite(BoardDTO dto);

	void claimFileWrite(String oriFileName, String newFileName, int claim_id, int category_id);

	BoardDTO claimDetail(int claim_id);

	ArrayList<PhotoDTO> claimPhotoList(int claim_id);

	int claimUpdate(HashMap<String, String> params);

	int adminClaimUpdate(String status, int claim_id);
	
	int claimDel(int claim_id);
	
	int photoDel(int claim_id);

	ArrayList<BoardDTO> subjectSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<BoardDTO> statusSearch(int cnt, int offset, String word, String mb_id);

	ArrayList<BoardDTO> writerSearch(int cnt, int page, String word, String mb_id);

	BoardDTO replyDetail(int claim_id);

	ArrayList<PhotoDTO> replyPhotoList(int reply_id);

	int replyWrite(BoardDTO dto);

	int replyUpdate(HashMap<String, String> params);

	int getReplyId(int claim_id);

	


}
