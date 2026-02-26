package com.gongdae.app.security;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.gongdae.app.domain.dto.MemberDto;
import com.gongdae.app.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	private String defaultUrl;

	@Autowired
	private MemberService memberService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		try {
			memberService.updateLastLogin(authentication.getName());

			MemberDto dto = memberService.findById(authentication.getName());

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime currentDateTime = LocalDateTime.now();
			LocalDateTime targetDateTime = LocalDateTime.parse(dto.getUpdate_at(), formatter);
			long daysBetween = ChronoUnit.DAYS.between(targetDateTime, currentDateTime);
			if (daysBetween >= 90) {
				String targetUrl = "/member/updatePwd";
				redirectStrategy.sendRedirect(request, response, targetUrl);
				return;
			}
		} catch (Exception e) {
		}

		resultRedirectStrategy(request, response, authentication);
	}

	protected void resultRedirectStrategy(HttpServletRequest request, 
			HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		SavedRequest savedRequest = requestCache.getRequest(request, response);

		if (savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStrategy.sendRedirect(request, response, targetUrl);
		} else {
			redirectStrategy.sendRedirect(request, response, defaultUrl);
		}
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}
}
