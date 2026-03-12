package com.gongdae.app.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.domain.dto.GuestDto;

public interface GuestService {
	
	public void insertMember(GuestDto dto, String uploadPath) throws Exception;//
	public void insertMemberStatus(GuestDto dto) throws Exception;
	
	public void updatePassword(GuestDto dto) throws Exception;
	public void updateMemberEnabled(Map<String, Object> map) throws Exception;
	public void updateMember(GuestDto dto, String uploadPath) throws Exception;
	
	public void updateLastLogin(Long member_id) throws Exception;
	public void updateLastLogin(String login_id) throws Exception;
	
	public GuestDto findById(Long member_id);
	public GuestDto findById(String login_id);//
	public GuestDto findByNickname(String nickname);//
	public GuestDto findByNameAndEmail(String name, String email); //
	public GuestDto findByIdAndNameAndEmail(String login_id, String name, String email);//
	public Long getMemberId(String login_id);
	
	public int checkFailureCount(String login_id);
	public void updateFailureCountReset(String login_id) throws Exception;
	public void updateFailureCount(String login_id) throws Exception;
	
	public void deleteMember(Map<String, Object> map, String uploadPath) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map, String uploadPath) throws Exception;
	
	public void findId(GuestDto dto) throws Exception;//
	public void findPwd(GuestDto dto) throws Exception;//
	public void generatePwd(GuestDto dto) throws Exception;//
	
	public List<GuestDto> listFindMember(Map<String, Object> map);	
	
	public String findByAuthority(String login_id);
	
	public void insertRefreshToken(GuestDto dto) throws Exception;
	public void updateRefreshToken(GuestDto dto) throws Exception;
	public GuestDto findByToken(String login_id);
	
	public boolean isPasswordCheck(String login_id, String password);
}
