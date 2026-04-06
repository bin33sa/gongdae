package com.gongdae.app.host.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.domain.dto.HostDto;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.host.service.HostService; // 본인의 JPA 서비스로 주입

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/host/*")
public class HostMemberController {
	
   
    private final HostService hostService;
	
	@RequestMapping(value = "member/login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "error", required = false) String error, Model model) {
		if(error != null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		return "host/member/login";
	}
	
	//@GetMapping("member/signup")
	public String signupForm(Model model) throws Exception {
        model.addAttribute("mode", "signup");
		return "host/member/signup";
	}
	
	@PostMapping("member/signup")
	public String signupSubmit(HostDto dto, RedirectAttributes rAttr) throws Exception {
        
        rAttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
		return "redirect:/host/member/login";
	}

  
	@GetMapping("member/edit")
	public String editForm(Model model) throws Exception {
     
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        
        if (info == null) {
            return "redirect:/host/member/login";
        }

       
        HostDto dto = hostService.findById(info.getMember_id());
        
        
        model.addAttribute("dto", dto);
        model.addAttribute("mode", "update");

		return "host/member/edit";
	}

   
	@PostMapping("member/update")
	public String editSubmit(HostDto dto, RedirectAttributes rAttr) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        dto.setMember_id(info.getMember_id());
        
       
      
        
        rAttr.addFlashAttribute("message", "정보가 성공적으로 수정되었습니다.");
		return "redirect:/host/main/home";
	}
	
	@GetMapping("member/findId")
	public String findIdForm() throws Exception {
		return "host/member/findId";
	}
	
	@GetMapping("member/findPwd")
	public String findPwdForm() throws Exception {
		return "host/member/findPwd";
	}
}