package com.gongdae.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.admin.domain.dto.GuestManageDto;

@Mapper
public interface GuestManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<GuestManageDto> listMember(Map<String, Object> map);
	
	public GuestManageDto findById(Long member_id);
	
	public void updateGuest(Map<String, Object> map) throws SQLException;
	public void updateGuestDetail(Map<String, Object> map) throws SQLException;
	public void updateGuestEnabled(Map<String, Object> map) throws SQLException;
	public void updateFailureCountReset(Long member_id) throws SQLException;
	
	public void insertGuestStatus(GuestManageDto dto) throws SQLException;
	public List<GuestManageDto> listGuestStatus(Long member_id);
	public GuestManageDto findByStatus(Long member_id);
	public void updatePoint(Map<String, Object> map) throws SQLException;
    public int getReservationCount(Long member_id);
}
