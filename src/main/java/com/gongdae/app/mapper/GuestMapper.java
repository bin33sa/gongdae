package com.gongdae.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.gongdae.app.domain.dto.GuestDto;

@Mapper
public interface GuestMapper {
	public GuestDto loginSnsMember(Map<String, Object> map);

	public Long memberSeq();	
	public void insertMember1(GuestDto dto) throws SQLException;
	public void insertMember2(GuestDto dto) throws SQLException;
	public void insertMember12(GuestDto dto) throws SQLException;
	public void insertSnsMember(GuestDto dto) throws SQLException;
	public void insertMemberStatus(GuestDto dto) throws SQLException;
	
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void updateMemberPassword(GuestDto dto) throws SQLException;
	
	public void updateMember1(GuestDto dto) throws SQLException;
	public void updateMember2(GuestDto dto) throws SQLException;
	public void deleteProfilePhoto(Map<String, Object> map) throws SQLException;

	public void updateLastLogin(Long member_id) throws SQLException;
	public void updateLastLoginId(String login_id) throws SQLException;
	
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
	
	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;
	
	public List<GuestDto> listFindMember(Map<String, Object> map);
	
	public void insertAuthority(GuestDto dto) throws SQLException;
	public void deleteAuthority(Map<String, Object> map) throws SQLException;
	public String findByAuthority(String login_id);
	
	public void insertRefreshToken(GuestDto dto) throws SQLException;
	public void updateRefreshToken(GuestDto dto) throws SQLException;
	public void deleteRefreshToken(String login_id) throws SQLException;
	public GuestDto findByToken(String login_id);	
}
