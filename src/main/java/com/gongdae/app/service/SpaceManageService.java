package com.gongdae.app.service;

import java.util.List;
import java.util.Map;
import com.gongdae.app.domain.dto.SpaceManageDTO;

public interface SpaceManageService {
	public void insertSpace(SpaceManageDTO dto, String uploadPath) throws Exception;
	public void updateSpace(SpaceManageDTO dto, String uploadPath) throws Exception;
    public void deleteSpace(long spaceNo, long hostId) throws Exception; // 💡 파라미터 간소화
    
    public List<Map<String, Object>> listCategory() throws Exception;
    public List<Map<String, Object>> listOption() throws Exception;
    
    SpaceManageDTO findById(long spaceNo) throws Exception;
    List<SpaceManageDTO> listSpaceImage(long spaceNo) throws Exception;
    List<Long> listSpaceOption(long spaceNo) throws Exception;
    List<SpaceManageDTO> listSpaceUnit(long spaceNo) throws Exception;
    List<SpaceManageDTO> listSpace(long hostId) throws Exception;
}