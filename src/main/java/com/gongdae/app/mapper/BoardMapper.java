package com.gongdae.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.BoardDto;

@Mapper
public interface BoardMapper {
	public BoardDto findById(long num);
	public void updateHitCount(long num) throws SQLException;
	
	public int noticeCount(Map<String, Object> map);
	public List<BoardDto> noticeList(Map<String, Object> map);

	public int eventCount();
	public List<BoardDto> eventList(Map<String, Object> map);

	public List<BoardDto> faqList();
	
}
