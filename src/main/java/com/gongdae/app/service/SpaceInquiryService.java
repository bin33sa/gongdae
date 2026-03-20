package com.gongdae.app.service;
import java.util.List;
import com.gongdae.app.domain.dto.SpaceInquiryDTO;

public interface SpaceInquiryService {
    void insertInquiry(SpaceInquiryDTO dto) throws Exception;
    List<SpaceInquiryDTO> listInquiryBySpace(long spaceNo) throws Exception;
    List<SpaceInquiryDTO> listInquiryByHost(long hostId) throws Exception;
    SpaceInquiryDTO findInquiryById(long inquiryNo) throws Exception;
    void updateInquiryReply(SpaceInquiryDTO dto) throws Exception;
}