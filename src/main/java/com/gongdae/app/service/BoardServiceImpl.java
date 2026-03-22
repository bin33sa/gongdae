package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.BoardDto;
import com.gongdae.app.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	private final BoardMapper mapper;
	
	@Override
	public BoardDto findById(long num) {
		BoardDto dto = null;
		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			log.info("findById: ", e);
		}
		return dto;
	}
	
	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) { 
			log.info("updateHitCount: ", e);
			throw e;
		}
	}
	
	@Override
	public int noticeCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.noticeCount(map);
		} catch (Exception e) {
			log.info("noticeCount: ", e);
		}
		return result;
	}

	@Override
	public List<BoardDto> noticeList(Map<String, Object> map) {
		List<BoardDto> list = null;
		try {
			list = mapper.noticeList(map);
		} catch (Exception e) {
			log.info("noticeList: ", e);
		}
		return list;
	}
	
	@Override
	public int eventCount() {
		int result = 0;
		try {
			result = mapper.eventCount();
		} catch (Exception e) {
			log.info("eventCount: ", e);
		}
		return result;
	}
	
	@Override
	public List<BoardDto> eventList(Map<String, Object> map) {
		List<BoardDto> list = null;
		try {
			list = mapper.eventList(map);
		} catch (Exception e) {
			log.info("eventList: ", e);
		}
		return list;
	}
	
	@Override
	public List<BoardDto> faqList() {
		List<BoardDto> list = null;
		try {
			list = mapper.faqList();
		} catch (Exception e) {
			log.info("faqList: ", e);
		}
		return list;
	}

	
	


}
