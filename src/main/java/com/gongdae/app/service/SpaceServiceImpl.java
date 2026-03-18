package com.gongdae.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;

import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.CategoryDTO;
import com.gongdae.app.domain.dto.MemberDto;
import com.gongdae.app.domain.dto.SpaceDTO;
import com.gongdae.app.mapper.SpaceMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SpaceServiceImpl implements SpaceService {
	private final SpaceMapper mapper;
	private final StorageService storageService;
	

	@Override
	public List<SpaceDTO> spaceList(Map<String, Object> params) {
		List<SpaceDTO> spaceList = null;
		try {
			spaceList = mapper.spaceList(params);
		} catch (Exception e) {
			log.info("spaceList: ", e);
		}
		
		return spaceList;
	}
	
	@Override
	public List<CategoryDTO> categoryList() {
		List<CategoryDTO> categoryList = null;
		try {
			categoryList = mapper.categoryList();
		} catch (Exception e) {
			log.info("categoryList: ", e);
		}
		return categoryList;
	}
	
	@Override
	public SpaceDTO findSpaceById(String spaceId) {
		SpaceDTO space = null;
		try {
			space = mapper.findSpaceById(spaceId);
		} catch (Exception e) {
			log.info("findSpaceById: ", e);
		}
		
		return space;
	}
	
	///////////////////////////////////////////
	@Override
	public void insertMember(MemberDto dto, String uploadPath) throws Exception {

	}

	@Override
	public void insertMemberStatus(MemberDto dto) throws Exception {
		try {
			mapper.insertMemberStatus(dto);
		} catch (Exception e) {
			log.info("updateLastLogin : ", e);
			
			throw e;
		}
	}

	@Override
	public void updatePassword(MemberDto dto) throws Exception {

	}

	@Override
	public void updateMemberEnabled(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberEnabled(map);
		} catch (Exception e) {
			log.info("updateMemberEnabled : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateMember(MemberDto dto, String uploadPath) throws Exception {

	}

	@Override
	public void updateLastLogin(Long member_id) throws Exception {

	}

	@Override
	public void updateLastLogin(String login_id) throws Exception {
		try {
			mapper.updateLastLoginId(login_id);
		} catch (Exception e) {
			log.info("updateLastLoginId : ", e);
			
			throw e;
		}
	}

	@Override
	public MemberDto findById(Long member_id) {
		
		return null;
	}

	@Override
	public MemberDto findById(String login_id) {
		MemberDto dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findByLoginId(login_id));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}
	
	@Override
	public Long getMemberId(String login_id) {

		return 0L;
	}
	
	@Override
	public int checkFailureCount(String login_id) {
		int result = 0;
		
		try {
			result = mapper.checkFailureCount(login_id);
		} catch (Exception e) {
			log.info("checkFailureCount : ", e);
		}
		
		return result;
	}

	@Override
	public void updateFailureCountReset(String login_id) throws Exception {
		try {
			mapper.updateFailureCountReset(login_id);
		} catch (Exception e) {
			log.info("updateFailureCountReset : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateFailureCount(String login_id) throws Exception {
		try {
			mapper.updateFailureCount(login_id);
		} catch (Exception e) {
			log.info("updateFailureCount : ", e);
			
			throw e;
		}
	}

	@Override
	public void deleteMember(Map<String, Object> map, String uploadPath) throws Exception {

	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map, String uploadPath) throws Exception {
		// 프로파일 포토 삭제
		try {
			String filename = (String)map.get("filename");
			if(filename!= null && ! filename.isBlank()) {
				storageService.deleteFile(uploadPath, filename);
			}
			
			mapper.deleteProfilePhoto(map);
		} catch (Exception e) {
			log.info("deleteProfilePhoto : ", e);
			
			throw e;
		}
	}
	
	@Override
	public void generatePwd(MemberDto dto) throws Exception {

	}

	@Override
	public List<MemberDto> listFindMember(Map<String, Object> map) {
		
		return null;
	}

	@Override
	public String findByAuthority(String login_id) {
		String authority = null;
		
		try {
			authority = mapper.findByAuthority(login_id);
		} catch (Exception e) {
			log.info("findByAuthority", e);
		}
		
		return authority;
	}

	@Override
	public void insertRefreshToken(MemberDto dto) throws Exception {

	}

	@Override
	public void updateRefreshToken(MemberDto dto) throws Exception {

	}

	@Override
	public MemberDto findByToken(String login_id) {

		return null;
	}


}
