package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/bbs/*")
@Slf4j
public class AdminBoardController {
	
	@GetMapping("list")
    public String handleList() {
        return "admin/bbs/list"; 
    }
	
	@GetMapping("notice")
    public String handleNotice() {
        return "admin/bbs/notice"; 
    }
}
