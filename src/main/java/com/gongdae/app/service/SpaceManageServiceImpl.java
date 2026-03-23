package com.gongdae.app.service;

import java.util.HashMap;
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
			long spaceNo = mapper.spaceSeq();
			dto.setSpaceNo(spaceNo);
			mapper.insertSpace(dto);

			if (dto.getAddFiles() != null) {
				for (MultipartFile mf : dto.getAddFiles()) {
					if (!mf.isEmpty()) {
						String saveFilename = storageService.uploadFileToServer(mf, uploadPath);
						dto.setFileUrl(saveFilename);
						mapper.insertSpaceImage(dto);
					}
				}
			}

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

					String unitThumb = "";
					if (dto.getUnitThumbnailFiles() != null && dto.getUnitThumbnailFiles().size() > i) {
						MultipartFile mf = dto.getUnitThumbnailFiles().get(i);
						if (!mf.isEmpty())
							unitThumb = storageService.uploadFileToServer(mf, uploadPath);
					}
					dto.setThumbnailUrl(unitThumb);

					mapper.insertSpaceUnit(dto);
					dto.setMinHour(dto.getMinHours().get(i));
					dto.setCancelLimitHr(dto.getCancelLimitHrs().get(i));
					dto.setCleaningFee(dto.getCleaningFees().get(i));
					mapper.insertSpacePolicy(dto);

					String[] days = { "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" };
					int timeOffset = i * 7;
					for (int j = 0; j < 7; j++) {
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
				mapper.insertSpaceApproval(spaceNo);
			}
		} catch (Exception e) {
			log.error("insertSpace 에러 : ", e);
			throw e;
		}
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void updateSpace(SpaceManageDTO dto, String uploadPath) throws Exception {
		try {
			mapper.updateSpace(dto);

			if (dto.getDeleteImageNos() != null) {
				for (Long imgNo : dto.getDeleteImageNos()) {
					SpaceManageDTO imgDto = mapper.findImageById(imgNo);
					if (imgDto != null) {
						storageService.deleteFile(uploadPath, imgDto.getFileUrl());
						mapper.deleteSpaceImage(imgNo);
					}
				}
			}

			if (dto.getAddFiles() != null) {
				for (MultipartFile mf : dto.getAddFiles()) {
					if (!mf.isEmpty()) {
						String saveFilename = storageService.uploadFileToServer(mf, uploadPath);
						dto.setFileUrl(saveFilename);
						mapper.insertSpaceImage(dto);
					}
				}
			}

			mapper.deleteSpaceOptions(dto.getSpaceNo());
			mapper.deleteSpaceUnitTimes(dto.getSpaceNo());
			mapper.deleteSpacePolicies(dto.getSpaceNo());
			mapper.deleteSpaceUnits(dto.getSpaceNo());

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

					String unitThumb = "";
					boolean hasNewFile = false;
					if (dto.getUnitThumbnailFiles() != null && dto.getUnitThumbnailFiles().size() > i) {
						MultipartFile mf = dto.getUnitThumbnailFiles().get(i);
						if (!mf.isEmpty()) {
							unitThumb = storageService.uploadFileToServer(mf, uploadPath);
							hasNewFile = true;
						}
					}
					if (!hasNewFile && dto.getExistThumbnailUrls() != null && dto.getExistThumbnailUrls().size() > i) {
						unitThumb = dto.getExistThumbnailUrls().get(i);
					}
					dto.setThumbnailUrl(unitThumb);

					mapper.insertSpaceUnit(dto);
					dto.setMinHour(dto.getMinHours().get(i));
					dto.setCancelLimitHr(dto.getCancelLimitHrs().get(i));
					dto.setCleaningFee(dto.getCleaningFees().get(i));
					mapper.insertSpacePolicy(dto);

					String[] days = { "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" };
					int timeOffset = i * 7;
					for (int j = 0; j < 7; j++) {
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
			log.error("updateSpace 에러 : ", e);
			throw e;
		}
	}

	// 💡 논리적 삭제
	@Transactional(rollbackFor = { Exception.class })
	@Override
	public void deleteSpace(long spaceNo, long hostId) throws Exception {
		try {
			SpaceManageDTO dto = mapper.findById(spaceNo);
			if (dto == null || dto.getHostId() != hostId) {
				throw new Exception("삭제 권한이 없거나 이미 삭제 처리된 공간입니다.");
			}
			mapper.deleteSpace(spaceNo);
		} catch (Exception e) {
			log.error("deleteSpace 에러 : ", e);
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

	@Override
	public SpaceManageDTO findById(long spaceNo) throws Exception {
		return mapper.findById(spaceNo);
	}

	@Override
	public List<SpaceManageDTO> listSpaceImage(long spaceNo) throws Exception {
		return mapper.listSpaceImage(spaceNo);
	}

	@Override
	public List<Long> listSpaceOption(long spaceNo) throws Exception {
		return mapper.listSpaceOption(spaceNo);
	}

	@Override
	public List<SpaceManageDTO> listSpaceUnit(long spaceNo) throws Exception {
		return mapper.listSpaceUnit(spaceNo);
	}
	@Override
	public List<SpaceManageDTO> listSpace(long hostId) throws Exception {
		return mapper.listSpace(hostId);
	}

	@Transactional(rollbackFor = Exception.class)
    @Override
    public void togglePremium(long spaceNo, long hostId, String currentPremiumStatus) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("spaceNo", spaceNo);
        map.put("hostId", hostId);

        if ("N".equals(currentPremiumStatus)) {
            // 💡 1. [신청] 버튼 클릭 -> 승인 대기(P) 상태로 변경
            map.put("isPremium", "P");
            map.put("status", "PENDING");
            mapper.updateSpacePremiumFlag(map);
            mapper.insertPremiumHistory(map);
            
        } else if ("P".equals(currentPremiumStatus)) {
            // 💡 2. [승인 대기중] 버튼 클릭 -> 신청 취소(N) 상태로 복귀
            map.put("isPremium", "N");
            map.put("status", "CANCELED"); // 이력은 '취소됨'으로 남김
            mapper.updateSpacePremiumFlag(map);
            mapper.updatePremiumHistory(map);
            
        } else if ("Y".equals(currentPremiumStatus)) {
            // 💡 3. [적용중] 버튼 클릭 -> 광고 해지(N) 상태로 복귀
            map.put("isPremium", "N");
            map.put("status", "INACTIVE"); // 이력은 '해지됨'으로 남김
            mapper.updateSpacePremiumFlag(map);
            mapper.updatePremiumHistory(map);
        }
    }
}