package com.gongdae.app.domain.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SpaceDTO {

private long space_no;
private String	host_id;
private long	category_no;
private String	biz_reg_num;
private String	title;
private String	address;
private String	detail_addr;
private String	region;
private String	description;
private MultipartFile thumbnail_url;
private String	status;
private String	created_at;
private String	bank_name;
private String	account_num;

private String price;
private String capacity;

//공간 디테일 DTO 

//공간 이미지 DTO

	
}
