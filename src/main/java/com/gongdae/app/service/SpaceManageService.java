package com.gongdae.app.service;

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

}
