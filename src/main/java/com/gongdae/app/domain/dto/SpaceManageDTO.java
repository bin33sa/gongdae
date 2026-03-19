package com.gongdae.app.domain.dto;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
public class SpaceManageDTO {

   
	private long spaceNo;
    private long hostId;
    private long categoryNo;
    private Long adminId; // 관리자 번호 (nullable)
    private String spaceName;
    private String bizRegNum;
    private String address;
    private String detailAddr;
    private String region;
    private String bankName;
    private String accountNo;
    private String accountHolder;

    // 2. SPACE_IMAGE (공간 다중 이미지)
    private List<MultipartFile> addFiles;
    private String fileUrl; // DB Insert용

    // 3. SELECTED_SPACE_OPTION (편의시설 태그)
    private List<Long> optionNos;
    private long optionNo; // DB Insert용

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
    
    private String dayOfWeek;
    private String openTime;
    private String closeTime;
    private int cancelLimitHr;
    private int cleaningFee;
}