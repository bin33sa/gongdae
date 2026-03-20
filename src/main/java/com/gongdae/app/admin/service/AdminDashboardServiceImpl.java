package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.admin.domain.dto.DashboardDto.RecentReservationDto;
import com.gongdae.app.admin.mapper.AdminDashboardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminDashboardServiceImpl implements AdminDashboardService {

    private final AdminDashboardMapper mapper;

    @Override
    public long countTotalPageViews() {
        long result = 0;

        try {
            result = mapper.countTotalPageViews();
        } catch (Exception e) {
            log.info("countTotalPageViews : ", e);
        }

        return result;
    }

    @Override
    public long countMonthlyVisitors() {
        long result = 0;

        try {
            result = mapper.countMonthlyVisitors();
        } catch (Exception e) {
            log.info("countMonthlyVisitors : ", e);
        }

        return result;
    }

    @Override
    public long countTotalMembers() {
        long result = 0;

        try {
            result = mapper.countTotalMembers();
        } catch (Exception e) {
            log.info("countTotalMembers : ", e);
        }

        return result;
    }

    @Override
    public long countTotalReservations() {
        long result = 0;

        try {
            result = mapper.countTotalReservations();
        } catch (Exception e) {
            log.info("countTotalReservations : ", e);
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getMonthlyRevenue() {
        List<Map<String, Object>> list = null;

        try {
            list = mapper.getMonthlyRevenue();
        } catch (Exception e) {
            log.info("getMonthlyRevenue : ", e);
        }

        return list;
    }

    @Override
    public List<Map<String, Object>> getMonthlyExpense() {
        List<Map<String, Object>> list = null;

        try {
            list = mapper.getMonthlyExpense();
        } catch (Exception e) {
            log.info("getMonthlyExpense : ", e);
        }

        return list;
    }

    @Override
    public List<Map<String, Object>> getWeeklyVisitors() {
        List<Map<String, Object>> list = null;

        try {
            list = mapper.getWeeklyVisitors();
        } catch (Exception e) {
            log.info("getWeeklyVisitors : ", e);
        }

        return list;
    }

    @Override
    public List<Map<String, Object>> getHourlyVisitors() {
        List<Map<String, Object>> list = null;

        try {
            list = mapper.getHourlyVisitors();
        } catch (Exception e) {
            log.info("getHourlyVisitors : ", e);
        }

        return list;
    }

    @Override
    public List<RecentReservationDto> getRecentReservations() {
        List<RecentReservationDto> list = null;

        try {
            list = mapper.getRecentReservations();
        } catch (Exception e) {
            log.info("getRecentReservations : ", e);
        }

        return list;
    }
}