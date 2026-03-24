package com.gongdae.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.HostSalesDTO;

@Mapper
public interface HostMainMapper {

	public HostSalesDTO getSalesSummary(long hostId);
}
