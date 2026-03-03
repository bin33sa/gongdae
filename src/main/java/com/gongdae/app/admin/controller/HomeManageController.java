package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
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
	}
}
