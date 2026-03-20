package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;
import com.gongdae.app.admin.domain.dto.DashboardDto.RecentReservationDto;

public interface AdminDashboardService {
    long countTotalPageViews();
    long countMonthlyVisitors();
    long countTotalMembers();
    long countTotalReservations();
    
    List<Map<String, Object>> getMonthlyRevenue();
    List<Map<String, Object>> getMonthlyExpense();
    List<Map<String, Object>> getWeeklyVisitors();
    List<Map<String, Object>> getHourlyVisitors();
    
    List<RecentReservationDto> getRecentReservations();
}