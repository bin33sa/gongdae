package com.gongdae.app.guest.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.domain.dto.GuestDto;

public interface GuestService {
	
	public void insertGuest(GuestDto dto, String uploadPath) throws Exception;
	
	public void updatePassword(GuestDto dto) throws Exception;
	public void updateMember(GuestDto dto, String uploadPath) throws Exception;
	
	public GuestDto findById(Long member_id);
	public GuestDto findById(String login_id);//
	public GuestDto findGuestByNickname(String nickname);//
	public GuestDto findGuestByNameAndEmail(String name, String email); //
	public GuestDto findGuestByIdAndNameAndEmail(String login_id, String name, String email);//
	public Long getMemberId(String login_id);
	
	public int checkFailureCount(String login_id);
	public void updateFailureCountReset(String login_id) throws Exception;
	public void updateFailureCount(String login_id) throws Exception;
	
	public void deleteMember(Map<String, Object> map, String uploadPath) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map, String uploadPath) throws Exception;
	
	public void sendGuestId(GuestDto dto) throws Exception;//
	public void sendGuestPwd(GuestDto dto) throws Exception;//
	public void generatePwd(GuestDto dto) throws Exception;//
	
	public List<GuestDto> listFindMember(Map<String, Object> map);	
	
	public String findByAuthority(String login_id);
	
	public boolean isPasswordCheck(String login_id, String password);
}
