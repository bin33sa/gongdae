package com.gongdae.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.SpaceManageDTO;

@Mapper
public interface SpaceManageMapper {
    
    // 1. 공간(SPACE) 시퀀스 및 기본 정보 등록
    public long spaceSeq();
    public void insertSpace(SpaceManageDTO dto);
    
    // 2. [신규 추가] 승인 대기열(SPACE_APPROVAL) 최초 등록 (PENDING 상태)
    public void insertSpaceApproval(long spaceNo);
    
    // 3. 옵션(SPACE_OPTION_MAPPING) 매핑 등록
    public void insertSpaceOption(SpaceManageDTO dto);
    
    // 4. 세부 룸(SPACE_UNIT) 시퀀스 및 기본 정보 등록
    public long spaceUnitSeq();
    public void insertSpaceUnit(SpaceManageDTO dto);
    
    // 5. 세부 룸 정책(SPACE_POLICY) 등록
    public void insertSpacePolicy(SpaceManageDTO dto);
    
    // 6. 룸별 추가 이미지(SPACE_IMAGE) 등록
    public void insertSpaceFile(SpaceManageDTO dto);
    
}