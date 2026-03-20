package com.gongdae.app.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import com.gongdae.app.domain.dto.SpaceManageDTO;

@Mapper
public interface SpaceManageMapper {
	long spaceSeq();
    long unitSeq();

    List<Map<String, Object>> listCategory();
    List<Map<String, Object>> listOption();

    void insertSpace(SpaceManageDTO dto) throws Exception;
    void insertSpaceImage(SpaceManageDTO dto) throws Exception;
    void insertSpaceOption(SpaceManageDTO dto) throws Exception;
    void insertSpaceUnit(SpaceManageDTO dto) throws Exception;
    void insertSpacePolicy(SpaceManageDTO dto) throws Exception;
    void insertSpaceUnitTime(SpaceManageDTO dto) throws Exception;
    void insertSpaceApproval(long spaceNo) throws Exception;
    
    void updateSpace(SpaceManageDTO dto) throws Exception;
    void deleteSpaceOptions(long spaceNo) throws Exception;
    void deleteSpaceUnitTimes(long spaceNo) throws Exception;
    void deleteSpacePolicies(long spaceNo) throws Exception;
    void deleteSpaceUnits(long spaceNo) throws Exception;
    
    void deleteSpaceImage(long imageNo) throws Exception;
    void deleteSpace(long spaceNo) throws Exception;
    
    SpaceManageDTO findById(long spaceNo); 
    List<SpaceManageDTO> listSpaceImage(long spaceNo); 
    SpaceManageDTO findImageById(long imageNo);
    List<Long> listSpaceOption(long spaceNo); 
    List<SpaceManageDTO> listSpaceUnit(long spaceNo); 
}