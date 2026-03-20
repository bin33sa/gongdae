package com.gongdae.app.domain.dto;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SpaceManageDTO {
    // 1. SPACE 기본 정보
    private long spaceNo;
    private long hostId;
    private long categoryNo;
    private Long adminId; 
    private String spaceName;
    private String bizRegNum;
    private String address;
    private String detailAddr;
    private String region;
    private String bankName;
    private String accountNo;
    private String accountHolder;

    // 공간 소개 및 주의사항, 그리고 💡 상태값(ACTIVE/DELETED) 추가
    private String spaceIntro;
    private String spaceGuide;
    private String status;

    // 2. SPACE_IMAGE
    private List<MultipartFile> addFiles;
    private String fileUrl; 
    private long imageNo;

    // 💡 수정 시 이미지 및 썸네일 처리를 위한 배열들
    private List<Long> deleteImageNos;
    private List<String> existThumbnailUrls;

    // 3. SELECTED_SPACE_OPTION (편의시설 태그)
    private List<Long> optionNos;
    private long optionNo; 

    // 4. SPACE_UNIT (룸 정보 - 배열 바인딩)
    private List<String> unitTitles;
    private List<Integer> pricePerHours;
    private List<Integer> maxCapacities;
    private List<String> descriptions;
    private List<MultipartFile> unitThumbnailFiles;
    
    // SPACE_POLICY (룸 정책 - 배열 바인딩)
    private List<Integer> minHours;
    private List<Integer> cancelLimitHrs;
    private List<Integer> cleaningFees;

    private List<String> openTimes;
    private List<String> closeTimes;
    
    // 5. Unit DB Insert용 단일 변수
    private long unitNo;
    private String title;
    private int pricePerHour;
    private int maxCapacity;
    private String description;
    private String thumbnailUrl;
    private int minHour;
    private int cancelLimitHr;
    private int cleaningFee;
    
    private String dayOfWeek;
    private String openTime;
    private String closeTime;
}