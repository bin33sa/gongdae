package com.gongdae.app.domain.dto;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SpaceDetailDTO {
    private Long spaceNo;
    private String spaceName;
    private String address;
    private String detailAddr;
    private String description;
    
    // 조인해서 가져올 추가 데이터
    private String hostName;       // 호스트 이름
    private Integer pricePerHour;  // 대표 가격 (룸 중 최저가)
}