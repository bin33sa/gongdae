package com.gongdae.app.service;

import com.gongdae.app.domain.dto.PaymentSubmitDto;
import com.gongdae.app.domain.dto.ReservationDto;

public interface PaymentService {
	public void insertReservation(ReservationDto dto) throws Exception;
	
	public ReservationDto getReservationById(long id);
	
	public void insertPayment(PaymentSubmitDto dto) throws Exception;
	
}
