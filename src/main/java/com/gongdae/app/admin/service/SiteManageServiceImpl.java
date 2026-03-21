package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.admin.domain.dto.ReportManageDto;
import com.gongdae.app.admin.domain.dto.SiteManageDto;
import com.gongdae.app.admin.mapper.SiteManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SiteManageServiceImpl implements SiteManageService {

    private final SiteManageMapper mapper;

    @Override
    public int dataCountReport(Map<String, Object> map) {
        int result = 0;

        try {
            result = mapper.dataCountReport(map);
        } catch (Exception e) {
            log.info("dataCountReport : ", e);
        }

        return result;
    }

    @Override
    public List<ReportManageDto> listReport(Map<String, Object> map) {
        List<ReportManageDto> list = null;

        try {
            list = mapper.listReport(map);
        } catch (Exception e) {
            log.info("listReport : ", e);
        }

        return list;
    }

    @Override
    public ReportManageDto findByIdReport(Long reportNo) {
        ReportManageDto dto = null;

        try {
            dto = mapper.findByIdReport(reportNo);
        } catch (Exception e) {
            log.info("findByIdReport : ", e);
        }

        return dto;
    }

    @Override
    public void updateReportStatus(Map<String, Object> map) throws Exception {
        try {
            mapper.updateReportStatus(map);
        } catch (Exception e) {
            log.info("updateReportStatus : ", e);

            throw e;
        }
    }

    @Override
    public SiteManageDto findBanner(String type) {
        SiteManageDto dto = null;

        try {
            dto = mapper.findBanner(type);
        } catch (Exception e) {
            log.info("findBanner : ", e);
        }

        return dto;
    }

    @Override
    public void insertBanner(SiteManageDto dto) throws Exception {
        try {
            mapper.insertBanner(dto);
        } catch (Exception e) {
            log.info("insertBanner : ", e);

            throw e;
        }
    }

    @Override
    public void updateBanner(SiteManageDto dto) throws Exception {
        try {
            mapper.updateBanner(dto);
        } catch (Exception e) {
            log.info("updateBanner : ", e);

            throw e;
        }
    }
    
    @Override
    public void deleteBanner(String type) throws Exception {
        try {
            mapper.deleteBanner(type);
        } catch (Exception e) {
            log.info("deleteBanner : ", e);
            throw e;
        }
    }
    
    @Override
    public List<SiteManageDto> listComponent() {
        List<SiteManageDto> list = null;

        try {
            list = mapper.listComponent();
        } catch (Exception e) {
            log.info("listComponent : ", e);
        }

        return list;
    }

    @Override
    public void updateComponent(SiteManageDto dto) throws Exception {
        try {
            mapper.updateComponent(dto);
        } catch (Exception e) {
            log.info("updateComponent : ", e);

            throw e;
        }
    }
}