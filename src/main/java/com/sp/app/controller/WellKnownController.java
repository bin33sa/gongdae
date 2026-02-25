package com.sp.app.controller;

import java.net.URI;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class WellKnownController {
	@GetMapping("/.well-known/appspecific/com.chrome.devtools.json")
	public ResponseEntity<?> handle(HttpServletRequest req) {
		String redirectUrl = req.getContextPath() + "/";
		return ResponseEntity
				.status(HttpStatus.FOUND)  
				.location(URI.create(redirectUrl))  
				.build();
	}
}