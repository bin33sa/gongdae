package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class BoardDto {
	private long num;
	private String admin_name;
	private String type;
	private String title;
	private String content;
	private String created_at;
	private String updated_at;
	private String saveFilename;
	private String originalFilename;
	private String start_date;
	private String end_date;
	
}
