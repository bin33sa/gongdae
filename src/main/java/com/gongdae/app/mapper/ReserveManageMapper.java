package com.gongdae.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.domain.dto.ReservationManageDTO;

@Mapper
public interface ReserveManageMapper {
	List<ReservationManageDTO> listReservation(long hostId) throws Exception;
}
