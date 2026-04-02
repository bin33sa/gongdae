package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class BannerDto {
	private long banner_no;
    private String save_filename;
    private String link_url;
}
