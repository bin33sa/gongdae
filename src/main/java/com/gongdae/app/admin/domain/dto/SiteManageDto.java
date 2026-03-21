package com.gongdae.app.admin.domain.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SiteManageDto {
    private long bannerNo;           
    private String type;             
    private String title;            
    private String linkUrl;          
    private String saveFilename;    
    private String originalFilename;  
    private MultipartFile selectFile; 
    private int isActive;             
    private String createdAt;
    private String updatedAt;

    private String componentKey;     
    private String componentValue;   
    private String description;

    private Long adminId;        
    private String adminName;    
}