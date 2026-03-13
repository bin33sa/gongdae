package com.gongdae.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.SpaceManageDTO;
import com.gongdae.app.domain.dto.SpaceOptionDTO;
@Service
public interface SpaceManageService {

	/**
     * 공간등록
     * * @param dto 
     * @param uploadPath 
     * @throws Exception 
     */
    public void insertSpace(SpaceManageDTO dto, String uploadPath) throws Exception;
    
    public List<CategoryDTO> listCategory() throws Exception;
    public List<SpaceOptionDTO> listSpaceOption() throws Exception;

}
