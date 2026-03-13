package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SpaceOptionDTO {
    private Long optionNo;
    private String type;      // 가전, 시설, 비품 등
    private String name;      // 프로젝터, 와이파이 등
    private String iconUrl;
}
