package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class HostSalesDTO {
    private long thisMonthSales;    
    private long totalSales;        
    
    private int thisMonthResCount;  
    private int totalResCount;      
}