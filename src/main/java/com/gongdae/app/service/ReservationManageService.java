package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.domain.dto.ReservationManageDTO;

public interface ReservationManageService {
	List<ReservationManageDTO> listReservation(Map<String, Object> map) throws Exception;

	int dataCountReservation(Map<String, Object> map) throws Exception;

	int dataCountSales(Map<String, Object> map) throws Exception;

	List<ReservationManageDTO> listSales(Map<String, Object> map) throws Exception;
}