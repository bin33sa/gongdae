package com.gongdae.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.admin.domain.dto.ReportManageDto;
import com.gongdae.app.admin.domain.dto.SiteManageDto;

@Mapper
public interface SiteManageMapper {
    int dataCountReport(Map<String, Object> map);
    List<ReportManageDto> listReport(Map<String, Object> map);
    ReportManageDto findByIdReport(Long reportNo);
    void updateReportStatus(Map<String, Object> map);

    SiteManageDto findBanner(String type);
    void insertBanner(SiteManageDto dto);
    void updateBanner(SiteManageDto dto);
    void deleteBanner(String type);
    
    List<SiteManageDto> listComponent();
    void updateComponent(SiteManageDto dto);
    
}