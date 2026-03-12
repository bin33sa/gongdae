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

   
    private Long spaceNo; 
    private Long hostId; 
    private Long categoryNo; 
    private Long adminId;      
    private String spaceName; 
    private String bizRegNum; 
    private String address;
    private String detailAddr; 
    private String region; 
    private String bankName; 
    private String accountNo; 
    private String accountHolder;
    private String createdAt;  
    private String updatedAt;  

   
    private List<Long> unitNos;
    private List<String> unitTitles;
    private List<Integer> pricePerHours;
    private List<Integer> maxCapacities;
    private List<String> descriptions;
    private List<MultipartFile> unitThumbnailFiles;

   
    private List<Integer> minHours;
    private List<Integer> cancelLimitHrs;
    private List<Integer> cleaningFees;

    
    private List<MultipartFile> addFiles;
    private List<Long> optionNos;

    
    private Long unitNo; 
    private String unitTitle;
    private Integer pricePerHour; 
    private Integer maxCapacity; 
    private String description; 
    private String thumbnailUrl; 

    
    private Long policyNo; 
    private Integer minHour;
    private Integer cancelLimitHr; 
    private Integer cleaningFee; 

    
    private Long imageNo; 
    private String fileUrl; 
    private Integer sortOrder; 

   
    private Long optionNo; 

}