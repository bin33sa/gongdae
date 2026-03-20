package com.gongdae.app.admin.domain.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class DashboardDto {
    
    private long totalPageViews;     
    private long monthlyVisitors;    
    private long totalMembers;       
    private long totalReservations;  
    private List<Long> monthlyRevenue; 
    private List<Long> monthlyExpense; 
    private List<Long> weeklyVisitors;     
    private List<Long> hourlyVisitors;
    private List<RecentReservationDto> recentReservations; 

    @Getter
    @Setter
    @NoArgsConstructor
    public static class RecentReservationDto {
        private String resNo;       
        private String guestName;   
        private String spaceName;  
        private String resDate;    
        private String status;     
        private String statusColor; 
    }
}