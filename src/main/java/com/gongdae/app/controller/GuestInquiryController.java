package com.gongdae.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceInquiryDTO;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.SpaceInquiryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/guest/inquiry/*")
public class GuestInquiryController {
    
    private final SpaceInquiryService inquiryService;

   
    @GetMapping("testForm")
    public String testForm(Model model) {
        // 테스트 화면 JSP로 이동
        return "guest/test_inquiry"; 
    }

    
    @PostMapping("write")
    public String writeInquiry(SpaceInquiryDTO dto, RedirectAttributes rttr) {
        try {
           
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            dto.setMemberId(info.getMember_id()); 
            
           
            inquiryService.insertInquiry(dto);
            
           
            rttr.addFlashAttribute("message", "문의가 성공적으로 등록되었습니다! 호스트 센터에서 확인해보세요.");
        } catch (Exception e) {
            log.error("문의 등록 에러", e);
            rttr.addFlashAttribute("message", "문의 등록 중 오류가 발생했습니다.");
        }
        
        
        return "redirect:/guest/inquiry/testForm"; 
    }
}