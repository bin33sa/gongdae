package com.gongdae.app.admin.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import com.gongdae.app.admin.domain.dto.SpaceManageDto;

@Mapper
public interface AdminSpaceManageMapper {
    int dataCountSpace(Map<String, Object> map) throws Exception;
    List<SpaceManageDto> listSpace(Map<String, Object> map) throws Exception;
    
    int dataCountPremium(Map<String, Object> map) throws Exception;
    List<SpaceManageDto> listPremium(Map<String, Object> map) throws Exception;
    
    void updateSpaceStatus(Map<String, Object> map) throws Exception;
    
    void updateSpacePremiumFlagToY(Long spaceNo) throws Exception;
    void updateSpacePremiumFlagToN(Long spaceNo) throws Exception;
    void approvePremium(Map<String, Object> map) throws Exception;
    void cancelPremium(Map<String, Object> map) throws Exception;
    void insertPremiumForce(Map<String, Object> map) throws Exception;

    SpaceManageDto findByIdSpace(long spaceNo) throws Exception;
    List<SpaceManageDto> listSpaceImage(long spaceNo) throws Exception;
    List<SpaceManageDto> listSpaceUnit(long spaceNo) throws Exception;
}