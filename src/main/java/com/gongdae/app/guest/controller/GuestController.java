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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.common.RequestUtils;
import com.gongdae.app.domain.dto.GuestDto;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.guest.service.GuestService;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/guest/*")
public class GuestController {
	private final GuestService guestService;
	
	@Value("${file.upload-root}/member")
	private String uploadPath;

	@GetMapping("signup")
	public String signupForm(Model model) {
		model.addAttribute("mode", "signup");
		
		return "guest/member/signup";
	}
	
	@PostMapping("signup")
	public String signupSubmit(GuestDto dto,
			final RedirectAttributes rAttr,
			Model model) {
		 
		try {
			guestService.insertGuest(dto, uploadPath);
			
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

	@PostMapping("nicknameCheck")
	public ResponseEntity<?> handleNicknameCheck(@RequestParam(name = "nickname") String nickname) throws Exception {
		// 닉네임 중복 검사
		String p = "false";
		try {
			GuestDto dto = guestService.findByNickname(nickname);
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
		SessionInfo info = LoginMemberUtil.getSessionInfo();
		
		if(info != null) {
			return "redirect:/";
		}
		
		return "guest/member/findId";
	}
	
	@PostMapping("findId")
	public String findIdSubmit(
			@RequestParam(name = "name") String name,
			@RequestParam(name = "email") String email,
			RedirectAttributes reAttr,
			Model model) throws Exception {
		
		try {
			GuestDto dto = service.findGuestByNameAndEmail(name, email);
			
			if(dto == null || dto.getEnabled() == 0) {
				model.addAttribute("message", "등록된 아이디가 없습니다.");
				
				return "guest/member/findId";
			}
			
			// 아이디를 메일로 전송
			guestService.sendGuestId(dto);
			
			StringBuilder sb = new StringBuilder();
			sb.append("회원님의 이메일로 아이디를 전송했습니다.<br>");
			
			// 완료 페이지에서 이동할 경로 전달
			reAttr.addFlashAttribute("title", "아이디 찾기");
			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("btnText", "로그인");
			reAttr.addFlashAttribute("path", "member/login");
			
			return "redirect:/complete";
			
		} catch(Exception e) {
			model.addAttribute("message", "이메일 전송에 실패했습니다.");
		}
		
		return "guest/member/findId";
		
	}
	
	@GetMapping("findPwd")
	public String findPwdForm() throws Exception {
		SessionInfo info = LoginMemberUtil.getSessionInfo();
		
		if(info != null) {
			return "redirect:/";
		}
		
		return "guest/member/findPwd";
	}
	
	@PostMapping("findPwd")
	public String findPwdSubmit(
			@RequestParam(name = "login_id") String login_id,
			@RequestParam(name = "name") String name,
			@RequestParam(name = "email") String email,
			RedirectAttributes reAttr,
			Model model) throws Exception {
		
		
		
		try {
			GuestDto dto = guestService.findGuestByIdAndNameAndEmail(login_id, name, email);
			
			if(dto == null || dto.getEnabled() == 0) {
				model.addAttribute("message", "등록된 아이디가 없습니다.");
				
				return "guest/member/findPwd";
			}
			
			// 임시 패스워드를 메일로 전송
			guestService.sendGuestPwd(dto);
			
			StringBuilder sb = new StringBuilder();
			sb.append("회원님의 이메일로 임시패스워드를 전송했습니다.<br>");
			sb.append("로그인 후 패스워드를 변경하시기 바랍니다.<br>");
			
			// 완료 페이지에서 이동할 경로 전달
			reAttr.addFlashAttribute("title", "패스워드 찾기");
			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("btnText", "로그인");
			reAttr.addFlashAttribute("path", "member/login");
			
			return "redirect:/complete";
			
		} catch(Exception e) {
			model.addAttribute("message", "이메일 전송에 실패했습니다.");
		}
		
		return "guest/member/findPwd";
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


	
	
}
