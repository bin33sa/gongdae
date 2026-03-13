package com.gongdae.app.security;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		
		String uri  = request.getRequestURI();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String redirectPath = "/member/login";
		
		System.out.println(uri);
		
		if(uri.startsWith("/admin")) {
			if(auth != null) new SecurityContextLogoutHandler().logout(request, response, auth);
			redirectPath = "/noAuthorized";
		} else if (uri.startsWith("/host")) {
			if(auth != null) new SecurityContextLogoutHandler().logout(request, response, auth);
			redirectPath = "/host/member/login";
		} else {
			if(auth != null) new SecurityContextLogoutHandler().logout(request, response, auth);
			redirectPath = "/member/login";
		}
		
		response.sendRedirect(redirectPath);
		
		
	}

}
