package com.gongdae.app.admin.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SalesManageDto {
	
    private String salesDate;      
    
    private long payCount;    
    private long payAmount;  
    
    private long refundCount;  
    private long refundAmount;   
    
    private long netAmount;     
    private long compareAmount;    
    
    private String settlementStatus; 

    private Long resNo;            
    private String resNoStr;      
    
    private Long guestId;        
    private String guestName;      
    
    private String spaceName;     
    private String unitName;       
    
    private String resDate;       
    private String payDate;        
    private long amount;           
    
    private String payStatus;      
    private String resStatus;     
    private String statusColor;   
}