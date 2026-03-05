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
@RequestMapping(value = "/member/*")
public class MemberController {

	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "error", required = false) String error, 
			Model model) {
		
		if(error != null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		
		return "guest/member/login";
	}
	
	@GetMapping("findId")
	public String findIdForm() throws Exception {
		return "guest/member/findId";
	}
	
	@PostMapping("findId")
	public String findIdSubmit() throws Exception {
		return "redirect:/member/login";
	}
	
	@GetMapping("findPwd")
	public String findPwdForm() throws Exception {
		return "guest/member/findPwd";
	}
	
	@PostMapping("findPwd")
	public String findPwdSubmit() throws Exception {
		
		return "redirect:/member/login";
	}
	
	@GetMapping("signup")
	public String signupForm() throws Exception {
		return "guest/member/signup";
	}
	
	@PostMapping("signup")
	public String signupSubmit() throws Exception {
		 
		return "redirect:/member/login";
	}

	@GetMapping("edit")
	public String editForm() throws Exception {
		return "guest/member/edit";
	}

	@PostMapping("edit")
	public String editSubmit() throws Exception {
		return "guest/member/complete";
	}
	
	
	

	//////////////////////////////////////////////////////////////////////////////////////// 
	@GetMapping("updatePwd")
	public String updatePwdForm() throws Exception{
		return "guest/member/updatePwd";
	}



	
	@GetMapping("noAuthorized")
	public String noAuthorized(Model model) {
		
		return "guest/error/noAuthorized";
	}

	@GetMapping("expired")
	public String expired() throws Exception {
		
		return "guest/error/expired";
	}	
}
