package com.gongdae.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gongdae.app.domain.dto.GuestDto;
import com.gongdae.app.domain.dto.MemberDto;

@Mapper
public interface GuestMapper {

	public void insertGuest(GuestDto dto) throws SQLException;
	
	public void updateGuestPassword(GuestDto dto) throws SQLException;
	
	public void updateGuestDetail(GuestDto dto) throws SQLException;
	public void deleteProfilePhoto(Map<String, Object> map) throws SQLException;

	public GuestDto findById(Long member_id);
	public GuestDto findByLoginId(String login_id);
	public GuestDto findByNickname(String nickname);
	public GuestDto findByNameAndEmail(
			@Param("name") String name, 
			@Param("email") String email);
	public GuestDto findByLoginIdAndNameAndEmail(
			@Param("login_id") String login_id,
			@Param("name") String name,
			@Param("email") String email);
	public Long getMemberId(String login_id);
	
	public int checkFailureCount(String login_id);
	public void updateFailureCountReset(String login_id) throws SQLException;
	public void updateFailureCount(String login_id) throws SQLException;
	
	public List<MemberDto> listFindMember(Map<String, Object> map);
	
	public void insertAuthority(GuestDto dto) throws SQLException;
	public void deleteAuthority(Map<String, Object> map) throws SQLException;
	public String findByAuthority(String login_id);
	
}
