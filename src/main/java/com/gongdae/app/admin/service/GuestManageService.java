package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.admin.domain.dto.GuestManageDto;

public interface GuestManageService {
	public int dataCount(Map<String, Object> map);
	
	public List<GuestManageDto> listGuest(Map<String, Object> map);
}
