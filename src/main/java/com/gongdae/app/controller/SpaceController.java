package com.gongdae.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceDTO;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.SpaceService;

import jakarta.mail.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/space/*")
public class SpaceController {
	private final SpaceService service;

	@GetMapping("search")
	public String searchPage(Model model) throws Exception {
		SessionInfo info = LoginMemberUtil.getSessionInfo();
		
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		List<CategoryDTO> categoryList = service.categoryList();
		
		model.addAttribute("categoryList", categoryList);
		
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
	
	
	
	
	@GetMapping("list")
	public ResponseEntity<?> spaceList() throws Exception {
		// 넘겨받는 데이터
		// pageNo, kwd, region, capacity, categoryIdx, date, startTime, endTime, orderType
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			SessionInfo info = LoginMemberUtil.getSessionInfo();
			
			
			List<SpaceDTO> list = service.spaceList();
			
			// 전달해야될 요소: 검색된 클래스 목록, 현재 페이지, 총 페이지 수
			
			result.put("list", list);
			
			
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(result);
	}
	
	
	
	
}
