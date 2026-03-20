package com.gongdae.app.host.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceManageDTO;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.SpaceManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/host/*")
public class HostHomeController {
	
		private final SpaceManageService spaceService;
		
		@GetMapping("main/prelogin")
		public String prelogin() {
			return "host/main/prelogin";
		}

		@GetMapping("menu/store")
		public String store(Model model) throws Exception {
			// 현재 로그인한 호스트의 ID 가져오기
			SessionInfo info = LoginMemberUtil.getSessionInfo();
			
			// 매장 목록 DB에서 조회
			List<SpaceManageDTO> list = spaceService.listSpace(info.getMember_id());
			
			// 화면으로 전달
			model.addAttribute("list", list);
		    model.addAttribute("active", "store");
		    return "host/menu/store";
		}

	@GetMapping("menu/space")
	public String space(Model model) {
	    model.addAttribute("active", "space");
	    return "host/menu/space";
	}

	@GetMapping("menu/qna")
	public String qna(Model model) {
	    model.addAttribute("active", "qna");
	    return "host/menu/qna";
	}

	@GetMapping("menu/reservation")
	public String reservation(Model model) {
	    model.addAttribute("active", "reservation");
	    return "host/menu/reservation";
	}

	@GetMapping("menu/sales")
	public String sales(Model model) {
	    model.addAttribute("active", "sales");
	    return "host/menu/sales";
	}

	@GetMapping("main/home")
	public String home(Model model) {
	    model.addAttribute("active", "home");
	    return "host/main/home";
	}
	
}
