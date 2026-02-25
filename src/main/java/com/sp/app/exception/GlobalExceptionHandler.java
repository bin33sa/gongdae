package com.sp.app.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(MissingServletRequestParameterException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ModelAndView handleMissingParams(MissingServletRequestParameterException ex) {
		
		
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "잘못된 요청입니다.";
		String errorMessage = "죄송합니다.<br> <strong>400 - 요청을 처리할 수 없습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);
		
		log.info("BAD_REQUEST - ", ex);
		
		return mav;
	}

	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST) 
	public ModelAndView handleArgumentTypeMismatch(MethodArgumentTypeMismatchException ex) {

		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "잘못된 요청입니다.";
		String errorMessage = "죄송합니다.<br> <strong>400 - 요청을 처리할 수 없습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);

		log.info("BAD_REQUEST - ", ex);
		
		return mav;
	}
	
	@ExceptionHandler(NoResourceFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public ModelAndView handleResourceNotFound(NoResourceFoundException ex) {
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "페이지를 찾을 수 없습니다.";
		String errorMessage = "죄송합니다.<br> <strong>404 - 요청하신 페이지가 존재하지 않습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);

		log.info("NOT_FOUND - ", ex);
		
		return mav;
	}

	@ExceptionHandler(MaxUploadSizeExceededException.class)
	public ModelAndView handleMaxUploadSizeExceededException(MaxUploadSizeExceededException ex) {
		
		return new ModelAndView("error/uploadFailure");
	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView handleServerError(Exception ex) {
		ModelAndView mav = new ModelAndView("error/error2");
		
		String title = "시스템 오류.";
		String errorMessage = "죄송합니다.<br> <strong>요청을 처리할 수 없습니다.</strong>";
		
		mav.addObject("title", title);
		mav.addObject("message", errorMessage);

		log.info("INTERNAL_SERVER_ERROR 등 - ", ex);
		
		return mav;
	}
}
