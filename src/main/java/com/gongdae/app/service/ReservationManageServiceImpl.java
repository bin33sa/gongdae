package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.ReservationManageDTO;
import com.gongdae.app.mapper.ReserveManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReservationManageServiceImpl implements ReservationManageService {

    private final ReserveManageMapper mapper;

    @Override
    public List<ReservationManageDTO> listReservation(Map<String, Object> map) throws Exception {
        try {
            return mapper.listReservation(map);
        } catch (Exception e) {
            log.error("예약 목록 조회 실패", e);
            throw e;
        }
    }

	@Override
	public int dataCountReservation(long hostId) throws Exception {
		return mapper.dataCountReservation(hostId);
		
	}
}