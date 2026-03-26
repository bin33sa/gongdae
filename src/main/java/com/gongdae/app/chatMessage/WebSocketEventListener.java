package com.gongdae.app.chatMessage;

import java.util.Map;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.gongdae.app.domain.dto.SessionInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class WebSocketEventListener {
	
	private final UserSessionRegistry sessionRegistry;
	private final SimpMessagingTemplate messagingTemplate;

	@EventListener
	public void handleConnect(SessionConnectEvent event) {
		StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());

		Map<String, Object> sessionAttributes = sha.getSessionAttributes();
		if (sessionAttributes != null && sessionAttributes.containsKey("member")) {
			SessionInfo info = (SessionInfo) sessionAttributes.get("member");
			sessionRegistry.add(info.getMember_id());
			messagingTemplate.convertAndSend(
					"/topic/admin/status",
					Map.of("memberId", info.getMember_id(), 
					"status", "ON"));
		}
	}

	@EventListener
	public void handleDisconnect(SessionDisconnectEvent event) {
		StompHeaderAccessor sha = StompHeaderAccessor.wrap(event.getMessage());
		Map<String, Object> sessionAttributes = sha.getSessionAttributes();
		if (sessionAttributes != null && sessionAttributes.containsKey("member")) {
			SessionInfo info = (SessionInfo) sessionAttributes.get("member");
			sessionRegistry.remove(info.getMember_id());
			messagingTemplate.convertAndSend(
					"/topic/admin/status",
					Map.of("memberId", info.getMember_id(), 
					"status", "OFF"));
		}
	}
}
