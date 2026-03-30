package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.admin.domain.dto.SalesManageDto;

public interface SaleManageService {
	SalesManageDto getTodaySummary();
    List<SalesManageDto> getDailySalesList();
    SalesManageDto getThisMonthSummary();
    SalesManageDto getLastMonthSummary();
    List<SalesManageDto> getMonthlySalesList();
    
    int getReservationCount(Map<String, Object> map);
    List<SalesManageDto> getReservationList(Map<String, Object> map);
    SalesManageDto getReservationDetail(Long resNo);
}
