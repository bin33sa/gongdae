package com.gongdae.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
			model.addAttribute("categoryList", service.categoryList());
			
		} catch (Exception e) {
		}
		
		return "common/space/search";
	}
	
	@GetMapping("detail/{id}")
	public String detailPage(@PathVariable(name = "id") String spaceId, Model model) throws Exception {
		
		try {
			model.addAttribute("space", service.findSpaceById(spaceId));
			
		} catch (Exception e) {
		}
		return "common/space/detail";
	}
	
	@GetMapping("payment")
	public String paymentForm() throws Exception {
		return "common/space/payment";
	}
	
	
	
	
	@PostMapping("list")
	public ResponseEntity<?> spaceList(@RequestParam(name = "category") String category) throws Exception {
		// 넘겨받는 데이터
		// pageNo, kwd, region, capacity, categoryIdx, date, startTime, endTime, orderType
		
		System.out.println("spacelist:controller");
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			SessionInfo info = LoginMemberUtil.getSessionInfo();
			
			Map<String, Object> params = new HashMap<>();
			
			List<SpaceDTO> list = service.spaceList(params);
			
			// 전달해야될 요소: 검색된 클래스 목록, 현재 페이지, 총 페이지 수
			
			result.put("list", list);
			
			
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(result);
	}
	
	
	
	
}
