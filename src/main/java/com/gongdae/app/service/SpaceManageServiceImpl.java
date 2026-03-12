package com.gongdae.app.service;

import java.util.ArrayList;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.SpaceManageDTO;
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
            long spaceNo = mapper.spaceSeq(); // 시퀀스 채번
            dto.setSpaceNo(spaceNo);
            
            mapper.insertSpace(dto);
            
            // 2. [SPACE_APPROVAL] 최초 승인 대기 상태 인서트 (DDL 반영)
            mapper.insertSpaceApproval(spaceNo);
            
            // 3. [SPACE_OPTION_MAPPING] 공간 옵션 인서트 (공간 단위이므로 루프 밖에서 처리)
            if (dto.getOptionNos() != null && !dto.getOptionNos().isEmpty()) {
                insertSpaceOption(dto);
            }
            
            // 4. [SPACE_UNIT & POLICY] 세부 룸 및 정책 인서트
            if (dto.getUnitTitles() != null && !dto.getUnitTitles().isEmpty()) {
                insertSpaceUnit(dto, uploadPath);
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
                
                long unitNo = mapper.spaceUnitSeq(); // 룸 시퀀스 채번
                dto.setUnitNo(unitNo);
                
                // ★ 중요: 이전 루프의 썸네일 URL 찌꺼기 초기화
                dto.setThumbnailUrl(null); 
                
                // 단일 데이터 임시 세팅
                dto.setUnitTitle(dto.getUnitTitles().get(i));
                dto.setPricePerHour(dto.getPricePerHours().get(i));
                dto.setMaxCapacity(dto.getMaxCapacities().get(i));
                dto.setDescription(dto.getDescriptions().get(i));
                
                dto.setMinHour(dto.getMinHours().get(i));
                dto.setCancelLimitHr(dto.getCancelLimitHrs().get(i));
                dto.setCleaningFee(dto.getCleaningFees().get(i));
                
                // 썸네일 파일 업로드 처리
                if (dto.getUnitThumbnailFiles() != null && dto.getUnitThumbnailFiles().size() > i) {
                    MultipartFile mf = dto.getUnitThumbnailFiles().get(i);
                    if (mf != null && !mf.isEmpty()) {
                        String filename = storageService.uploadFileToServer(mf, uploadPath);
                        dto.setThumbnailUrl(filename);
                    }
                }

                // 매퍼 호출
                mapper.insertSpaceUnit(dto);
                mapper.insertSpacePolicy(dto);
                
                dto.getUnitNos().add(unitNo);
            }
            
            // 5. [SPACE_IMAGE] 룸 다중 이미지 인서트
            // (모든 룸 등록 완료 후, DDL 구조상 대표로 첫 번째 룸(UNIT_NO)에 묶어줍니다)
            if (dto.getAddFiles() != null && !dto.getAddFiles().isEmpty()) {
                insertSpaceFile(dto, uploadPath);
            }
            
        } catch (Exception e) {
            log.error("insertSpaceUnit 오류 발생 : ", e);
            throw e;
        }
    }

    private void insertSpaceFile(SpaceManageDTO dto, String uploadPath) throws Exception {
        int sortOrder = 1; // 정렬 순서 변수
        for (MultipartFile mf : dto.getAddFiles()) {
            try {
                if (mf == null || mf.isEmpty()) continue;
                
                String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
                dto.setFileUrl(saveFilename);
                dto.setSortOrder(sortOrder++); // DDL에 추가된 정렬 순서 부여
                
                // DDL 상 추가 이미지는 UNIT_NO를 참조하므로 첫 번째 룸 번호 매핑
                dto.setUnitNo(dto.getUnitNos().get(0)); 
                mapper.insertSpaceFile(dto); 
                
            } catch (Exception e) {
                throw e;
            }
        }
    }

    private void insertSpaceOption(SpaceManageDTO dto) throws Exception {
        // 옵션은 SPACE_NO 기준 매핑 (기존 코드의 setUnitNo 삭제)
        for (Long optionNo : dto.getOptionNos()) {
            dto.setOptionNo(optionNo);
            mapper.insertSpaceOption(dto);
        }
    }
}