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

import com.gongdae.app.admin.service.HostManageService;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceDTO;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.SpaceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/space/*")
public class SpaceController {
	private final SpaceService service;
	private final HostManageService hostService;

	@GetMapping("search")
	public String searchPage(@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "category", defaultValue = "") String category,
			@RequestParam(name = "region", defaultValue = "") String region,
			Model model) throws Exception {
		
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("kwd", kwd);
			params.put("category", category);
			params.put("region", region);
			
			model.addAttribute("categoryList", service.categoryList());
			model.addAttribute("kwd", kwd);
			model.addAttribute("category", category);
			model.addAttribute("region", region);
			
			model.addAttribute("premiumCount", service.premiumCount(params));
			model.addAttribute("spaceCount", service.spaceCount(params));
		} catch (Exception e) {
		}
		
		return "space/search";
	}
	
	@GetMapping("{id}")
	public String detailPage(@PathVariable(name = "id") long spaceId, Model model) throws Exception {
		
		try {			
			SpaceDTO space = service.findSpaceById(spaceId);
			List<String> spaceImageList = service.spaceImageList(spaceId);
			
			model.addAttribute("space", space);
			model.addAttribute("spaceUnits", service.spaceUnitList(spaceId));
			model.addAttribute("spaceImageList", spaceImageList);
			model.addAttribute("spaceImageCount", spaceImageList.size());
			
			model.addAttribute("host", hostService.findById(space.getHost_id()));
			
		} catch (Exception e) {
		}
		return "space/detail";
	}
	
	

	
	@PostMapping("homeSpacelist")
	public ResponseEntity<?> homeSpaceList(@RequestParam(name = "category", defaultValue = "") String category) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			SessionInfo info = LoginMemberUtil.getSessionInfo();

			String guestId = "";
			if(info != null) guestId = info.getLogin_id();
			
			Map<String, Object> params = new HashMap<>();
			params.put("category", category);
			params.put("guest", guestId);
			
			List<SpaceDTO> list = service.homeSpaceList(params);
			
			result.put("list", list);
			
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("premiumSpaceList")
	public ResponseEntity<?> premiumSpaceList(@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "category", defaultValue = "") String category,
			@RequestParam(name = "region", defaultValue = "") String region) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			
			Map<String, Object> params = new HashMap<>();
			params.put("kwd", kwd);
			params.put("category", category);
			params.put("region", region);
			
			List<SpaceDTO> list = service.premiumSpaceList(params);
			
			result.put("list", list);
			
			
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("list")
	public ResponseEntity<?> spaceList(@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "category", defaultValue = "") String category,
			@RequestParam(name = "region", defaultValue = "") String region) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			
			Map<String, Object> params = new HashMap<>();
			params.put("kwd", kwd);
			params.put("category", category);
			params.put("region", region);
			
			List<SpaceDTO> list = service.spaceList(params);
			
			result.put("list", list);
			
			
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(result);
	}
	
	
	
}
