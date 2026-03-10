package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/sales/*")
@Slf4j
public class AdminSalesController {
	
	@GetMapping("daily")
    public String handledaily() {
        return "admin/sales/daily"; 
    }
	
	@GetMapping("monthly")
    public String handlemonthly() {
        return "admin/sales/monthly"; 
    }
}
