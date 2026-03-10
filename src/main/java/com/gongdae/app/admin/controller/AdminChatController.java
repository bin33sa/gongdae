package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/chat/*")
@Slf4j
public class AdminChatController {
	
	@GetMapping("room")
    public String handleHome() {
        return "admin/chat/room"; 
    }
}
