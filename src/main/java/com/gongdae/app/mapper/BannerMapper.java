package com.gongdae.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.BannerDto;

@Mapper
public interface BannerMapper {
	public List<BannerDto> getBanners();
}
