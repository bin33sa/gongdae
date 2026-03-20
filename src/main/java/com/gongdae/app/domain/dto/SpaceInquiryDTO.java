package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SpaceInquiryDTO {
    // 💡 INQUIRY_SPACE 테이블 컬럼
    private long inquiryNo;
    private long memberId;       // 게스트 ID
    private long spaceNo;
    private String title;        // 문의 제목
    private String content;      // 문의 내용
    private String createdAt;    // 등록일
    private String isAnswered;   // 답변 여부 (Y / N)
    private long hostId;         // 답변 작성 호스트 ID
    private String answer;       // 답변 내용
    private String answeredAt;   // 답변일
    
    // 💡 JOIN 추가 데이터 (화면 출력용)
    private String spaceName;
    private String guestName;
}