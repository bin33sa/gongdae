package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gongdae.app.service.BannerService;
import com.gongdae.app.service.BoardService;
import com.gongdae.app.service.SpaceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	private final SpaceService service;
	private final BoardService boardService;
	private final BannerService bannerService;
	
	@GetMapping("/")
	public String handleHome(Model model) {
		
		model.addAttribute("categoryList", service.categoryList());
		model.addAttribute("boardList", boardService.homeBoardList());
		model.addAttribute("bannerList", bannerService.getBanners());
		
		return "guest/main/home";
	}
	
	
	
}
