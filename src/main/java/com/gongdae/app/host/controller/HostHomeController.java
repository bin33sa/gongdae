package com.gongdae.app.host.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceInquiryDTO;
import com.gongdae.app.domain.dto.SpaceManageDTO;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.SpaceInquiryService;
import com.gongdae.app.service.SpaceManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/host/*")
public class HostHomeController {
	
    
    private final SpaceManageService spaceService;
    private final SpaceInquiryService inquiryService;
	
    @GetMapping("main/prelogin")
    public String prelogin() {
        return "host/main/prelogin";
    }

   
    @GetMapping("menu/store")
    public String store(Model model) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        List<SpaceManageDTO> list = spaceService.listSpace(info.getMember_id());

        model.addAttribute("list", list);
        model.addAttribute("active", "store");
        return "host/menu/store";
    }

    
    @GetMapping("menu/qna")
    public String qna(@RequestParam(name = "inquiryNo", required = false, defaultValue = "0") long inquiryNo, Model model) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        long hostId = info.getMember_id();

        // 좌측 문의 리스트 가져오기
        List<SpaceInquiryDTO> list = inquiryService.listInquiryByHost(hostId);
        SpaceInquiryDTO detail = null;

        // 우측 상세 채팅창 데이터 가져오기
        if (inquiryNo != 0) {
            detail = inquiryService.findInquiryById(inquiryNo);
        } else if (!list.isEmpty()) {
            detail = inquiryService.findInquiryById(list.get(0).getInquiryNo());
        }

        model.addAttribute("list", list);
        model.addAttribute("detail", detail);
        model.addAttribute("active", "qna");
        return "host/menu/qna";
    }

    // 💡 1:1 문의 답변 등록 (POST)
    @PostMapping("inquiry/reply")
    public String replySubmit(SpaceInquiryDTO dto) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        try {
            SpaceInquiryDTO verify = inquiryService.findInquiryById(dto.getInquiryNo());
            // 내 공간에 달린 문의가 맞는지 권한 검증
            if(verify != null && verify.getHostId() == info.getMember_id()) {
                dto.setHostId(info.getMember_id());
                inquiryService.updateInquiryReply(dto);
            }
        } catch (Exception e) {
            log.error("답변 등록 에러", e);
        }
        return "redirect:/host/menu/qna?inquiryNo=" + dto.getInquiryNo();
    }


   
    @GetMapping("menu/space")
    public String space(Model model) {
        model.addAttribute("active", "space");
        return "host/menu/space";
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
}