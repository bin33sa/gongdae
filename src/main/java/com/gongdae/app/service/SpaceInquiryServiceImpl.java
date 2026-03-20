package com.gongdae.app.service;
import java.util.List;
import org.springframework.stereotype.Service;
import com.gongdae.app.domain.dto.SpaceInquiryDTO;
import com.gongdae.app.mapper.SpaceInquiryMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SpaceInquiryServiceImpl implements SpaceInquiryService {
    private final SpaceInquiryMapper mapper;

    @Override
    public void insertInquiry(SpaceInquiryDTO dto) throws Exception { mapper.insertInquiry(dto); }
    @Override
    public List<SpaceInquiryDTO> listInquiryBySpace(long spaceNo) throws Exception { return mapper.listInquiryBySpace(spaceNo); }
    @Override
    public List<SpaceInquiryDTO> listInquiryByHost(long hostId) throws Exception { return mapper.listInquiryByHost(hostId); }
    @Override
    public SpaceInquiryDTO findInquiryById(long inquiryNo) throws Exception { return mapper.findInquiryById(inquiryNo); }
    @Override
    public void updateInquiryReply(SpaceInquiryDTO dto) throws Exception { mapper.updateInquiryReply(dto); }
}