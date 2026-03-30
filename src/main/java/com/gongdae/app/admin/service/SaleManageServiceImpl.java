package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.admin.domain.dto.SalesManageDto;
import com.gongdae.app.admin.mapper.SaleManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SaleManageServiceImpl implements SaleManageService {
	private final SaleManageMapper mapper;

	@Override
	public SalesManageDto getTodaySummary() {
		SalesManageDto dto = null;
		try {
			dto = mapper.getTodaySummary();
		} catch (Exception e) {
			log.info("getTodaySummary : ", e);
		}
		return dto;
	}

	@Override
	public List<SalesManageDto> getDailySalesList() {
		List<SalesManageDto> list = null;
		try {
			list = mapper.getDailySalesList();
		} catch (Exception e) {
			log.info("getDailySalesList : ", e);
		}
		return list;
	}

	@Override
	public SalesManageDto getThisMonthSummary() {
		SalesManageDto dto = null;
		try {
			dto = mapper.getThisMonthSummary();
		} catch (Exception e) {
			log.info("getThisMonthSummary : ", e);
		}
		return dto;
	}

	@Override
	public SalesManageDto getLastMonthSummary() {
		SalesManageDto dto = null;
		try {
			dto = mapper.getLastMonthSummary();
		} catch (Exception e) {
			log.info("getLastMonthSummary : ", e);
		}
		return dto;
	}

	@Override
	public List<SalesManageDto> getMonthlySalesList() {
		List<SalesManageDto> list = null;
		try {
			list = mapper.getMonthlySalesList();
		} catch (Exception e) {
			log.info("getMonthlySalesList : ", e);
		}
		return list;
	}


	@Override
	public int getReservationCount(Map<String, Object> map) {
		int dataCount = 0;
		try {
			dataCount = mapper.getReservationCount(map);
		} catch (Exception e) {
			log.info("getReservationCount : ", e);
		}
		return dataCount;
	}

	@Override
	public List<SalesManageDto> getReservationList(Map<String, Object> map) {
		List<SalesManageDto> list = null;
		try {
			list = mapper.getReservationList(map);
		} catch (Exception e) {
			log.info("getReservationList : ", e);
		}
		return list;
	}

	@Override
	public SalesManageDto getReservationDetail(Long resNo) {
		SalesManageDto dto = null;
		try {
			dto = mapper.getReservationDetail(resNo);
		} catch (Exception e) {
			log.info("getReservationDetail : ", e);
		}
		return dto;
	}
}