package com.gongdae.app.admin.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gongdae.app.admin.domain.dto.DashboardDto;
import com.gongdae.app.admin.service.AdminDashboardService;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/*")
@Slf4j
public class HomeManageController {
    
    private final AdminDashboardService dashboardService;
    
    @GetMapping("login")
    public String handleLogin(@RequestParam(name = "error", required = false) String error, Model model) {
        
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        
        if (info != null) {
            if (info.getUserLevel() >= 50) {
                return "redirect:/admin/main";
            } else {
                return "redirect:/";
            }
        }
        
        if (error != null) {
            model.addAttribute("message", "관리자 인증에 실패하였습니다.");
        }
        
        return "admin/login";
    }

    @GetMapping("main")
    public String handleHome(Model model) {
        DashboardDto dto = new DashboardDto();

        try {
            dto.setTotalPageViews(dashboardService.countTotalPageViews());
            dto.setMonthlyVisitors(dashboardService.countMonthlyVisitors());
            dto.setTotalMembers(dashboardService.countTotalMembers());
            dto.setTotalReservations(dashboardService.countTotalReservations());

            List<Map<String, Object>> revList = dashboardService.getMonthlyRevenue();
            List<Map<String, Object>> expList = dashboardService.getMonthlyExpense();
            List<Map<String, Object>> weekList = dashboardService.getWeeklyVisitors();
            List<Map<String, Object>> hourList = dashboardService.getHourlyVisitors(); 

            List<Long> monthlyRev = new ArrayList<>(Collections.nCopies(12, 0L));
            List<Long> monthlyExp = new ArrayList<>(Collections.nCopies(12, 0L));
            
            if (revList != null) {
                for (Map<String, Object> map : revList) {
                    int monthIndex = ((Number) map.get("MONTH")).intValue() - 1;
                    monthlyRev.set(monthIndex, ((Number) map.get("AMOUNT")).longValue());
                }
            }
            if (expList != null) {
                for (Map<String, Object> map : expList) {
                    int monthIndex = ((Number) map.get("MONTH")).intValue() - 1;
                    monthlyExp.set(monthIndex, ((Number) map.get("AMOUNT")).longValue());
                }
            }
            dto.setMonthlyRevenue(monthlyRev);
            dto.setMonthlyExpense(monthlyExp);

            List<Long> weeklyVis = new ArrayList<>(Collections.nCopies(7, 0L));
            if (weekList != null) {
                for (Map<String, Object> map : weekList) {
                    int dayIndex = ((Number) map.get("DAY_INDEX")).intValue();
                    weeklyVis.set(dayIndex, ((Number) map.get("CNT")).longValue());
                }
            }
            dto.setWeeklyVisitors(weeklyVis);

            // ✨ 수정 완료: 0~23시까지 총 24개의 공간을 가진 리스트 생성
            List<Long> hourlyVis = new ArrayList<>(Collections.nCopies(24, 0L));
            if (hourList != null) {
                for (Map<String, Object> map : hourList) {
                    int hour = ((Number) map.get("HOUR")).intValue();
                    // HOUR 값 자체를 인덱스(0~23)로 사용하여 해당 시간의 CNT를 업데이트
                    if (hour >= 0 && hour < 24) {
                        hourlyVis.set(hour, ((Number) map.get("CNT")).longValue());
                    }
                }
            }
            dto.setHourlyVisitors(hourlyVis); 

            dto.setRecentReservations(dashboardService.getRecentReservations());

        } catch (Exception e) {
            log.info("handleHome : ", e);
        }

        model.addAttribute("dto", dto);
        
        return "admin/main/home"; 
    }
}