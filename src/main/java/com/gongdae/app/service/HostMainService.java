package com.gongdae.app.service;

import com.gongdae.app.domain.dto.HostSalesDTO;

public interface HostMainService {
    HostSalesDTO getSalesSummary(long hostId) throws Exception;
}