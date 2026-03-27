package com.gongdae.app.admin.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import com.gongdae.app.admin.domain.dto.SalesManageDto;

@Mapper
public interface SaleManageMapper {
    SalesManageDto getTodaySummary();
    List<SalesManageDto> getDailySalesList();
    SalesManageDto getThisMonthSummary();
    SalesManageDto getLastMonthSummary();
    List<SalesManageDto> getMonthlySalesList();

    int getReservationCount(Map<String, Object> map);
    List<SalesManageDto> getReservationList(Map<String, Object> map);
    SalesManageDto getReservationDetail(Long resNo);
}