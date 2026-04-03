package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.SpaceDTO;
import com.gongdae.app.domain.dto.SpaceUnitDTO;
import com.gongdae.app.mapper.SpaceMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SpaceServiceImpl implements SpaceService {
	private final SpaceMapper mapper;

	@Override
	public List<CategoryDTO> categoryList() {
		List<CategoryDTO> categoryList = null;
		try {
			categoryList = mapper.categoryList();
		} catch (Exception e) {
			log.info("categoryList: ", e);
		}
		return categoryList;
	}

	@Override
	public List<SpaceDTO> homeSpaceList(Map<String, Object> params) {
		List<SpaceDTO> spaceList = null;
		try {
			spaceList = mapper.homeSpaceList(params);
		} catch (Exception e) {
			log.info("homeSpaceList: ", e);
		}
		
		return spaceList;
	}
	
	@Override
	public int premiumCount(Map<String, Object> params) {
		int spaceCount = 0;
		try {
			spaceCount = mapper.premiumCount(params);
		} catch (Exception e) {
			log.info("spaceList: ", e);
		}
		
		return spaceCount;
	}
	
	@Override
	public List<SpaceDTO> premiumSpaceList(Map<String, Object> params) {
		List<SpaceDTO> spaceList = null;
		try {
			spaceList = mapper.premiumSpaceList(params);
		} catch (Exception e) {
			log.info("premiumSpaceList: ", e);
		}
		
		return spaceList;
	}
	
	@Override
	public int spaceCount(Map<String, Object> params) {
		int spaceCount = 0;
		try {
			spaceCount = mapper.spaceCount(params);
		} catch (Exception e) {
			log.info("spaceList: ", e);
		}
		
		return spaceCount;
	}
	
	@Override
	public List<SpaceDTO> spaceList(Map<String, Object> params) {
		List<SpaceDTO> spaceList = null;
		try {
			spaceList = mapper.spaceList(params);
		} catch (Exception e) {
			log.info("spaceList: ", e);
		}
		
		return spaceList;
	}
	
	@Override
	public SpaceDTO findSpaceById(long spaceId) {
		SpaceDTO space = null;
		try {
			space = mapper.findSpaceById(spaceId);
		} catch (Exception e) {
			log.info("findSpaceById: ", e);
		}
		
		return space;
	}

	@Override
	public List<SpaceUnitDTO> spaceUnitList(long spaceId) {
		List<SpaceUnitDTO> spaceUnitList = null;
		try {
			spaceUnitList = mapper.spaceUnitList(spaceId);
		} catch (Exception e) {
			log.info("spaceUnitList: ", e);
		}
		
		return spaceUnitList;
	}
	
	@Override
	public SpaceUnitDTO findSpaceUnitById(long unitId) {
		SpaceUnitDTO spaceUnit = null;
		try {
			spaceUnit = mapper.findSpaceUnitById(unitId);
		} catch (Exception e) {
			log.info("findSpaceUnitById: ", e);
		}
		
		return spaceUnit;
	}

}
