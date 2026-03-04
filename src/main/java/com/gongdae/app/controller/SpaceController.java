package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		
		
		return "";
	}
}
