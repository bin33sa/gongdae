package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gongdae.app.service.SpaceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	private final SpaceService service;
	
	@GetMapping("/")
	public String handleHome(Model model) {
		
		model.addAttribute("categoryList", service.categoryList());
		
		return "guest/main/home";
	}
	
	
	
}
