package com.gongdae.app.host.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

	@GetMapping("menu/store")
	public String store(Model model) {
	    model.addAttribute("active", "store");
	    return "host/menu/store";
	}

	@GetMapping("menu/space")
	public String space(Model model) {
	    model.addAttribute("active", "space");
	    return "host/menu/space";
	}

	@GetMapping("menu/qna")
	public String qna(Model model) {
	    model.addAttribute("active", "qna");
	    return "host/menu/qna";
	}

	@GetMapping("menu/reservation")
	public String reservation(Model model) {
	    model.addAttribute("active", "reservation");
	    return "host/menu/reservation";
	}

	@GetMapping("menu/sales")
	public String sales(Model model) {
	    model.addAttribute("active", "sales");
	    return "host/menu/sales";
	}

	@GetMapping("main/home")
	public String home(Model model) {
	    model.addAttribute("active", "home");
	    return "host/main/home";
	}
	
}
