package com.gongdae.app.host.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.domain.dto.HostDto;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.host.service.HostService;
import com.gongdae.app.security.LoginMemberUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/host/*")
public class HostController {
    
    private final HostService service;
    
    @Value("${file.upload-root}/host")
    private String uploadPath;

    @GetMapping("signup")
    public String signupForm(Model model) {
        model.addAttribute("mode", "signup");
        
        return "host/member/signup";
    }
    
    @PostMapping("signup")
    public String signupSubmit(HostDto dto, final RedirectAttributes rAttr, Model model) {
        try {
            service.insertHost(dto, uploadPath);
            
            StringBuilder sb = new StringBuilder();
            sb.append(dto.getName()).append("님의 호스트 가입이 정상적으로 처리되었습니다.<br>");
            sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

            rAttr.addFlashAttribute("title", "호스트 가입");
            rAttr.addFlashAttribute("message", sb.toString());

            return "redirect:/complete";
            
        } catch (DuplicateKeyException e) {
            model.addAttribute("mode", "signup");
            model.addAttribute("message", "아이디 혹은 닉네임 중복으로 회원가입이 실패했습니다.");
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("mode", "signup");
            model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
        } catch (Exception e) {
            model.addAttribute("mode", "signup");
            model.addAttribute("message", "회원가입이 실패했습니다.");
            log.error("Host signup error: ", e);
        }

        return "host/member/signup";
    }
    
    @PostMapping("update")
    public String updateSubmit(HostDto dto, final RedirectAttributes rAttr, Model model) {
        StringBuilder sb = new StringBuilder();
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            dto.setMember_id(info.getMember_id());
            
            service.updateHost(dto, uploadPath);
            
            if (dto.getProfile_photo() != null && !dto.getProfile_photo().isBlank()) {
                info.setAvatar(dto.getProfile_photo());
            }
            
            sb.append(dto.getName()).append(" 호스트님의 정보가 정상적으로 변경되었습니다.<br>");
            sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
                
        } catch (Exception e) {
            sb.append(dto.getName()).append(" 호스트님의 정보 변경이 실패했습니다.<br>");
            sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
            log.error("Host update error: ", e);
        }
        
        rAttr.addFlashAttribute("title", "호스트 정보 수정");
        rAttr.addFlashAttribute("message", sb.toString());
        return "redirect:/complete";
    }

    @PostMapping("nicknameCheck")
    public ResponseEntity<?> handleNicknameCheck(@RequestParam(name = "nickname") String nickname) {
        String p = "false";
        try {
            boolean isDuplicate = service.checkNicknameDuplicate(nickname);
            if (!isDuplicate) {
                p = "true";
            }
        } catch (Exception e) {
            log.error("Nickname check error: ", e);
        }
        
        return ResponseEntity.ok(Map.of("passed", p));
    }
    
    @GetMapping("findId")
    public String findIdForm() {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        if (info != null) {
            return "redirect:/";
        }
        return "host/member/findId";
    }
    
    @PostMapping("findId")
    public String findIdSubmit(@RequestParam(name = "name") String name,
                               @RequestParam(name = "email") String email,
                               RedirectAttributes reAttr,
                               Model model) {
        try {
            HostDto dto = service.findHostByNameAndEmail(name, email);
            
            if (dto == null || dto.getEnabled() == 0) {
                model.addAttribute("message", "등록된 호스트 정보가 없습니다.");
                return "host/member/findId";
            }
            
            service.sendHostId(dto);
            
            StringBuilder sb = new StringBuilder();
            sb.append("호스트님의 이메일로 아이디를 전송했습니다.<br>");
            
            reAttr.addFlashAttribute("title", "아이디 찾기");
            reAttr.addFlashAttribute("message", sb.toString());
            reAttr.addFlashAttribute("btnText", "로그인");
            reAttr.addFlashAttribute("path", "host/member/login");
            
            return "redirect:/complete";
            
        } catch (Exception e) {
            model.addAttribute("message", "이메일 전송에 실패했습니다.");
            log.error("Find ID error: ", e);
        }
        
        return "host/member/findId";
    }
    
    @GetMapping("findPwd")
    public String findPwdForm() {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        if (info != null) {
            return "redirect:/";
        }
        return "host/member/findPwd";
    }
    
    @PostMapping("findPwd")
    public String findPwdSubmit(@RequestParam(name = "login_id") String login_id,
                                @RequestParam(name = "name") String name,
                                @RequestParam(name = "email") String email,
                                RedirectAttributes reAttr,
                                Model model) {
        try {
            HostDto dto = service.findHostByIdAndNameAndEmail(login_id, name, email);
            
            if (dto == null || dto.getEnabled() == 0) {
                model.addAttribute("message", "등록된 호스트 정보가 없습니다.");
                return "host/member/findPwd";
            }
            
            service.sendHostPwd(dto);
            
            StringBuilder sb = new StringBuilder();
            sb.append("호스트님의 이메일로 임시패스워드를 전송했습니다.<br>");
            sb.append("로그인 후 패스워드를 변경하시기 바랍니다.<br>");
            
            reAttr.addFlashAttribute("title", "패스워드 찾기");
            reAttr.addFlashAttribute("message", sb.toString());
            reAttr.addFlashAttribute("btnText", "로그인");
            reAttr.addFlashAttribute("path", "host/member/login");
            
            return "redirect:/complete";
            
        } catch(Exception e) {
            model.addAttribute("message", "이메일 전송에 실패했습니다.");
            log.error("Find PWD error: ", e);
        }
        
        return "host/member/findPwd";
    }

    @GetMapping("pwd")
    public String pwdForm(@RequestParam(name = "dropout", required = false) String dropout, Model model) {
        if (dropout == null) {
            model.addAttribute("mode", "update");
        } else {
            model.addAttribute("mode", "dropout");
        }
        return "host/member/pwd";
    }
    
    @PostMapping("pwd")
    public String pwdSubmit(@RequestParam(name = "password") String password,
                            @RequestParam(name = "mode") String mode,
                            final RedirectAttributes reAttr,
                            Model model) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            HostDto dto = Objects.requireNonNull(service.findById(info.getMember_id()));

            boolean bPwd = service.isPasswordCheck(info.getLogin_id(), password);
            
            if (!bPwd) {
                model.addAttribute("mode", mode);
                model.addAttribute("message", "패스워드가 일치하지 않습니다.");
                return "host/member/pwd";
            }

            if (mode.equals("dropout")) {
                LoginMemberUtil.logout();
                
                StringBuilder sb = new StringBuilder();
                sb.append(dto.getName()).append(" 호스트님의 탈퇴 처리가 정상적으로 완료되었습니다.<br>");
                sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

                reAttr.addFlashAttribute("title", "호스트 탈퇴");
                reAttr.addFlashAttribute("message", sb.toString());

                return "redirect:/complete";
            }

            model.addAttribute("dto", dto);
            model.addAttribute("mode", "update");
            
            return "host/member/signup";
            
        } catch (NullPointerException e) {
            LoginMemberUtil.logout();
        } catch (Exception e) {
            log.error("PWD check error: ", e);
        }
        
        return "redirect:/";
    }
    
    @DeleteMapping("deleteProfile")
    public ResponseEntity<?> deleteProfilePhoto(@RequestParam(name = "profile_photo") String profile_photo) {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        
        try {
            if (!profile_photo.isBlank()) {
                service.deleteProfilePhoto(info.getMember_id(), profile_photo, uploadPath);
                info.setAvatar(null);
            }
            return ResponseEntity.ok(Map.of("state", "true"));
        } catch (Exception e) {
            log.error("Profile deletion error: ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("state", "false", "message", e.getMessage()));
        }
    }
}