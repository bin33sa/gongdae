package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
@Slf4j
public class HomeManageController {
	 
<<<<<<< HEAD
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
=======
	@GetMapping("/login")
	public String handleLogin() {
		SessionInfo info = LoginMemberUtil.getSessionInfo();
	    
	    if (info != null) {
	        if (info.getUserLevel() >= 50) { 
	            return "redirect:/admin";
	        } else {
	            return "redirect:/";
	        }
	    }
		return "admin/login";
	}
	
	
	@GetMapping({"", "/"})
	public String handleHome() {
		return "admin/main/home";
>>>>>>> branch 'main' of https://github.com/bin33sa/gongdae.git
	}
}
