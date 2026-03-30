package com.gongdae.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.ReservationManageDTO;

@Mapper
public interface ReserveManageMapper {
	List<ReservationManageDTO> listReservation(Map<String, Object> map) throws Exception;

	int dataCountReservation(Map<String, Object> map) throws Exception;

	int dataCountSales(Map<String, Object> map) throws Exception;
	
	int checkDoubleBooking(long resNo) throws Exception;
	
	List<ReservationManageDTO> listSales(Map<String, Object> map) throws Exception;
}
