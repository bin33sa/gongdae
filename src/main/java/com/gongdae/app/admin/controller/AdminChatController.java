package com.gongdae.app.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdae.app.chat.domain.dto.ChatMessageDto;
import com.gongdae.app.chat.domain.entity.ChatMessage;
import com.gongdae.app.chatMessage.ChatMessageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/chat/*")
@Slf4j
public class AdminChatController {
    private final ChatMessageService chatService;

    @GetMapping("room")
    public String handleChat(Model model) {
        
        List<ChatMessageDto> rooms = chatService.getAdminRoomList();
        model.addAttribute("rooms", rooms);
        
        return "admin/chat/room"; 
    }
    
    @ResponseBody
    @GetMapping("checkRoom")
    public Map<String, Object> checkRoom(@RequestParam("memberId") Long memberId) {
        Map<String, Object> map = new java.util.HashMap<>();
        
        String nickname = chatService.findNicknameByMemberId(memberId);
        if (nickname == null) {
            map.put("error", "존재하지 않는 회원번호입니다.");
            return map;
        }
        
        map.put("nickname", nickname); 
        
        ChatMessage existingRoom = chatService.findByMemberId(memberId);
        if (existingRoom != null) {
            map.put("exists", true);
            map.put("roomId", existingRoom.getRoomId());
        } else {
            map.put("exists", false);
            map.put("roomId", chatService.createNewRoomId(memberId));
        }
        
        return map;
    }
}