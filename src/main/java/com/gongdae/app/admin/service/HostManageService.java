package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.admin.domain.dto.HostManageDto;

public interface HostManageService {
	public int dataCountHost(Map<String, Object> map);
	
	public List<HostManageDto> listHost(Map<String, Object> map);
	
	public HostManageDto findById(Long member_id);
	
	public void updateHost(Map<String, Object> map)throws Exception;
	public void updateHostEnabled(Map<String, Object> map) throws Exception;
	public void updateFailureCountReset(Long member_id) throws Exception;
	
	public void insertHostStatus(HostManageDto dto) throws Exception;
	public List<HostManageDto> listHostStatus(Long member_id);
	public HostManageDto findByStatus(Long member_id);
}
