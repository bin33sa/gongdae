package com.gongdae.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.admin.domain.dto.GuestManageDto;

@Mapper
public interface GuestManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<GuestManageDto> listMember(Map<String, Object> map);
}
