package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gongdae.app.admin.domain.dto.SpaceManageDto;
import com.gongdae.app.admin.mapper.AdminSpaceManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminSpaceManageServiceImpl implements AdminSpaceManageService {
    
    private final AdminSpaceManageMapper mapper;

    @Override
    public int dataCountSpace(Map<String, Object> map) throws Exception {
        int result = 0;

        try {
            result = mapper.dataCountSpace(map);
        } catch (Exception e) {
            log.info("dataCountSpace : ", e);
            throw e;
        }

        return result;
    }

    @Override
    public List<SpaceManageDto> listSpace(Map<String, Object> map) throws Exception {
        List<SpaceManageDto> list = null;

        try {
            list = mapper.listSpace(map);
        } catch (Exception e) {
            log.info("listSpace : ", e);
            throw e;
        }

        return list;
    }

    @Override
    public int dataCountPremium(Map<String, Object> map) throws Exception {
        int result = 0;

        try {
            result = mapper.dataCountPremium(map);
        } catch (Exception e) {
            log.info("dataCountPremium : ", e);
            throw e;
        }

        return result;
    }

    @Override
    public List<SpaceManageDto> listPremium(Map<String, Object> map) throws Exception {
        List<SpaceManageDto> list = null;

        try {
            list = mapper.listPremium(map);
        } catch (Exception e) {
            log.info("listPremium : ", e);
            throw e;
        }

        return list;
    }

    @Override
    public void updateSpaceStatus(Map<String, Object> map) throws Exception {
        try {
            mapper.updateSpaceStatus(map);
        } catch (Exception e) {
            log.info("updateSpaceStatus : ", e);
            throw e;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void approvePremium(Map<String, Object> map) throws Exception {
        try {
            mapper.approvePremium(map);
            mapper.updateSpacePremiumFlagToY(Long.parseLong(map.get("spaceNo").toString()));
        } catch (Exception e) {
            log.info("approvePremium : ", e);
            throw e;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void cancelPremium(Map<String, Object> map) throws Exception {
        try {
            mapper.cancelPremium(map);
            mapper.updateSpacePremiumFlagToN(Long.parseLong(map.get("spaceNo").toString()));
        } catch (Exception e) {
            log.info("cancelPremium : ", e);
            throw e;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void insertPremiumForce(Map<String, Object> map) throws Exception {
        try {
            mapper.insertPremiumForce(map);
            mapper.updateSpacePremiumFlagToY(Long.parseLong(map.get("spaceNo").toString()));
        } catch (Exception e) {
            log.info("insertPremiumForce : ", e);
            throw e;
        }
    }

    @Override
    public SpaceManageDto findByIdSpace(long spaceNo) throws Exception {
        SpaceManageDto dto = null;

        try {
            dto = mapper.findByIdSpace(spaceNo);
        } catch (Exception e) {
            log.info("findByIdSpace : ", e);
            throw e;
        }

        return dto;
    }

    @Override
    public List<SpaceManageDto> listSpaceImage(long spaceNo) throws Exception {
        List<SpaceManageDto> list = null;

        try {
            list = mapper.listSpaceImage(spaceNo);
        } catch (Exception e) {
            log.info("listSpaceImage : ", e);
            throw e;
        }

        return list;
    }

    @Override
    public List<SpaceManageDto> listSpaceUnit(long spaceNo) throws Exception {
        List<SpaceManageDto> list = null;

        try {
            list = mapper.listSpaceUnit(spaceNo);
        } catch (Exception e) {
            log.info("listSpaceUnit : ", e);
            throw e;
        }

        return list;
    }
}