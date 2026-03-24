package com.gongdae.app.service;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import com.gongdae.app.mapper.HostMainMapper;
import com.gongdae.app.domain.dto.HostSalesDTO;

@Service
@RequiredArgsConstructor
public class HostMainServiceImpl implements HostMainService {

    private final HostMainMapper mapper;

    @Override
    public HostSalesDTO getSalesSummary(long hostId) throws Exception {
        return mapper.getSalesSummary(hostId);
    }
}