package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/site/*")
@Slf4j
public class AdminSiteController {
	
	@GetMapping("report")
    public String handleReport() {
        return "admin/site/report"; 
    }
	
	@GetMapping("banner")
    public String handleBanner() {
        return "admin/site/banner"; 
    }
	
	@GetMapping("component")
    public String handleComponent() {
        return "admin/site/component"; 
    }
}
