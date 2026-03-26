package com.gongdae.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.gongdae.app.domain.dto.MemberDto;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {
	private final MemberService service;
	
	@Value("${file.upload-root}/member")
	private String uploadPath;

	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "error", required = false) String error, 
			Model model) {
		
		if(error != null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		
		return "guest/member/login";
	}
	
	@PostMapping("userIdCheck")
	public ResponseEntity<?> handleUserIdCheck(@RequestParam(name = "login_id") String login_id) throws Exception {
		// ID 중복 검사
		String p = "false";
		try {
			MemberDto dto = service.findById(login_id);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(Map.of(
			"passed", p
		));
	}
	
	
	@DeleteMapping("deleteProfile")
	public ResponseEntity<?> deleteProfilePhoto(@RequestParam(name = "profile_photo") String profile_photo,
			@SessionAttribute("member") SessionInfo info) throws Exception {
		// 프로파일 포토 삭제
		try {
			if(! profile_photo.isBlank()) {
				Map<String, Object> map = new HashMap<>();
				map.put("member_id", info.getMember_id());
				map.put("filename", info.getAvatar());
				// map.put("filename", profile_photo);
				
				service.deleteProfilePhoto(map, uploadPath);
				
				info.setAvatar(null);
			}
			
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		}
	}	
	
	
}
