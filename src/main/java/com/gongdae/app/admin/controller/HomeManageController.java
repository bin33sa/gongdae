package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeManageController {
	 
	@GetMapping("/admin")
	public String handleHome(Model model) {
		 model.addAttribute("pageTitle", "관리자 메인");
		 model.addAttribute("contentPage", "/WEB-INF/views/admin/main/home.jsp");
		 return "admin/layout";
	}
	
	@GetMapping("/admin/sales/daily")
	public String userList(Model model) {
	    model.addAttribute("pageTitle", "사이트 매출");
	    model.addAttribute("contentPage", "/WEB-INF/views/admin/menu/list.jsp");
	    return "admin/layout";
	}
}
