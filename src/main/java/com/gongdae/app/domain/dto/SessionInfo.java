package com.gongdae.app.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SessionInfo {
	private long member_id;
	private String login_id;
	private String password;
	private String name;
	private String email;
	private int userLevel;
	private String login_type; 
	private String avatar; 
}
