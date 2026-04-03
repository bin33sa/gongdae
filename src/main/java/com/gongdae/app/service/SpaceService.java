package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.SpaceDTO;
import com.gongdae.app.domain.dto.SpaceUnitDTO;

public interface SpaceService {
	
	public List<CategoryDTO> categoryList();
	
	public List<SpaceDTO> homeSpaceList(Map<String, Object> params);
	public int premiumCount(Map<String, Object> params);
	public List<SpaceDTO> premiumSpaceList(Map<String, Object> params);
	public int spaceCount(Map<String, Object> params);
	public List<SpaceDTO> spaceList(Map<String, Object> params);
	
	public SpaceDTO findSpaceById(long spaceId);
	
	public List<SpaceUnitDTO> spaceUnitList(long spaceId);
	public SpaceUnitDTO findSpaceUnitById(long unitId);
	
}
