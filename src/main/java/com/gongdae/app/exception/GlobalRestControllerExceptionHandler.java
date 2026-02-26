package com.gongdae.app.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice
public class GlobalRestControllerExceptionHandler {

	@ExceptionHandler(MissingServletRequestParameterException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ResponseEntity<String> handleMissingParams(MissingServletRequestParameterException ex) {	
		log.info("BAD_REQUEST - ", ex);
		return new ResponseEntity<>("잘못된 요청: " + ex.getMessage(), HttpStatus.BAD_REQUEST);
	}

	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ResponseEntity<String> handleArgumentTypeMismatch(MethodArgumentTypeMismatchException ex) {	
		log.info("BAD_REQUEST - ", ex);
		return new ResponseEntity<>("잘못된 요청: " + ex.getMessage(), HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(NoResourceFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND) 
	public ResponseEntity<String> handleResourceNotFound(NoResourceFoundException ex) {
		log.info("NOT_FOUND - ", ex);
		
		return new ResponseEntity<>("리소스를 찾을 수 없습니다: " + ex.getMessage(), HttpStatus.NOT_FOUND);
	}

	@ExceptionHandler(Exception.class)
	public ResponseEntity<String> handleServerError(Exception ex) {
		log.info("INTERNAL_SERVER_ERROR 등 - ", ex);
		
		return new ResponseEntity<>("서버 오류: " + ex.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
