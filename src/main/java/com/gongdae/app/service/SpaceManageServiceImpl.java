package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

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

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void insertSpace(SpaceManageDTO dto, String uploadPath) throws Exception {
		try {
			// 1. 공간 정보 저장 (admin_id 없이 인서트)
			long spaceNo = mapper.spaceSeq();
			dto.setSpaceNo(spaceNo);
			mapper.insertSpace(dto);

			// 2. 공간 전체 다중 이미지 저장
			if (dto.getAddFiles() != null) {
				for (MultipartFile mf : dto.getAddFiles()) {
					if (!mf.isEmpty()) {
						String saveFilename = storageService.uploadFileToServer(mf, uploadPath);
						dto.setFileUrl(saveFilename);
						mapper.insertSpaceImage(dto);
					}
				}
			}

			// 3. 유닛(룸) 배열 데이터 저장
			if (dto.getUnitTitles() != null) {
				long firstUnitNo = -1;

				for (int i = 0; i < dto.getUnitTitles().size(); i++) {
					long unitNo = mapper.unitSeq();
					if (i == 0)
						firstUnitNo = unitNo;

					dto.setUnitNo(unitNo);
					dto.setTitle(dto.getUnitTitles().get(i));
					dto.setPricePerHour(dto.getPricePerHours().get(i));
					dto.setMaxCapacity(dto.getMaxCapacities().get(i));
					dto.setDescription(dto.getDescriptions() != null ? dto.getDescriptions().get(i) : "");

					// 유닛 썸네일 업로드
					String unitThumb = "";
					if (dto.getUnitThumbnailFiles() != null && dto.getUnitThumbnailFiles().size() > i) {
						MultipartFile mf = dto.getUnitThumbnailFiles().get(i);
						if (!mf.isEmpty()) {
							unitThumb = storageService.uploadFileToServer(mf, uploadPath);
						}
					}
					dto.setThumbnailUrl(unitThumb);

					// 유닛 관련 데이터 일괄 Insert
					mapper.insertSpaceUnit(dto);

					dto.setMinHour(dto.getMinHours().get(i));
					dto.setCancelLimitHr(dto.getCancelLimitHrs().get(i));
					dto.setCleaningFee(dto.getCleaningFees().get(i));
					mapper.insertSpacePolicy(dto);

					String[] days = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
                    int timeOffset = i * 7; // 유닛(룸) 1개당 7개의 데이터가 배열에 쌓이므로 오프셋 계산
                    
                    for(int j = 0; j < 7; j++) {
                        dto.setDayOfWeek(days[j]);
                        dto.setOpenTime(dto.getOpenTimes().get(timeOffset + j));
                        dto.setCloseTime(dto.getCloseTimes().get(timeOffset + j));
                        mapper.insertSpaceUnitTime(dto); 
                    }
                
				}

				if (dto.getOptionNos() != null && firstUnitNo != -1) {
					dto.setUnitNo(firstUnitNo);
					for (Long optNo : dto.getOptionNos()) {
						dto.setOptionNo(optNo);
						mapper.insertSpaceOption(dto);
					}
				}
			}
		} catch (Exception e) {
			log.error("insertSpace 에러 : ", e);
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> listCategory() {
		return mapper.listCategory();
	}

	@Override
	public List<Map<String, Object>> listOption() {
		return mapper.listOption();
	}
}