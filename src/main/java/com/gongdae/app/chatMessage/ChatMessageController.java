package com.gongdae.app.chatMessage;

import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdae.app.chat.domain.dto.ChatMessageDto;
import com.gongdae.app.chat.domain.entity.ChatMessage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatMessageController {
    
    private final ChatMessageService chatService; 
    private final SimpMessagingTemplate messagingTemplate;
    
    @ResponseBody
    @GetMapping("/admin/chat/list")
    public List<ChatMessageDto> getRoomList() {
        return chatService.getAdminRoomList();
    }
    
    @ResponseBody
    @GetMapping("/chat/history/{roomId}")
    public List<ChatMessage> getChatHistory(@PathVariable("roomId") String roomId) {
        return chatService.getRecentMessages(roomId);
    }
    
    @MessageMapping("/chat/send")
    public void sendMessage(@Payload ChatMessage dto) {
        ChatMessage saved = chatService.saveMessage(dto);
        messagingTemplate.convertAndSend("/topic/room/" + saved.getRoomId(), saved);
    }

    @MessageMapping("/chat/read")
    public void readMessage(@Payload Map<String, String> data) {
        try {
            String roomId = data.get("roomId");
            String readerId = data.get("readerId"); 

            chatService.markMessagesAsRead(roomId, readerId);
            messagingTemplate.convertAndSend("/topic/room/" + roomId + "/read", readerId);
            
        } catch (Exception e) {
            log.error("채팅 읽음 처리 에러: ", e);
        }
    }
    
}