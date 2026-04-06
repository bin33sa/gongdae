package com.gongdae.app.domain.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class HostDto {
	// [Member 테이블 공통 정보]
	private Long member_id;
	private String login_id;
	private String password;
	private int enabled;
	private String created_at;
	private String update_at;

	// [Host Detail 테이블 정보]
	private String name;
	private String nickname;      // 호스트명
	private String email;
	private String tel;           // 전화번호 (DB 컬럼명은 phone)
	private String profile_photo; // 프로필 이미지 URL
	private String gender;
	private String content;       // 호스트 소개글 (새로 추가됨)
	
	// [파일 업로드 처리용]
	// 클라이언트 폼에서 <input type="file" name="selectFile"> 로 넘어오는 데이터를 받습니다.
	private MultipartFile selectFile;
	
	// [권한 정보]
	private String authority;
}