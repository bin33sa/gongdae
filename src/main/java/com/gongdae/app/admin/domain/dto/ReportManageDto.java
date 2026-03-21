package com.gongdae.app.admin.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReportManageDto {
	
    private long reportNo;       
    private String reason;       
    private String status;       
    private String createdAt;    
    private String updatedAt;    
    private String adminMemo;    

    private long memberId;        
    private String reporterName;  

    private String targetType;    
    private long targetNo;        
    private String targetName;   

    private Long adminId;        
    private String adminName;    
}