package com.gongdae.app.controller;

import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.gongdae.app.service.GuestSpaceService;

@Slf4j
@Controller
@RequestMapping("/space")
@RequiredArgsConstructor
public class GuestSpaceController {

    private final GuestSpaceService service;

    // URL 예시: /space/detail/6
    @GetMapping("/detail/{spaceNo}")
    public String spaceDetail(@PathVariable("spaceNo") long spaceNo, Model model) {
        log.info("조회 요청된 공간 번호: {}", spaceNo);
        
        try {
            // 1. 서비스에게 "데이터 바구니 가져와!" 명령
            Map<String, Object> spaceData = service.getSpaceDetailAll(spaceNo);
            
            // 2. 바구니에 담긴 데이터들을 Model에 통째로 쏟아붓기 (초간단!)
            model.addAllAttributes(spaceData);
            
        } catch (Exception e) {
            log.error("공간 상세 조회 에러: ", e);
            return "redirect:/"; // 에러 시 메인 화면으로 이동
        }
        
        // 3. 뷰(JSP) 렌더링
        return "guest/space/spaceDetail"; 
    }
}