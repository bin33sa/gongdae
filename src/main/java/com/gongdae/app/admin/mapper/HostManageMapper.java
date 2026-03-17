package com.gongdae.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.admin.domain.dto.HostManageDto;

@Mapper
public interface HostManageMapper {
	public int dataCountHost(Map<String, Object> map);
	public List<HostManageDto> listHost(Map<String, Object> map);
	
	public HostManageDto findById(Long member_id);
	
	public void updateHostDetail(Map<String, Object> map) throws SQLException;
	public void updateHostEnabled(Map<String, Object> map) throws SQLException;
	public void updateFailureCountReset(Long member_id) throws SQLException;
	
	public void insertHostStatus(HostManageDto dto) throws SQLException;
	public List<HostManageDto> listHostStatus(Long member_id);
	public HostManageDto findByStatus(Long member_id);
}
