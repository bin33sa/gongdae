package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.admin.domain.dto.HostManageDto;
import com.gongdae.app.admin.mapper.HostManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class HostManageServiceImpl  implements HostManageService{
	private final HostManageMapper mapper;
	
	@Override
	public int dataCountHost(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCountHost(map);
		} catch (Exception e) {
			log.info("dataCountHost : ", e);
		}
		
		return result;
	}

	@Override
	public List<HostManageDto> listHost(Map<String, Object> map) {
		List<HostManageDto> list = null;
		
		try {
			list = mapper.listHost(map);
		} catch (Exception e) {
			log.info("listHost : ", e);
		}
		
		return list;
	}

	@Override
	public HostManageDto findById(Long member_id) {
		HostManageDto dto = null;
		
		try {
			dto = mapper.findById(member_id);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateHost(Map<String, Object> map) throws Exception {
		try {
			mapper.updateHostDetail(map);
		} catch (Exception e) {
			log.info("updateHost : ", e);
		}
		
	}

	@Override
	public void updateHostEnabled(Map<String, Object> map) throws Exception {
		try {
			mapper.updateHostEnabled(map);
		} catch (Exception e) {
			log.info("updateHostEnabled : ", e);
		}
		
	}

	@Override
	public void updateFailureCountReset(Long member_id) throws Exception {
		try {
			mapper.updateFailureCountReset(member_id);
		} catch (Exception e) {
			log.info("updateFailureCountReset : ", e);
		}
		
	}

	@Override
	public void insertHostStatus(HostManageDto dto) throws Exception {
		try {
			mapper.insertHostStatus(dto);
		} catch (Exception e) {
			log.info("insertHostStatus : ", e);
		}
		
	}

	@Override
	public List<HostManageDto> listHostStatus(Long member_id) {
		List<HostManageDto> list = null;
		
		try {
			list = mapper.listHostStatus(member_id);
		} catch (Exception e) {
			log.info("listHostStatus : ", e);
		}
		
		return list;
	}

	@Override
	public HostManageDto findByStatus(Long member_id) {
		HostManageDto dto = null;
		
		try {
			dto = mapper.findByStatus(member_id);
		} catch (Exception e) {
			log.info("findByStatus : ", e);
		}
		
		return dto;
	}

}
