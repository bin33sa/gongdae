package com.gongdae.app.chatMessage;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gongdae.app.chat.domain.dto.ChatMessageDto;
import com.gongdae.app.chat.domain.entity.ChatMessage;
import com.gongdae.app.chat.repository.ChatMessageRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatMessageService {
    
    private final ChatMessageRepository chatRepository;
    private final UserSessionRegistry sessionRegistry;
    private final SimpMessagingTemplate messagingTemplate;

    public String createNewRoomId() {
        return "ROOM_" + UUID.randomUUID().toString().replace("-", "");
    }

    public ChatMessage findByMemberId(Long memberId) {
        return chatRepository.findFirstByMemberIdOrderByCreatedAtDesc(memberId).orElse(null);
    }

    public String createNewRoomId(Long memberId) {
        return "ROOM_" + memberId;
    }
    
    @Transactional
    public ChatMessage saveMessage(ChatMessage message) {
        boolean isNewRoom = !chatRepository.existsByRoomId(message.getRoomId());

        message.setCreatedAt(LocalDateTime.now());
        message.setReadFlag(0);

        ChatMessage saved = chatRepository.save(message);

        if (isNewRoom) {
            ChatMessageDto roomDto = new ChatMessageDto(
                    saved.getRoomId(),
                    BigDecimal.valueOf(saved.getMemberId()),
                    saved.getNickname(),
                    BigDecimal.ONE, 
                    BigDecimal.ZERO, 
                    Timestamp.valueOf(saved.getCreatedAt())
            );    
            
            messagingTemplate.convertAndSend("/topic/admin/new-room", roomDto);
        }

        return saved;
    }

    @Transactional(readOnly = true)
    public List<ChatMessage> getRecentMessages(String roomId) {
        LocalDateTime since = LocalDateTime.now().minusDays(5);
        return chatRepository.findRecentMessages(roomId, since);
    }

    @Transactional
    public void markMessagesAsRead(String roomId, String readerId) {
        chatRepository.markAsRead(roomId, readerId);
    }

    @Transactional(readOnly = true)
    public List<ChatMessageDto> getAdminRoomList() {
        List<ChatMessageDto> rooms = chatRepository.findRoomListWithStatus();
        for (ChatMessageDto room : rooms) {
            room.setOnline(sessionRegistry.isOnline(room.getMemberId()));
        }
        return rooms;
    }
    
    public String findNicknameByMemberId(Long memberId) {
        return chatRepository.findNicknameByMemberId(memberId);
    }
}