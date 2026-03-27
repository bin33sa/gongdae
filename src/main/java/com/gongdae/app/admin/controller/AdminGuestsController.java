package com.gongdae.app.admin.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gongdae.app.admin.domain.dto.GuestManageDto;
import com.gongdae.app.admin.service.GuestManageService;
import com.gongdae.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/guests/*")
@Slf4j
public class AdminGuestsController {
	private final GuestManageService service;
	private final PaginateUtil paginateUtil;

	@GetMapping("list")
	public String listGuest(
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "login_id") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			HttpServletRequest req,
			Model model) throws Exception {

		int size = 10;
		int total_page = 0;
		int dataCount = 0;

		Map<String, Object> map = new HashMap<>();
		map.put("schType", schType);
		map.put("kwd", kwd);

		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = paginateUtil.pageCount(dataCount, size);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * size;
		if(offset < 0) offset = 0;

		map.put("offset", offset);
		map.put("size", size);

		List<GuestManageDto> list = service.listGuest(map);

		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/admin/guests/list";

		if (!kwd.isBlank()) {
			query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
		}

		if (!query.isBlank()) {
			listUrl = listUrl + "?" + query;
		}

		String paging = paginateUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("size", size);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("schType", schType);
		model.addAttribute("kwd", kwd);

		return "admin/guests/list";
	}

	@GetMapping("profile")
	public String detaileMember(@RequestParam(name = "member_id") Long member_id, 
			@RequestParam(name = "page") String page,
			HttpServletResponse resp,
			Model model) throws Exception {
		
		try {
			service.updateAutoGrade(member_id);
			
			GuestManageDto dto = Objects.requireNonNull(service.findById(member_id));
			GuestManageDto memberStatus = service.findByStatus(member_id);
			List<GuestManageDto> listStatus = service.listGuestStatus(member_id);

			model.addAttribute("dto", dto);
			model.addAttribute("memberStatus", memberStatus);
			model.addAttribute("listStatus", listStatus);
			model.addAttribute("page", page);
			
		} catch (NullPointerException e) {
			resp.sendError(410);
			throw e;
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}

		return "admin/guests/profile";
	}

	@PutMapping("updateGuest")
	public ResponseEntity<?> updateMember(@RequestParam Map<String, Object> paramMap) throws Exception {
		try {
			service.updateGuest(paramMap);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		}
	}

	@PostMapping("GuestStatus")
	public ResponseEntity<?> updateMemberStatus(GuestManageDto dto) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("member_id", dto.getMember_id());
			if (dto.getStatus_code() == 0) {
				map.put("enabled", 1);
			} else {
				map.put("enabled", 0);
			}
			service.updateGuestEnabled(map);
			service.insertGuestStatus(dto);

			if (dto.getStatus_code() == 0) {
				service.updateFailureCountReset(dto.getMember_id());
			}

			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		}
	}

	@PostMapping("updatePoint")
	public ResponseEntity<?> updatePoint(
			@RequestParam(value="memberIds[]") List<Long> memberIds, 
			@RequestParam("point") int point) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberIds", memberIds);
			map.put("point", point);
			
			service.updatePoint(map);
			
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("포인트 지급에 실패했습니다.");
		}
	}
}