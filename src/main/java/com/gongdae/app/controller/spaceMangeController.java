package com.gongdae.app.controller;

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

    // application.properties (또는 yml)에 설정된 파일 업로드 기본 경로를 가져옵니다.
    @Value("${file.upload-root}/space") 
    private String uploadPath;

    @GetMapping("write")
    public String writeForm(Model model) {
        try {
            // TODO: 공간 카테고리 리스트나 호스트 정보를 DB에서 불러와서 Model에 담아 JSP로 넘겨줍니다.
            // List<SpaceCategory> listCategory = service.listCategory();
            // model.addAttribute("listCategory", listCategory);

            model.addAttribute("mode", "write");
        } catch (Exception e) {
            log.info("writeForm : ", e);
        }

        // 변경된 JSP 경로 반영 (View Resolver가 앞뒤로 /WEB-INF/views/ 와 .jsp를 붙여줍니다)
        //return "host/space/spaceForm"; 
        return "host/space/spaceForm"; 
    }

    @PostMapping("write")
    public String writeSubmit(SpaceManageDTO dto, Model model) {
    	try {
           
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            
            
            dto.setHostId(info.getMember_id()); 
            
            
           

           
            service.insertSpace(dto, uploadPath);

        } catch (Exception e) {
            log.info("writeSubmit : ", e);
            return "host/space/spaceForm"; 
        }

        return "redirect:/space/manage/main"; 
    }
    @GetMapping("qna")
    public String qnaForm(Model model) {
    	
    	return "host/qna/qna"; 
    }
}
