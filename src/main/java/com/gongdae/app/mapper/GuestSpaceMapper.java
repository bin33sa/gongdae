package com.gongdae.app.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.gongdae.app.domain.dto.SpaceDetailDTO;
import com.gongdae.app.domain.dto.SpaceOptionDTO;
import com.gongdae.app.domain.dto.SpaceUnitDTO;

@Mapper
public interface GuestSpaceMapper {
    // 1. 공간 기본 정보 (+ 호스트 이름, 최저가)
    public SpaceDetailDTO getSpaceDetail(long spaceNo) throws Exception;
    
    // 2. 공간 갤러리 이미지 목록
    public List<String> getSpaceImages(long spaceNo) throws Exception;
    
    // 3. 편의시설 옵션 목록 (중복 제거)
    public List<SpaceOptionDTO> getSpaceOptions(long spaceNo) throws Exception;
    
    // 4. 예약 가능한 세부 룸 목록
    public List<SpaceUnitDTO> getSpaceUnits(long spaceNo) throws Exception;
}