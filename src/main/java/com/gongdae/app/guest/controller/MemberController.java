package com.gongdae.app.guest.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.common.RequestUtils;
import com.gongdae.app.domain.dto.MemberDto;
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
	
	@GetMapping("signup")
	public String signupForm(Model model) {
		model.addAttribute("mode", "signup");
		
		return "guest/member/signup";
	}
	
	@PostMapping("signup")
	public String signupSubmit(MemberDto dto,
			final RedirectAttributes rAttr,
			Model model) {
		 
		try {
			dto.setIpAddr(RequestUtils.getClientIp());
			
			service.insertMember(dto, uploadPath);
			
			StringBuilder sb = new StringBuilder();
			sb.append(dto.getName() + "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

			// 리다이렉트된 페이지에 값 넘기기
			rAttr.addFlashAttribute("message", sb.toString());
			rAttr.addFlashAttribute("title", "회원 가입");

			return "redirect:/complete";
			
		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 조건 위반
			model.addAttribute("mode", "signup");
			model.addAttribute("message", "아이디 혹은 닉네임 중복으로 회원가입이 실패했습니다.");
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("mode", "signup");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
		} catch (Exception e) {
			model.addAttribute("mode", "signup");
			model.addAttribute("message", "회원가입이 실패했습니다.");
		}

		return "member/signup";
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

	@PostMapping("nicknameCheck")
	public ResponseEntity<?> handleNicknameCheck(@RequestParam(name = "nickname") String nickname) throws Exception {
		// 닉네임 중복 검사
		String p = "false";
		try {
			MemberDto dto = service.findByNickname(nickname);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}
		
		return ResponseEntity.ok(Map.of(
				"passed", p
				));
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
