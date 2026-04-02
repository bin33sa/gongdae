package com.gongdae.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.BannerDto;
import com.gongdae.app.mapper.BannerMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BannerServiceImpl implements BannerService {
	private final BannerMapper mapper;
	
	@Override
	public List<BannerDto> getBanners() {
		List<BannerDto> list = null;
		try {
			list = mapper.getBanners();
		} catch (Exception e) {
			log.info("getBanners: ", e);
		}
		return list;
	}

}
