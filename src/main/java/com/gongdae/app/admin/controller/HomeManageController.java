package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/*")
@Slf4j
public class HomeManageController {
	 
	@GetMapping("login")
    public String handleLogin(@RequestParam(name = "error", required = false) String error,
            Model model) {
        
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
    public String handleHome() {
        return "admin/main/home"; 
    }
	
}
