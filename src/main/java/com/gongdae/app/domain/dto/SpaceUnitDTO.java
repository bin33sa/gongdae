package com.gongdae.app.domain.dto;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SpaceUnitDTO {
    private Long unitNo;
    private String title;
    private Integer pricePerHour;
    private Integer maxCapacity;
    private String description;
    private String thumbnailUrl;
    private Integer minHours; // 정책 테이블에서 조인
}