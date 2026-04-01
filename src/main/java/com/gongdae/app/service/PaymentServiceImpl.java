package com.gongdae.app.service;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.PaymentSubmitDto;
import com.gongdae.app.domain.dto.ReservationDto;
import com.gongdae.app.mapper.PaymentMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PaymentServiceImpl implements PaymentService {
	private final PaymentMapper mapper;
	
	@Override
	public void insertReservation(ReservationDto dto) throws Exception {
		try {
			mapper.insertReservation(dto);
		} catch (Exception e) {
			log.info("insertReservation: ", e);
			throw e;
		}
		
	}
	
	@Override
	public ReservationDto getReservationById(long id) {
		ReservationDto dto = null;
		try {
			dto = mapper.getReservationById(id);
		} catch (Exception e) {
			log.info("getReservationById: ", e);
		}
		return dto;
	}
	
	@Override
	public void insertPayment(PaymentSubmitDto dto) throws Exception {
		try {
			mapper.updateReservation(dto.getRes_no(), "RESERVED");
			mapper.insertPayment(dto);
		} catch (Exception e) {
			log.info("insertPayment: ", e);
			throw e;
		}
		
	}

}
