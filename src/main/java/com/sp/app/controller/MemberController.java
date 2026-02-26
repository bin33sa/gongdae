package com.sp.app.controller;

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
@RequestMapping(value = "/member/*")
public class MemberController {

	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "error", required = false) String error, 
			Model model) {
		
		if(error != null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		
		return "member/login";
	}
	
	@GetMapping("findId")
	public String findIdForm() throws Exception {
		return "member/findId";
	}
	
	@PostMapping("findId")
	public String findIdSubmit() throws Exception {
		return "redirect:/member/login";
	}
	
	@GetMapping("findPwd")
	public String findPwdForm() throws Exception {
		return "member/findPwd";
	}
	
	@PostMapping("findPwd")
	public String findPwdSubmit() throws Exception {
		
		// 패스워드를 메일로 보내거나, 추가 인증 작업을 하고 로그인 창으로 리다이렉트
		return "redirect:/member/login";
	}
	
	@GetMapping("signup")
	public String signupForm() throws Exception {
		return "member/signup";
	}
	
	@PostMapping("signup")
	public String signupSubmit() throws Exception {
		
		// 로그인을 시켜주고 메인으로 가야할지, 로그인 페이지로 가야할지 모르겠음
		return "redirect:/member/login";
	}

	@GetMapping("edit")
	public String editForm() throws Exception {
		return "member/edit";
	}
	

	//////////////////////////////////////////////////////////////////////////////////////// 
	@GetMapping("updatePwd")
	public String updatePwdForm() throws Exception{
		return "member/updatePwd";
	}



	
	@GetMapping("noAuthorized")
	public String noAuthorized(Model model) {
		
		return "member/noAuthorized";
	}

	@GetMapping("expired")
	public String expired() throws Exception {
		
		return "member/expired";
	}	
}
