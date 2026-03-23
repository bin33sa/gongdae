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

   
    private String spaceIntro;
    private String spaceGuide;
    private String status;

   
    private List<MultipartFile> addFiles;
    private String fileUrl; 
    private long imageNo;

    
    private List<Long> deleteImageNos;
    private List<String> existThumbnailUrls;

   
    private List<Long> optionNos;
    private long optionNo; 

   
    private List<String> unitTitles;
    private List<Integer> pricePerHours;
    private List<Integer> maxCapacities;
    private List<String> descriptions;
    private List<MultipartFile> unitThumbnailFiles;
    
   
    private List<Integer> minHours;
    private List<Integer> cancelLimitHrs;
    private List<Integer> cleaningFees;

    private List<String> openTimes;
    private List<String> closeTimes;
    
    private String isPremium;
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