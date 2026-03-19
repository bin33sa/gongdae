package com.gongdae.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.SpaceManageDTO;

@Mapper
public interface SpaceManageMapper {

	long spaceSeq();
    long unitSeq();

    // 등록 폼용 데이터 호출
    List<Map<String, Object>> listCategory();
    List<Map<String, Object>> listOption();

    // 공간 등록
    void insertSpace(SpaceManageDTO dto) throws Exception;
    void insertSpaceImage(SpaceManageDTO dto) throws Exception;
    void insertSpaceOption(SpaceManageDTO dto) throws Exception;
    
    void insertSpaceUnit(SpaceManageDTO dto) throws Exception;
    void insertSpacePolicy(SpaceManageDTO dto) throws Exception;
    void insertSpaceUnitTime(SpaceManageDTO dto) throws Exception;
}