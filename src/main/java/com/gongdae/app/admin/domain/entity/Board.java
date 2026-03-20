package com.gongdae.app.admin.domain.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "board")
public class Board {
	
	@Id
    @Column(name = "board_no")
    @SequenceGenerator(name="S_BOARD_SEQ", sequenceName = "SEQ_BOARD", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "S_BOARD_SEQ")
    private long boardNo;

    @Column(name = "member_id", nullable = false, updatable = false)
    private Long memberId;

    @Column(name = "type", nullable = false, length = 20)
    private String type;

    @Column(name = "title", nullable = false, length = 200)
    private String title;

    @Column(name = "content", columnDefinition = "CLOB", nullable = false)
    private String content;

    @Column(name = "view_count", insertable = false, nullable = false)
    private int viewCount;

    @Column(name = "block", nullable = false)
    private int block; 

    @Column(name = "savefilename", length = 500)
    private String saveFilename;

    @Column(name = "originalfilename", length = 500)
    private String originalFilename;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "start_date")
    private LocalDate startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "created_at", updatable = false, insertable = false, columnDefinition = "DATE DEFAULT SYSDATE")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Transient
    private MultipartFile selectFile;

    @Transient
    private String adminName;

    @Transient
    private String adminLoginId; 

    @PrePersist
    public void prePersist() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }
}