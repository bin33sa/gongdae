package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SpaceDTO {

	private long num;
	private String name;
	private String rating;
	private String review_num;
	private String address;
	private String capacity;
	private String price;
	private String isWished;
	private String thumbnail;
	
	private String host_id;
	private String category;
	private String address2;
	
}
