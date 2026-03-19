package com.gongdae.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
@RequestMapping("/host/space/*")
public class spaceMangeController {
	private final SpaceManageService service;

	@Value("${file.upload-root}/space")
    private String uploadPath;

    @GetMapping("write")
    public String writeForm(Model model) throws Exception {
        // DB에서 카테고리와 옵션 태그 목록을 불러와 JSP로 전달
        List<Map<String, Object>> categoryList = service.listCategory();
        List<Map<String, Object>> optionList = service.listOption();
        
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("optionList", optionList);
        model.addAttribute("mode", "write");
        
        return "host/menu/space";
    }

    @PostMapping("write")
    public String writeSubmit(SpaceManageDTO dto, Model model) throws Exception{
        try {
        	SessionInfo info = LoginMemberUtil.getSessionInfo();
            dto.setHostId(info.getMember_id()); 
            
            service.insertSpace(dto, uploadPath);
            
        } catch (Exception e) {
            log.info("공간 등록 실패 : ", e);
            model.addAttribute("message", "공간 등록 중 오류가 발생했습니다.");
            
            // 등록 실패 시에도 카테고리/옵션을 다시 불러와야 폼이 깨지지 않음
            model.addAttribute("categoryList", service.listCategory());
            model.addAttribute("optionList", service.listOption());
            
            return "host/menu/space"; 
        }
        
        return "redirect:/host/main/home"; 
    }
}
