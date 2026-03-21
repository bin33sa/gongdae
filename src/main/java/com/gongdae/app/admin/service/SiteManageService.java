package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.admin.domain.dto.ReportManageDto;
import com.gongdae.app.admin.domain.dto.SiteManageDto;

public interface SiteManageService {
	
    int dataCountReport(Map<String, Object> map);
    List<ReportManageDto> listReport(Map<String, Object> map);
    ReportManageDto findByIdReport(Long reportNo);
    void updateReportStatus(Map<String, Object> map) throws Exception;

    SiteManageDto findBanner(String type);
    void insertBanner(SiteManageDto dto) throws Exception;
    void updateBanner(SiteManageDto dto) throws Exception;
    void deleteBanner(String type) throws Exception;
    
    List<SiteManageDto> listComponent();
    void updateComponent(SiteManageDto dto) throws Exception;
}