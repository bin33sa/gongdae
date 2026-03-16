package com.gongdae.app.guest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/my/*")
public class MyController {
	
	
	@GetMapping("grade")
	public String grade() throws Exception {
		return "guest/my/grade";
	}
	@GetMapping("mileage")
	public String mileage() throws Exception {
		return "guest/my/mileage";
	}
	@GetMapping("coupon")
	public String coupon() throws Exception {
		return "guest/my/coupon";
	}
	
	@GetMapping("wishlist")
	public String wishList() throws Exception {
		return "guest/my/wishlist";
	}
	
}
