package com.gongdae.app.service;

import java.security.SecureRandom;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.gongdae.app.domain.dto.MemberDto;
import com.gongdae.app.mail.Mail;
import com.gongdae.app.mail.MailService;
import com.gongdae.app.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {
	private final MemberMapper mapper;
	private final MailService mailService;
	private final PasswordEncoder bcryptEncoder;
	

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
	public MemberDto findByNickname(String nickname) {
		MemberDto dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByNickname(nickname));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByNickname : ", e);
		}
		
		return dto;
	}
	
	@Override
	public MemberDto findByNameAndEmail(String name, String email) {
		MemberDto dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByNameAndEmail(name, email));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByNameAndEmail : ", e);
		}
		
		return dto;
	}

	@Override
	public MemberDto findByIdAndNameAndEmail(String login_id, String name, String email) {
		MemberDto dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByLoginIdAndNameAndEmail(login_id, name, email));
		} catch(NullPointerException e) {
		} catch(Exception e) {
			log.info("findByIdAndNameAndEmail : ", e);
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

	}

	@Override
	public void findId(MemberDto dto) throws Exception {
		try {
	        
			String result;
			result = dto.getName() +"님의 아이디는 <b> "
					+ dto.getLogin_id() + " </b> 입니다.";
			
			Mail mail = new Mail();
			mail.setReceiverEmail(dto.getEmail());
			
			mail.setSenderEmail("alstjd4824@gmail.com");
			mail.setSenderName("공대생");
			mail.setSubject("계정 조회");
			mail.setContent(result);
			mail.setContentHtml(true);
			
			// 메일 전송
			boolean b = mailService.sendHtmlMail(mail);
			
			if( ! b ) {
				throw new Exception("이메일 전송중 오류가 발생했습니다.");
			}

		} catch (Exception e) {
			throw e;
		}
	}
	
	@Override
	public void findPwd(MemberDto dto) throws Exception {
		// 10 자리 임시 패스워드 생성
		String lowercase = "abcdefghijklmnopqrstuvwxyz";
		String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String digits = "0123456789";
		String special_characters = "!#@$%^&*()-_=+[]{}?";
		String all_characters = lowercase + digits + uppercase + special_characters;
		
		try {
			// 암호화적으로 안전한 난수 생성(예측 불가 난수 생성)
			SecureRandom random = new SecureRandom();
			
			StringBuilder sb = new StringBuilder();
			
			// 각 문자는 최소 하나 이상 포함
			sb.append(lowercase.charAt(random.nextInt(lowercase.length())));
			sb.append(uppercase.charAt(random.nextInt(uppercase.length())));
			sb.append(digits.charAt(random.nextInt(digits.length())));
			sb.append(special_characters.charAt(random.nextInt(special_characters.length())));
			
			for(int i = sb.length(); i < 10; i++) {
				int index = random.nextInt(all_characters.length());
				
				sb.append(all_characters.charAt(index));
			}
			
			// 문자 섞기
			StringBuilder password = new StringBuilder();
			while (sb.length() > 0) {
				int index = random.nextInt(sb.length());
				password.append(sb.charAt(index));
				sb.deleteCharAt(index);
			}
	        
			String result;
			result = dto.getName() +"님의 새로 발급된 임시 패스워드는 <b> "
					+ password.toString() + " </b> 입니다.<br>"
					+ "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";
			
			Mail mail = new Mail();
			mail.setReceiverEmail(dto.getEmail());
			
			mail.setSenderEmail("alstjd4824@gmail.com");
			mail.setSenderName("공대생");
			mail.setSubject("임시 패스워드 발급");
			mail.setContent(result);
			mail.setContentHtml(true);
			
			// 테이블의 패스워드 변경
			String encPassword = bcryptEncoder.encode(password.toString());
			dto.setPassword(encPassword);
			mapper.updateMemberPassword(dto);
			
			mapper.updateFailureCountReset(dto.getLogin_id());
			
			// 메일 전송
			boolean b = mailService.sendHtmlMail(mail);
			
			if( ! b ) {
				throw new Exception("이메일 전송중 오류가 발생했습니다.");
			}

		} catch (Exception e) {
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

	@Override
	public boolean isPasswordCheck(String login_id, String password) {
		try {
			MemberDto dto = Objects.requireNonNull(findById(login_id));
			
			return bcryptEncoder.matches(password, dto.getPassword());
		} catch (NullPointerException e) {
		} catch (Exception e) {
		}
		
		return false;
	}

}
