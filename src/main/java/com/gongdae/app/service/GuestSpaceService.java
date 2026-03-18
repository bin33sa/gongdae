package com.gongdae.app.service;

import java.util.Map;

public interface GuestSpaceService {
    
    // 공간 상세 페이지에 필요한 4가지 데이터를 한 바구니(Map)에 담아서 반환
    public Map<String, Object> getSpaceDetailAll(long spaceNo) throws Exception;
    
}