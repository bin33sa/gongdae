package com.gongdae.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.ReservationManageDTO;

@Mapper
public interface ReserveManageMapper {
	List<ReservationManageDTO> listReservation(Map<String, Object> map) throws Exception;
	int dataCountReservation(long hostId) throws Exception;
	
}
