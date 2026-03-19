package com.gongdae.app.guest.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	private final GuestService service;
	
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
			service.insertGuest(dto, uploadPath);
			
			StringBuilder sb = new StringBuilder();
			sb.append(dto.getName() + "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

			// 리다이렉트된 페이지에 값 넘기기
			rAttr.addFlashAttribute("title", "회원 가입");
			rAttr.addFlashAttribute("message", sb.toString());

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

		return "guest/member/signup";
	}
	
	@PostMapping("update")
	public String updateSubmit(GuestDto dto,
			final RedirectAttributes rAttr,
			Model model) {
		
		StringBuilder sb = new StringBuilder();
		try {
			SessionInfo info = LoginMemberUtil.getSessionInfo();
			dto.setMember_id(info.getMember_id());
			
			service.updateGuest(dto, uploadPath);
			
			// 세션의 profile_photo 변경
			info.setAvatar(dto.getProfile_photo());
			
			sb.append(dto.getName() + "님의 회원정보가 정상적으로 변경되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
				
		} catch (Exception e) {
			sb.append(dto.getName() + "님의 회원정보 변경이 실패했습니다.<br>");
			sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
		}
		
		// 리다이렉트된 페이지에 값 넘기기
		rAttr.addFlashAttribute("title", "회원 정보 수정");
		rAttr.addFlashAttribute("message", sb.toString());
		return "redirect:/complete";
	}

	@PostMapping("nicknameCheck")
	public ResponseEntity<?> handleNicknameCheck(@RequestParam(name = "nickname") String nickname) throws Exception {
		// 닉네임 중복 검사
		String p = "false";
		try {
			GuestDto dto = service.findGuestByNickname(nickname);
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
			service.sendGuestId(dto);
			
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
			GuestDto dto = service.findGuestByIdAndNameAndEmail(login_id, name, email);
			
			if(dto == null || dto.getEnabled() == 0) {
				model.addAttribute("message", "등록된 아이디가 없습니다.");
				
				return "guest/member/findPwd";
			}
			
			// 임시 패스워드를 메일로 전송
			service.sendGuestPwd(dto);
			
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

	@GetMapping("pwd")
	public String pwdForm(@RequestParam(name = "dropout", required = false) String dropout, 
			Model model) {

		if (dropout == null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}

		return "guest/member/pwd";
	}
	
	
	@PostMapping("pwd")
	public String pwdSubmit(@RequestParam(name = "password") String password,
			@RequestParam(name = "mode") String mode, 
			final RedirectAttributes reAttr,
			Model model) {

		try {
			SessionInfo info = LoginMemberUtil.getSessionInfo();
			GuestDto dto = Objects.requireNonNull(service.findById(info.getMember_id()));

			boolean bPwd = service.isPasswordCheck(info.getLogin_id(), password);
			
			if (! bPwd) {
				model.addAttribute("mode", mode);
				model.addAttribute("message", "패스워드가 일치하지 않습니다.");
				
				return "guest/member/pwd";
			}

			if (mode.equals("dropout")) {
				// 게시판 테이블등 자료 삭제

				// 회원탈퇴 처리
				/*
				  Map<String, Object> map = new HashMap<>();
				  map.put("member_id", info.getMember_id());
				  map.put("filename", info.getAvatar());
				 */

				// 로그아웃
				LoginMemberUtil.logout();
				
				StringBuilder sb = new StringBuilder();
				sb.append(dto.getName() + "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

				reAttr.addFlashAttribute("title", "회원 탈퇴");
				reAttr.addFlashAttribute("message", sb.toString());

				return "redirect:/member/complete";
			}

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");
			
			// 회원정보수정폼
			return "guest/member/signup";
			
		} catch (NullPointerException e) {
			LoginMemberUtil.logout();
		} catch (Exception e) {
		}
		
		return "redirect:/";
	}
	
	
	@DeleteMapping("deleteProfile")
	public ResponseEntity<?> deleteProfilePhoto(@RequestParam(name = "profile_photo") String profile_photo) throws Exception {
		// 프로파일 포토 삭제
		SessionInfo info = LoginMemberUtil.getSessionInfo();
		
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


	//////////////////////////////////////////////////////////////////////////////////////// 
	@GetMapping("updatePwd")
	public String updatePwdForm() throws Exception{
		return "guest/member/updatePwd";
	}


	
	
}
