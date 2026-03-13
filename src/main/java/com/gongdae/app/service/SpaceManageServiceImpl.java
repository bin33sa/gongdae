package com.gongdae.app.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.SpaceManageDTO;
import com.gongdae.app.domain.dto.SpaceOptionDTO;
import com.gongdae.app.mapper.SpaceManageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class SpaceManageServiceImpl implements SpaceManageService {
    
    private final SpaceManageMapper mapper;
    private final StorageService storageService;

    @Transactional(rollbackFor = {Exception.class})
    @Override
    public void insertSpace(SpaceManageDTO dto, String uploadPath) throws Exception {
        try {
            // 1. [SPACE] 공간 마스터 테이블 인서트
            long spaceNo = mapper.spaceSeq();
            dto.setSpaceNo(spaceNo);
            
            mapper.insertSpace(dto);
            
           
            mapper.insertSpaceApproval(spaceNo);
            
           
            if (dto.getUnitTitles() != null && !dto.getUnitTitles().isEmpty()) {
                insertSpaceUnit(dto, uploadPath);
            }
            
           
            if (dto.getOptionNos() != null && !dto.getOptionNos().isEmpty()) {
                insertSpaceOption(dto);
            }
            
        } catch (Exception e) {
            log.error("insertSpace 오류 발생 : ", e);
            throw e; 
        }
    }

    private void insertSpaceUnit(SpaceManageDTO dto, String uploadPath) throws Exception {
        try {
            dto.setUnitNos(new ArrayList<Long>());
            
            int size = dto.getUnitTitles().size();
            for (int i = 0; i < size; i++) {
                
                long unitNo = mapper.spaceUnitSeq();
                dto.setUnitNo(unitNo);
                
                dto.setThumbnailUrl(null); 
                
                dto.setUnitTitle(dto.getUnitTitles().get(i));
                dto.setPricePerHour(dto.getPricePerHours().get(i));
                dto.setMaxCapacity(dto.getMaxCapacities().get(i));
                dto.setDescription(dto.getDescriptions().get(i));
                
                dto.setMinHour(dto.getMinHours().get(i));
                dto.setCancelLimitHr(dto.getCancelLimitHrs().get(i));
                dto.setCleaningFee(dto.getCleaningFees().get(i));
                
               
                if (dto.getUnitThumbnailFiles() != null && dto.getUnitThumbnailFiles().size() > i) {
                    MultipartFile mf = dto.getUnitThumbnailFiles().get(i);
                    if (mf != null && !mf.isEmpty()) {
                        String filename = storageService.uploadFileToServer(mf, uploadPath);
                        dto.setThumbnailUrl(filename);
                    }
                }

                mapper.insertSpaceUnit(dto);
                mapper.insertSpacePolicy(dto);
                
               
                dto.getUnitNos().add(unitNo);
            }
            
           
            if (dto.getAddFiles() != null && !dto.getAddFiles().isEmpty()) {
                insertSpaceFile(dto, uploadPath);
            }
            
        } catch (Exception e) {
            log.error("insertSpaceUnit 오류 발생 : ", e);
            throw e;
        }
    }

    private void insertSpaceFile(SpaceManageDTO dto, String uploadPath) throws Exception {
        int sortOrder = 1; 
        for (MultipartFile mf : dto.getAddFiles()) {
            try {
                if (mf == null || mf.isEmpty()) continue;
                
                String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
                dto.setFileUrl(saveFilename);
                dto.setSortOrder(sortOrder++); 
                
                dto.setUnitNo(dto.getUnitNos().get(0)); 
                mapper.insertSpaceFile(dto); 
                
            } catch (Exception e) {
                throw e;
            }
        }
    }

    private void insertSpaceOption(SpaceManageDTO dto) throws Exception {
        
        for (Long optionNo : dto.getOptionNos()) {
            dto.setOptionNo(optionNo);
            dto.setUnitNo(dto.getUnitNos().get(0)); 
            mapper.insertSpaceOption(dto);
        }
    }

	@Override
	public List<CategoryDTO> listCategory() throws Exception {
		try {
            // 매퍼의 listCategory 쿼리를 실행하고 그 결과를 그대로 리턴
            return mapper.listCategory();
        } catch (Exception e) {
            log.error("listCategory 오류 발생 : ", e);
            throw e;
        }
		
	}

	@Override
	public List<SpaceOptionDTO> listSpaceOption() throws Exception {
		try {
            // 매퍼의 listSpaceOption 쿼리를 실행하고 그 결과를 그대로 리턴
            return mapper.listSpaceOption();
        } catch (Exception e) {
            log.error("listSpaceOption 오류 발생 : ", e);
            throw e;
        }
	}
}