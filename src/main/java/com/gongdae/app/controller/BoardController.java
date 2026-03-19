package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	@GetMapping("/event")
	public String eventList() throws Exception {
	
		return "common/event";
	}
	@GetMapping("/event/detail")
	public String eventDetail() throws Exception {
		
		return "common/eventDetail";
	}
	
	@GetMapping("/faq")
	public String faq() throws Exception {
		
		return "common/faq";
	}
	
	@GetMapping("/notice")
	public String noticeList() throws Exception {
		
		return "common/notice";
	}
	
	@GetMapping("/notice/detail")
	public String noticeDetail() throws Exception {
		
		return "common/noticeDetail";
	}
	
	
}
