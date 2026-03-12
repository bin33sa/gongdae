package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CommonController {
	
	
	@GetMapping("/terms")
	public String termsPage() {
		return "common/terms";
	}
	
	@GetMapping("/complete")
	public String completePage(@ModelAttribute("message") String message) throws Exception {
		
		if (message == null || message.isBlank()) { // F5를 누른 경우
			return "redirect:/";
		}
		
		return "common/complete";
	}
	
	
	
	
	
}
