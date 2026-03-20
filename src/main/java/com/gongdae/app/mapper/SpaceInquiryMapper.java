package com.gongdae.app.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.gongdae.app.domain.dto.SpaceInquiryDTO;

@Mapper
public interface SpaceInquiryMapper {
    void insertInquiry(SpaceInquiryDTO dto) throws Exception;
    List<SpaceInquiryDTO> listInquiryBySpace(long spaceNo) throws Exception;
    List<SpaceInquiryDTO> listInquiryByHost(long hostId) throws Exception;
    SpaceInquiryDTO findInquiryById(long inquiryNo) throws Exception;
    void updateInquiryReply(SpaceInquiryDTO dto) throws Exception;
}