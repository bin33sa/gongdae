package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/space/*")
public class SpaceController {

	@GetMapping("search")
	public String searchPage() throws Exception {
		SessionInfo info = LoginMemberUtil.getSessionInfo();
		
		
		
		return "common/space/search";
	}
	
	@GetMapping("detail")
	public String detailPage() throws Exception {
		return "common/space/detail";
	}
	
	@GetMapping("payment")
	public String paymentForm() throws Exception {
		return "common/space/payment";
	}
}
