package com.gongdae.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gongdae.app.admin.domain.dto.SalesManageDto;
import com.gongdae.app.admin.service.SaleManageService;
import com.gongdae.app.common.MyUtil;
import com.gongdae.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/sales/*")
@Slf4j
public class AdminSalesController {
	
    private final SaleManageService saleService;
    private final PaginateUtil paginateUtil;
    private final MyUtil myUtil;

    @GetMapping("daily")
    public String handledaily(Model model) {
        model.addAttribute("today", saleService.getTodaySummary());
        model.addAttribute("dailyList", saleService.getDailySalesList());
        return "admin/sales/daily"; 
    }
	
    @GetMapping("monthly")
    public String handlemonthly(Model model) {
        model.addAttribute("thisMonth", saleService.getThisMonthSummary());
        model.addAttribute("lastMonth", saleService.getLastMonthSummary());
        model.addAttribute("monthlyList", saleService.getMonthlySalesList());
        return "admin/sales/monthly"; 
    }

    @GetMapping("list")
    public String handlelist(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "col", defaultValue = "guestName") String col,
            @RequestParam(name = "kw", defaultValue = "") String kw,
            @RequestParam(name = "status", defaultValue = "") String status,
            @RequestParam(name = "startDate", defaultValue = "") String startDate,
            @RequestParam(name = "endDate", defaultValue = "") String endDate,
            HttpServletRequest req,
            Model model) throws Exception {

        int size = 10;
        int dataCount = 0;

        Map<String, Object> map = new HashMap<>();
        map.put("col", col);
        map.put("kw", kw);
        map.put("status", status);
        map.put("startDate", startDate);
        map.put("endDate", endDate);

        dataCount = saleService.getReservationCount(map);

        int total_page = paginateUtil.pageCount(dataCount, size);
        if (current_page > total_page) {
            current_page = total_page;
        }

        int offset = (current_page - 1) * size;
        if(offset < 0) offset = 0;
        
        map.put("offset", offset);
        map.put("size", size);

        List<SalesManageDto> list = saleService.getReservationList(map);

        String cp = req.getContextPath();
        String query = "";

        if (!kw.isBlank()) {
            query = "col=" + col + "&kw=" + myUtil.encodeUrl(kw); 
        }
        if (!status.isBlank()) {
            query += (query.isBlank() ? "" : "&") + "status=" + status;
        }
        if (!startDate.isBlank()) {
            query += (query.isBlank() ? "" : "&") + "startDate=" + startDate;
        }
        if (!endDate.isBlank()) {
            query += (query.isBlank() ? "" : "&") + "endDate=" + endDate;
        }

        String listUrl = cp + "/admin/sales/list";
        String articleUrl = cp + "/admin/sales/article?page=" + current_page; 

        if (!query.isBlank()) {
            listUrl += "?" + query;
            articleUrl += "&" + query;
        }

        String paging = paginateUtil.paging(current_page, total_page, listUrl);

        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("size", size);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
        model.addAttribute("query", query); 
        model.addAttribute("articleUrl", articleUrl); 

        model.addAttribute("col", col);
        model.addAttribute("kw", kw);
        model.addAttribute("status", status);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "admin/sales/list";
    }
    
    @GetMapping("article")
    public String handleArticle(
            @RequestParam("resNo") Long resNo,
            @RequestParam(value = "page", defaultValue = "1") String page,
            HttpServletRequest req,
            Model model) {

        SalesManageDto dto = saleService.getReservationDetail(resNo);

        if (dto == null) {
            return "redirect:/admin/sales/list?page=" + page;
        }

        String query = "page=" + page;
        String queryString = req.getQueryString();
        
        if (queryString != null) {
            query = queryString.replaceAll("&?resNo=\\d+", "");
        }

        model.addAttribute("dto", dto);
        model.addAttribute("page", page);
        model.addAttribute("query", query);

        return "admin/sales/article";
    }
}