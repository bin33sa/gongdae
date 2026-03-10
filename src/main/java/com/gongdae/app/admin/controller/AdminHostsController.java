package com.gongdae.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/hosts/*")
@Slf4j
public class AdminHostsController {
	
	@GetMapping("list")
    public String handlelist() {
        return "admin/hosts/list"; 
    }
	
}
