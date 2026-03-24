package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;
import com.gongdae.app.admin.domain.dto.SpaceManageDto;

public interface AdminSpaceManageService {
    int dataCountSpace(Map<String, Object> map) throws Exception;
    List<SpaceManageDto> listSpace(Map<String, Object> map) throws Exception;
    
    int dataCountPremium(Map<String, Object> map) throws Exception;
    List<SpaceManageDto> listPremium(Map<String, Object> map) throws Exception;
    
    void updateSpaceStatus(Map<String, Object> map) throws Exception;
    
    void approvePremium(Map<String, Object> map) throws Exception;
    void cancelPremium(Map<String, Object> map) throws Exception;
    void insertPremiumForce(Map<String, Object> map) throws Exception;

    SpaceManageDto findByIdSpace(long spaceNo) throws Exception;
    List<SpaceManageDto> listSpaceImage(long spaceNo) throws Exception;
    List<SpaceManageDto> listSpaceUnit(long spaceNo) throws Exception;
}