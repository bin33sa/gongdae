package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.admin.domain.dto.GuestManageDto;

public interface GuestManageService {
	public int dataCount(Map<String, Object> map);
	
	public List<GuestManageDto> listGuest(Map<String, Object> map);
	
	public GuestManageDto findById(Long member_id);
	
	public void updateGuest(Map<String, Object> map)throws Exception;
	public void updateGuestEnabled(Map<String, Object> map) throws Exception;
	public void updateFailureCountReset(Long member_id) throws Exception;
	
	public void insertGuestStatus(GuestManageDto dto) throws Exception;
	public List<GuestManageDto> listGuestStatus(Long member_id);
	public GuestManageDto findByStatus(Long member_id);
}
