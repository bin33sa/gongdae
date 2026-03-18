package com.gongdae.app.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import com.gongdae.app.mapper.GuestSpaceMapper;

@Slf4j
@Service
@RequiredArgsConstructor
public class GuestSpaceServiceImpl implements GuestSpaceService {

    private final GuestSpaceMapper mapper;

    @Override
    public Map<String, Object> getSpaceDetailAll(long spaceNo) throws Exception {
        
        
        Map<String, Object> resultMap = new HashMap<>();
        
        try {
           
            resultMap.put("space", mapper.getSpaceDetail(spaceNo));
            resultMap.put("images", mapper.getSpaceImages(spaceNo));
            resultMap.put("options", mapper.getSpaceOptions(spaceNo));
            resultMap.put("units", mapper.getSpaceUnits(spaceNo));
            
        } catch (Exception e) {
            log.error("공간 상세: ", e);
            throw e; 
        }
        
        return resultMap; 
    }
}