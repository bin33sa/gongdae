package com.gongdae.app.chatMessage;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gongdae.app.chat.domain.entity.ChatMessage;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/chat")
@RequiredArgsConstructor
@Slf4j
public class ChatRoomController {

    private final ChatMessageService chatService;

    @GetMapping("/myRoom")
    public ResponseEntity<Map<String, String>> getMyRoom() {
        Map<String, String> response = new HashMap<>();
        
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            Long memberId = info.getMember_id();

            // 💡 1. 팀원분이 만든 메서드로 DB에서 진짜 닉네임 먼저 조회!
            String nickname = chatService.findNicknameByMemberId(memberId);
            if (nickname == null || nickname.isEmpty()) {
                nickname = "호스트"; // 만약 닉네임이 없다면 기본값 세팅
            }

            // 2. 방 번호 조회 또는 생성
            ChatMessage lastMessage = chatService.findByMemberId(memberId);
            String roomId;
            if (lastMessage != null && lastMessage.getRoomId() != null) {
                roomId = lastMessage.getRoomId();
            } else {
                roomId = chatService.createNewRoomId();
            }

            // 💡 3. 응답(Map)에 방 번호와 닉네임을 모두 담아서 프론트엔드로 전달
            response.put("roomId", roomId);
            response.put("nickname", nickname); 
            
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            log.error("채팅방 조회/생성 실패", e);
            response.put("error", "채팅방 정보를 가져오지 못했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
}