package com.gongdae.app.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        model.addAttribute("categoryList", service.listCategory());
        model.addAttribute("optionList", service.listOption());
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
            model.addAttribute("categoryList", service.listCategory());
            model.addAttribute("optionList", service.listOption());
            return "host/menu/space"; 
        }
        return "redirect:/host/main/home"; 
    }
    
    @GetMapping("update")
    public String updateForm(@RequestParam(name = "spaceNo") long spaceNo, Model model) throws Exception {
        SpaceManageDTO dto = service.findById(spaceNo);
        if(dto == null) return "redirect:/host/dashboard"; 

        model.addAttribute("dto", dto);
        model.addAttribute("listFile", service.listSpaceImage(spaceNo));
        model.addAttribute("selectedOptions", service.listSpaceOption(spaceNo));
        model.addAttribute("listUnit", service.listSpaceUnit(spaceNo));
        
        model.addAttribute("categoryList", service.listCategory());
        model.addAttribute("optionList", service.listOption());
        model.addAttribute("mode", "update");

        return "host/menu/space";
    }

    @PostMapping("update")
    public String updateSubmit(SpaceManageDTO dto) throws Exception {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            dto.setHostId(info.getMember_id()); 
            service.updateSpace(dto, uploadPath);
        } catch (Exception e) {
            log.info("공간 수정 실패 : ", e);
            return "redirect:/host/space/update?spaceNo=" + dto.getSpaceNo(); 
        }
        return "redirect:/host/main/home"; 
    }

    // 💡 논리적 삭제
    @PostMapping("delete")
    public String deleteSpace(@RequestParam(name = "spaceNo") long spaceNo) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            service.deleteSpace(spaceNo, info.getMember_id());
        } catch (Exception e) {
            log.error("공간 삭제 실패", e);
            return "redirect:/host/space/update?spaceNo=" + spaceNo;
        }
        return "redirect:/host/main/home";
    }
}
