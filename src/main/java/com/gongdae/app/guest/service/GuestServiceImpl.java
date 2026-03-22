package com.gongdae.app.guest.service;

import java.security.SecureRandom;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.GuestDto;
import com.gongdae.app.mail.Mail;
import com.gongdae.app.mail.MailService;
import com.gongdae.app.mapper.GuestMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GuestServiceImpl implements GuestService {
	private final GuestMapper mapper;
	private final StorageService storageService;
	private final MailService mailService;
	private final PasswordEncoder bcryptEncoder;
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertGuest(GuestDto dto, String uploadPath) throws Exception {
		try {
			if(! dto.getSelectFile().isEmpty()) {
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setProfile_photo(saveFilename);
			}
			
			String encPassword = bcryptEncoder.encode(dto.getPassword());
			dto.setPassword(encPassword);
			
			mapper.insertGuest(dto);
			
			// 권한저장
			dto.setAuthority("GUEST");
			mapper.insertAuthority(dto);
			
		} catch (Exception e) {
			log.info("insertGuest: ", e);
			
			throw e;
		}
	}
	
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateGuest(GuestDto dto, String uploadPath) throws Exception {
		try {
			// 업로드한 파일이 존재한 경우
			if(dto.getSelectFile() != null && ! dto.getSelectFile().isEmpty()) {
				if(! dto.getProfile_photo().isBlank()) {
					storageService.deleteFile(uploadPath, dto.getProfile_photo());
				}
				
				String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
				dto.setProfile_photo(saveFilename);
			}			
			
			boolean bPwdUpdate = ! isPasswordCheck(dto.getLogin_id(), dto.getPassword());
			if( bPwdUpdate ) {
				// 패스워드가 변경된 경우만 member 테이블의 패스워드 변경
				String encPassword = bcryptEncoder.encode(dto.getPassword());
				dto.setPassword(encPassword);
				
				mapper.updateGuestPassword(dto);
			}
			mapper.updateGuestDetail(dto);
			
		} catch (Exception e) {
			log.info("updateGuest : ", e);
			
			throw e;
		}
	}

	@Override
	public GuestDto findById(Long member_id) {
		GuestDto dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findById(member_id));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Override
	public GuestDto findById(String login_id) {
		GuestDto dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findByLoginId(login_id));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}
	
	@Override
	public GuestDto findGuestByNickname(String nickname) {
		GuestDto dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByNickname(nickname));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByNickname : ", e);
		}
		
		return dto;
	}
	
	@Override
	public GuestDto findGuestByNameAndEmail(Map<String, Object> map) {
		GuestDto dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByNameAndEmail(map));
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("findByNameAndEmail : ", e);
		}
		
		return dto;
	}

	@Override
	public GuestDto findGuestByIdAndNameAndEmail(Map<String, Object> map) {
		GuestDto dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findByLoginIdAndNameAndEmail(map));
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
	public void sendGuestId(GuestDto dto) throws Exception {
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
	public void sendGuestPwd(GuestDto dto) throws Exception {
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
			mapper.updateGuestPassword(dto);
			
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
	public List<GuestDto> listFindMember(Map<String, Object> map) {
		
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
	public boolean isPasswordCheck(String login_id, String password) {
		try {
			GuestDto dto = Objects.requireNonNull(findById(login_id));
			
			return bcryptEncoder.matches(password, dto.getPassword());
		} catch (NullPointerException e) {
		} catch (Exception e) {
		}
		
		return false;
	}

}
