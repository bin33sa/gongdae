package com.gongdae.app.controller;

import java.io.File;
import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.gongdae.app.common.MyUtil;
import com.gongdae.app.common.PaginateUtil;
import com.gongdae.app.common.RequestUtils;
import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.BoardDto;
import com.gongdae.app.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {
	private final BoardService service;
	private final StorageService storageService;
	private final PaginateUtil paginateUtil;
	private final MyUtil myUtil;

	@Value("${file.upload-root}/")
	private String uploadPath;

	@GetMapping("/notice")
	public String noticeList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model) throws Exception {
		
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = myUtil.decodeUrl(kwd);
			
			// 전체 페이지 수
			Map<String, Object> map = new HashMap<>();
			map.put("kwd", kwd);
			
			dataCount = service.noticeCount(map);
			if(dataCount != 0) {
				total_page = dataCount / size + (dataCount % size > 0 ? 1 : 0);
			}
			
			// 현재 존재하는 페이지 이상의 페이지에 접근할때
			current_page = Math.min(current_page, total_page);
			
			// 공지사항 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0; // 현재 페이지가 1 미만일 경우
			
			map.put("offset", offset);
			map.put("size", size);
			
			// 공지사항 리스트
			List<BoardDto> list = service.noticeList(map);
			
			String cp = RequestUtils.getContextPath();
			String listUrl = cp + "/notice";
			if(! kwd.isBlank()) listUrl += "?kwd=" + myUtil.encodeUrl(kwd);
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("page", current_page);
			model.addAttribute("kwd", kwd);
			
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("noticeList: ", e);
		}
		
		return "common/board/notice";
	}
	
	@GetMapping("/notice/{num}")
	public String noticeDetail(@PathVariable(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model) throws Exception {
		
		String query = "page=" + page;
		
		try {
			kwd = myUtil.decodeUrl(kwd);
			if(! kwd.isBlank()) query += "&kwd=" + myUtil.encodeUrl(kwd);
			
			service.updateHitCount(num);
			
			// 공지사항 가져오기
			BoardDto dto = Objects.requireNonNull(service.findById(num));
			
			// XSS 방지를 위한 sanitize method
			dto.setContent(myUtil.sanitize(dto.getContent()));
			
			model.addAttribute("dto", dto);
			model.addAttribute("query", query);
			
			return "common/board/noticeDetail";
			
		} catch (Exception e) {
			log.info("notice: ", e);
		}
		
		return "redirect:/notice?" + query;
	}
	
	@GetMapping("notice/download/{num}")
	public ResponseEntity<?> noticeDownload( @PathVariable("num") long num) throws Exception {
		try {
			String noticeUploadPath = uploadPath + File.separator + "admin" + File.separator + "notice";
			BoardDto dto = Objects.requireNonNull(service.findById(num));
			return storageService.downloadFile(noticeUploadPath, dto.getSaveFilename(), dto.getOriginalFilename());
		} catch (Exception e) {
			log.info("download: ", e);
		}
		
		String redirectUrl = RequestUtils.getContextPath() + "/error/downloadFailed";
		return ResponseEntity
				.status(HttpStatus.FOUND)
				.location(URI.create(redirectUrl))
				.build();
	}
	
	
	@GetMapping("/event")
	public String eventList(@RequestParam(name = "page", defaultValue = "1") int current_page,
			Model model) throws Exception {
	
		try {
			int size = 8;
			int total_page = 0;
			int dataCount = 0;
			
			
			// 전체 페이지 수
			dataCount = service.eventCount();
			if(dataCount != 0) {
				total_page = dataCount / size + (dataCount % size > 0 ? 1 : 0);
			}
			
			// 현재 존재하는 페이지 이상의 페이지에 접근할때
			current_page = Math.min(current_page, total_page);
			
			// 이벤트 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0; // 현재 페이지가 1 미만일 경우
			
			Map<String, Object> map = new HashMap<>();
			map.put("offset", offset);
			map.put("size", size);
			
			// 이벤트 리스트
			List<BoardDto> list = service.eventList(map);
			
			String cp = RequestUtils.getContextPath();
			String listUrl = cp + "/event";
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("page", current_page);
			
			model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			log.info("noticeList: ", e);
		}
		
		return "common/board/event";
	}
	
	@GetMapping("/event/{num}")
	public String eventDetail(@PathVariable(name = "num") long num,
			@RequestParam(name = "page", defaultValue = "1") String page,
			Model model) throws Exception {
		
		String query = "page=" + page;
		
		try {
			service.updateHitCount(num);
			
			// 이벤트 가져오기
			BoardDto dto = Objects.requireNonNull(service.findById(num));
			
			// XSS 방지를 위한 sanitize method
			dto.setContent(myUtil.sanitize(dto.getContent()));
			
			model.addAttribute("dto", dto);
			model.addAttribute("query", query);
			
			return "common/board/eventDetail";
			
		} catch (NullPointerException e) {
			log.info("notice: ", e);
		} catch (Exception e) {
			log.info("notice: ", e);
		}
		
		return "redirect:/event?" + query;
	}
	
	@GetMapping("/faq")
	public String faq(Model model) throws Exception {
		
		try {
			// FAQ 가져오기
			List<BoardDto> list = service.faqList();
			
			model.addAttribute("list", list);
			
		} catch (Exception e) {
			log.info("faqList: ", e);
		}
		
		return "common/board/faq";
	}
	
	
	
	
}
