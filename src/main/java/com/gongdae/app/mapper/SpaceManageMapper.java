package com.gongdae.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.SpaceManageDTO;
import com.gongdae.app.domain.dto.SpaceOptionDTO;

@Mapper
public interface SpaceManageMapper {
    
 
    public long spaceSeq();
    public void insertSpace(SpaceManageDTO dto);
   
    public void insertSpaceApproval(long spaceNo);
    

    public void insertSpaceOption(SpaceManageDTO dto);
    
 
    public long spaceUnitSeq();
    public void insertSpaceUnit(SpaceManageDTO dto);
    
    
    public void insertSpacePolicy(SpaceManageDTO dto);
    
    
    public void insertSpaceFile(SpaceManageDTO dto);
    
    public List<CategoryDTO> listCategory() throws Exception;
    public List<SpaceOptionDTO> listSpaceOption() throws Exception;
    
}