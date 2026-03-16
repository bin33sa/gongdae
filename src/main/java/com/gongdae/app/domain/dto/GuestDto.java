package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GuestDto {
	// member
	private Long member_id;
	private String login_id;
	private String password;
	private int enabled;
	private String created_at;
	private String update_at;

	// guest detail
	private String name;
	private String nickname;
	private String birth;
	private String email;
	private int receive_email;
	private String phone;
	private String profile_image;
	private String gender;
	private String point; // 포인트
	private String grade; // 회원 등급
}
