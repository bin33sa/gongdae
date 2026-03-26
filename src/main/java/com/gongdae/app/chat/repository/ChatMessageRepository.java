package com.gongdae.app.chat.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.gongdae.app.chat.domain.dto.ChatMessageDto;
import com.gongdae.app.chat.domain.entity.ChatMessage;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    
    Optional<ChatMessage> findFirstByMemberIdOrderByCreatedAtDesc(Long memberId);
    Optional<ChatMessage> findFirstByRoomIdOrderByCreatedAtDesc(String roomId);
    boolean existsByRoomId(String roomId);
    
    @Query(value = """
                SELECT *
                FROM CHAT_ROOM
                WHERE ROOM_ID = :roomId AND CREATED_AT >= :since
                ORDER BY CREATED_AT ASC
            """, nativeQuery = true)
    List<ChatMessage> findRecentMessages(@Param("roomId") String roomId, @Param("since") LocalDateTime since);

    @Query(value = """
                SELECT c.ROOM_ID roomId, c.MEMBER_ID memberId, 
                    COALESCE(g.nickname, h.nickname, MAX(CASE WHEN c.IS_GUEST = 'Y' THEN c.NICKNAME END)) as nickname,
                    COUNT(CASE WHEN c.IS_GUEST = 'Y' AND c.READ_FLAG = 0 THEN 1 END) as adminUnreadCount,
                    COUNT(CASE WHEN c.IS_GUEST = 'N' AND c.READ_FLAG = 0 THEN 1 END) as clientUnreadCount,
                    MAX(c.CREATED_AT) as lastTime
                FROM CHAT_ROOM c
                LEFT JOIN GUEST_DETAIL g ON c.MEMBER_ID = g.member_id
                LEFT JOIN HOST_DETAIL h ON c.MEMBER_ID = h.member_id
                GROUP BY c.ROOM_ID, c.MEMBER_ID, g.nickname, h.nickname
                ORDER BY adminUnreadCount DESC, lastTime DESC
            """, nativeQuery = true)
    List<ChatMessageDto> findRoomListWithStatus();

    @Modifying
    @Transactional
    @Query("UPDATE ChatMessage m SET m.readFlag = 1 WHERE m.roomId = :roomId AND m.sender != :readerId")
    void markAsRead(@Param("roomId") String roomId, @Param("readerId") String readerId);

    @Query(value = """
                SELECT COALESCE(g.nickname, h.nickname, m.login_id) 
                FROM MEMBER m 
                LEFT JOIN GUEST_DETAIL g ON m.member_id = g.member_id 
                LEFT JOIN HOST_DETAIL h ON m.member_id = h.member_id 
                WHERE m.member_id = :memberId
            """, nativeQuery = true)
    String findNicknameByMemberId(@Param("memberId") Long memberId);
}