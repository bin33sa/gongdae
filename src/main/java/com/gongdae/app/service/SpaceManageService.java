package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.SpaceManageDTO;
@Service
public interface SpaceManageService {

	/**
     * 공간등록
     * * @param dto 
     * @param uploadPath 
     * @throws Exception 
     */
	public void insertSpace(SpaceManageDTO dto, String uploadPath) throws Exception;
    public List<Map<String, Object>> listCategory() throws Exception;
    public List<Map<String, Object>> listOption() throws Exception;

}
