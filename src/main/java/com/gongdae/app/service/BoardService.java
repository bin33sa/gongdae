package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.domain.dto.BoardDto;

public interface BoardService {
	public BoardDto findById(long num);
	public void updateHitCount(long num) throws Exception;
	
	public int noticeCount(Map<String, Object> map);
	public List<BoardDto> noticeList(Map<String, Object> map);

	public int eventCount();
	public List<BoardDto> eventList(Map<String, Object> map);
	
	public List<BoardDto> faqList();
}
