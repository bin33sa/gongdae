package com.gongdae.app.admin.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GuestManageDto {
	private long member_id;
	private String login_id;
	private String password;
	private int userLevel;
	private int enabled;
	private String last_login;
	private int failure_cnt;
	private String created_at;
	private String update_at;
	private String name;
	private String nickname;
	private String birth;
	private String email;
	private String phone;
	private int age;
	private long point;
	private String grade; 
    private String profile_photo;
    
    private long num;
    private int status_code;
    private String memo;
    private long register_id;
	private String login_register;
	private String registerName;
	private String reg_date;
}
