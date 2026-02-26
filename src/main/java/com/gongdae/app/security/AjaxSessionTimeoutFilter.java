package com.gongdae.app.security;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AjaxSessionTimeoutFilter implements Filter {
	private String ajaxHeader;
	
	@Override
	public void init(FilterConfig config) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        if (isAjaxRequest(req)) {
            try {
                chain.doFilter(req, resp);
            } catch (AccessDeniedException e) {       	
                resp.sendError(HttpServletResponse.SC_FORBIDDEN); 
            } catch (AuthenticationException e) {
            	resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            } 
        } else {
            chain.doFilter(req, resp);
        }
	}
	
	@Override
	public void destroy() {
	}
	
	public void setAjaxHeader(String ajaxHeader) {
        this.ajaxHeader = ajaxHeader;
    }
	
	private boolean isAjaxRequest(HttpServletRequest req) {
        return req.getHeader(ajaxHeader) != null
                && req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
    }
}
