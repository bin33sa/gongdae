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
	
	@GetMapping("main/prelogin")
	public String prelogin() {
		return "host/main/prelogin";
	}

	@GetMapping("main/home")
	public String home() {
		return "host/main/home";
	}
	
	
	
	@GetMapping("menu/qna")
	public String qna() {
		return "host/menu/qna";
	}
	@GetMapping("menu/space")
	public String space() {
		return "host/menu/space";
	}
	
	@GetMapping("menu/sales")
	public String sales() {
		return "host/menu/sales";
	}
	@GetMapping("menu/reservation")
	public String reservation() {
		return "host/menu/reservation";
	}
	
	@GetMapping("menu/store")
	public String store() {
		return "host/menu/store";
	}
	
}
