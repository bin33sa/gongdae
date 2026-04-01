package com.gongdae.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gongdae.app.domain.dto.PaymentSubmitDto;
import com.gongdae.app.domain.dto.ReservationDto;

@Mapper
public interface PaymentMapper {
	public void insertReservation(ReservationDto dto) throws SQLException;
	public ReservationDto getReservationById(long id);
	public void updateReservation(@Param("res_no") long res_no, @Param("status") String status);
	public void insertPayment(PaymentSubmitDto dto) throws SQLException;
	
}
