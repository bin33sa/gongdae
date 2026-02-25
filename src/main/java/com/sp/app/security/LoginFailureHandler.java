package com.sp.app.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.sp.app.domain.dto.MemberDto;
import com.sp.app.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginFailureHandler implements AuthenticationFailureHandler {
	@Autowired
	private MemberService memberService;

	private String defaultFailureUrl;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		String login_id = request.getParameter("login_id");

		String errorMsg = "아이디 또는 패스워드가 일치하지 않습니다.";
		try {
			if (exception instanceof BadCredentialsException) {
		
				int cnt = memberService.checkFailureCount(login_id);
				if(cnt <= 4) {
					memberService.updateFailureCount(login_id);
				}
				
				if(cnt >= 4) {
					MemberDto member = memberService.findById(login_id);
					
					Map<String, Object> map = new HashMap<>();
					map.put("enabled", 0);
					map.put("member_id", member.getMember_id());
					memberService.updateMemberEnabled(map);
					
					MemberDto dto = new MemberDto();
					dto.setMember_id(memberService.getMemberId(login_id));
					dto.setRegister_id(member.getMember_id());
					dto.setStatus_code(1);
					dto.setMemo("패스워드 5회 이상 실패");
					memberService.insertMemberStatus(dto);
				}

				errorMsg = "아이디 또는 패스워드가 일치하지 않습니다.";
			} else if (exception instanceof InternalAuthenticationServiceException) {
				
				errorMsg = "아이디 또는 패스워드가 일치하지 않습니다.";
			} else if (exception instanceof DisabledException) {
				
				errorMsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
			}
		} catch (Exception e) {
			log.info("LoginFailureHandler : " + errorMsg, e);
		}
		
		response.sendRedirect(defaultFailureUrl);
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}
}
