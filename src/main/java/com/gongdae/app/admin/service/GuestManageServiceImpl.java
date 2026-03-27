package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.gongdae.app.admin.domain.dto.GuestManageDto;
import com.gongdae.app.admin.mapper.GuestManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GuestManageServiceImpl implements GuestManageService {
	private final GuestManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<GuestManageDto> listGuest(Map<String, Object> map) {
		List<GuestManageDto> list = null;
		
		try {
			list = mapper.listMember(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;
	}

	@Override
	public GuestManageDto findById(Long member_id) {
		GuestManageDto dto = null;
		
		try {
			
			dto = Objects.requireNonNull(mapper.findById(member_id));
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

	@Override
	public void updateGuest(Map<String, Object> map) throws Exception {
		try {
			mapper.updateGuest(map);
			mapper.updateGuestDetail(map);
		} catch (Exception e) {
			log.info("updateGuest : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateGuestEnabled(Map<String, Object> map) throws Exception {
		try {
			mapper.updateGuestEnabled(map);
		} catch (Exception e) {
			log.info("updateGuestEnabled : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void updateFailureCountReset(Long member_id) throws Exception {
		try {
			mapper.updateFailureCountReset(member_id);
		} catch (Exception e) {
			log.info("updateFailureCountReset : ", e);
			
			throw e;
		} 
	}

	@Override
	public void insertGuestStatus(GuestManageDto dto) throws Exception {
		try {
			mapper.insertGuestStatus(dto);
		} catch (Exception e) {
			log.info("insertGuestStatus : ", e);
			
			throw e;
		}
	}

	@Override
	public List<GuestManageDto> listGuestStatus(Long member_id) {
		List<GuestManageDto> list = null;
		
		try {
			list = mapper.listGuestStatus(member_id);
		} catch (Exception e) {
			log.info("listGuestStatus : ", e);
			
			throw e;
		}
		
		return list;
	}

	@Override
	public GuestManageDto findByStatus(Long member_id) {
		GuestManageDto dto = null;
		
		try {
			dto = mapper.findByStatus(member_id);
		} catch (Exception e) {
			log.info("findByStatus : ", e);
		}
		
		return dto;
	}
	
	@Override
    public void updatePoint(Map<String, Object> map) throws Exception {
        try {
            mapper.updatePoint(map);
        } catch (Exception e) {
            log.info("updatePoint : ", e);
            throw e;
        }
    }

    @Override
    public void updateAutoGrade(Long member_id) throws Exception {
        try {
            int resCount = mapper.getReservationCount(member_id);
            String newGrade = "BRONZE";
            
            if (resCount >= 50) {
                newGrade = "GOLD";
            } else if (resCount >= 10) {
                newGrade = "SILVER";
            }
            
            Map<String, Object> map = new java.util.HashMap<>();
            map.put("member_id", member_id);
            map.put("grade", newGrade);
            
            mapper.updateGuestDetail(map); 
        } catch (Exception e) {
            log.info("updateAutoGrade : ", e);
            throw e;
        }
    }
	
}
