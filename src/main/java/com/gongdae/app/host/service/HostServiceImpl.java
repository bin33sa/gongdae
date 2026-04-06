package com.gongdae.app.host.service;

import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.HostDto;
import com.gongdae.app.domain.entity.HostDetail;
import com.gongdae.app.domain.entity.Member;
import com.gongdae.app.mail.Mail;
import com.gongdae.app.mail.MailService;
import com.gongdae.app.repository.HostDetailRepository;
import com.gongdae.app.repository.MemberRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;

@Service
@RequiredArgsConstructor
@Slf4j
public class HostServiceImpl implements HostService {

    private final MemberRepository memberRepository;
    private final HostDetailRepository hostDetailRepository;
    private final StorageService storageService;
    private final PasswordEncoder bcryptEncoder;
    private final MailService mailService; 

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void insertHost(HostDto dto, String uploadPath) throws Exception {
        String saveFilename = null;
        if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
            saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
        }

        Member member = Member.builder()
                .loginId(dto.getLogin_id())
                .password(bcryptEncoder.encode(dto.getPassword()))
                .build();
        member.getAuthorities().add("HOST"); 

        HostDetail hostDetail = HostDetail.builder()
                .name(dto.getName())
                .nickname(dto.getNickname())
                .email(dto.getEmail())
                .tel(dto.getTel())
                .gender(dto.getGender())
                .content(dto.getContent()) 
                .profileImageUrl(saveFilename)
                .build();

        member.setHostDetail(hostDetail);
        memberRepository.save(member);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateHost(HostDto dto, String uploadPath) throws Exception {
        Member member = memberRepository.findById(dto.getMember_id())
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 호스트입니다."));
        HostDetail hostDetail = member.getHostDetail();

      
        if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
            if (hostDetail.getProfileImageUrl() != null && !hostDetail.getProfileImageUrl().isBlank()) {
                storageService.deleteFile(uploadPath, hostDetail.getProfileImageUrl());
            }
            String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
            hostDetail.setProfileImageUrl(saveFilename);
        }

       
        if (dto.getPassword() != null && !dto.getPassword().isBlank()) {
            if (!bcryptEncoder.matches(dto.getPassword(), member.getPassword())) {
                member.setPassword(bcryptEncoder.encode(dto.getPassword()));
            }
        }

       
        hostDetail.setEmail(dto.getEmail());
        hostDetail.setTel(dto.getTel());
        hostDetail.setContent(dto.getContent());
    }

    @Transactional(readOnly = true)
    @Override
    public boolean checkNicknameDuplicate(String nickname) {
        return hostDetailRepository.existsByNickname(nickname);
    }

    @Transactional(readOnly = true)
    @Override
    public HostDto findById(Long memberId) throws Exception {
        Member member = memberRepository.findById(memberId).orElse(null);
        if (member == null) return null;
        return convertToDto(member);
    }

    @Transactional(readOnly = true)
    @Override
    public boolean isPasswordCheck(String loginId, String password) throws Exception {
        Member member = memberRepository.findByLoginId(loginId).orElse(null);
        if (member == null) return false;
        return bcryptEncoder.matches(password, member.getPassword());
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteProfilePhoto(Long memberId, String profilePhoto, String uploadPath) throws Exception {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new IllegalArgumentException("존재하지 않는 회원입니다."));
        
        if (profilePhoto != null && !profilePhoto.isBlank()) {
            storageService.deleteFile(uploadPath, profilePhoto);
        }
        
        member.getHostDetail().setProfileImageUrl(null); 
    }

    @Transactional(readOnly = true)
    @Override
    public HostDto findHostByNameAndEmail(String name, String email) throws Exception {
        HostDetail detail = hostDetailRepository.findByNameAndEmail(name, email).orElse(null);
        if (detail == null) return null;
        return convertToDto(detail.getMember());
    }

    @Transactional(readOnly = true)
    @Override
    public HostDto findHostByIdAndNameAndEmail(String loginId, String name, String email) throws Exception {
        HostDetail detail = hostDetailRepository.findByMember_LoginIdAndNameAndEmail(loginId, name, email).orElse(null);
        if (detail == null) return null;
        return convertToDto(detail.getMember());
    }

    @Override
    public void sendHostId(HostDto dto) throws Exception {
        String content = dto.getName() + " 호스트님의 아이디는 <b> " + dto.getLogin_id() + " </b> 입니다.";
        
        Mail mail = new Mail();
        mail.setReceiverEmail(dto.getEmail());
        mail.setSenderEmail("no-reply@gongdae.com"); 
        mail.setSenderName("공대생 파트너스");
        mail.setSubject("[공대생] 호스트 계정 아이디 안내");
        mail.setContent(content);
        mail.setContentHtml(true);
        
        boolean isSent = mailService.sendHtmlMail(mail);
        if (!isSent) {
            throw new Exception("이메일 전송 중 오류가 발생했습니다.");
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void sendHostPwd(HostDto dto) throws Exception {
      
        String lowercase = "abcdefghijklmnopqrstuvwxyz";
        String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String digits = "0123456789";
        String special_characters = "!#@$%^&*()-_=+[]{}?";
        String all_characters = lowercase + digits + uppercase + special_characters;
        
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        
        sb.append(lowercase.charAt(random.nextInt(lowercase.length())));
        sb.append(uppercase.charAt(random.nextInt(uppercase.length())));
        sb.append(digits.charAt(random.nextInt(digits.length())));
        sb.append(special_characters.charAt(random.nextInt(special_characters.length())));
        
        for (int i = sb.length(); i < 10; i++) {
            sb.append(all_characters.charAt(random.nextInt(all_characters.length())));
        }
        
        String tempPassword = sb.toString(); 

        
        Member member = memberRepository.findById(dto.getMember_id())
                .orElseThrow(() -> new Exception("회원 정보를 찾을 수 없습니다."));
        member.setPassword(bcryptEncoder.encode(tempPassword));
        member.setFailureCnt(0); 
       

   
        String content = dto.getName() + " 호스트님의 임시 패스워드는 <b> " + tempPassword + " </b> 입니다.<br>"
                       + "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";
        
        Mail mail = new Mail();
        mail.setReceiverEmail(dto.getEmail());
        mail.setSenderEmail("여기입력@.com");
        mail.setSenderName("공대생 파트너스");
        mail.setSubject("[공대생] 호스트 임시 패스워드 발급");
        mail.setContent(content);
        mail.setContentHtml(true);
        
        boolean isSent = mailService.sendHtmlMail(mail);
        if (!isSent) {
            throw new Exception("이메일 전송 중 오류가 발생했습니다.");
        }
    }


    private HostDto convertToDto(Member member) {
        HostDetail detail = member.getHostDetail();
        HostDto dto = new HostDto();
        
        dto.setMember_id(member.getId());
        dto.setLogin_id(member.getLoginId());
        dto.setEnabled(member.getEnabled());
      

        if (detail != null) {
            dto.setName(detail.getName());
            dto.setNickname(detail.getNickname());
            dto.setEmail(detail.getEmail());
            dto.setTel(detail.getTel());
            dto.setGender(detail.getGender());
            dto.setProfile_photo(detail.getProfileImageUrl());
            dto.setContent(detail.getContent());
        }
        return dto;
    }
}