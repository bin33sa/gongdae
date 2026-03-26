package com.gongdae.app.chat.domain.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "CHAT_ROOM")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessage {

    @Id
    @Column(name = "chat_no")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "chat_seq_gen")
    @SequenceGenerator(name = "chat_seq_gen", sequenceName = "SEQ_CHAT_ROOM", allocationSize = 1)
    private Long chatNo;

    @Column(name = "room_id", nullable = false, length = 100)
    private String roomId;

    @Column(name = "member_id", nullable = false)
    private Long memberId; 

    @Column(name = "is_guest", nullable = false, length = 1)
    private String isGuest; 

    @Column(length = 100)
    private String nickname;

    @Column(length = 100)
    private String sender;

    @Column(length = 1000)
    private String message;

    @Column(name = "read_flag", nullable = false)
    private Integer readFlag;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
}