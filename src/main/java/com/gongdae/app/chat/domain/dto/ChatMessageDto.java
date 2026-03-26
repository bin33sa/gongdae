package com.gongdae.app.chat.domain.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ChatMessageDto {
    
    private String roomId;
    private Long memberId;           
    private String nickname;
    private Long adminUnreadCount;
    private Long clientUnreadCount;
    private LocalDateTime lastTime;
    
    private boolean isOnline;
    
    public ChatMessageDto(String roomId, 
                       BigDecimal memberId, 
                       String nickname, 
                       BigDecimal adminUnreadCount, 
                       BigDecimal clientUnreadCount, 
                       Timestamp lastTime) {

        this.roomId = roomId;
        this.memberId = memberId == null ? 0L : memberId.longValue();
        this.nickname = nickname;
        this.adminUnreadCount = adminUnreadCount == null ? 0L : adminUnreadCount.longValue();
        this.clientUnreadCount = clientUnreadCount == null ? 0L : clientUnreadCount.longValue();
        this.lastTime = lastTime == null ? null : lastTime.toLocalDateTime();
    }    
}