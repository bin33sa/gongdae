package com.gongdae.app.host.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/host/*")
public class HostHomeController {
	
	@GetMapping("prelogin")
	public String prelogin() {
		return "host/prelogin";
	}

	@GetMapping("")
	public String home() {
		return "host/main/home";
	}
	
	
}
