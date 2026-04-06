package com.gongdae.app.host.service;

import com.gongdae.app.domain.dto.HostDto;

public interface HostService {
   
    void insertHost(HostDto dto, String uploadPath) throws Exception;

  
    void updateHost(HostDto dto, String uploadPath) throws Exception;

  
    boolean checkNicknameDuplicate(String nickname);

   
    HostDto findById(Long memberId) throws Exception;

 
    boolean isPasswordCheck(String loginId, String password) throws Exception;

   
    void deleteProfilePhoto(Long memberId, String profilePhoto, String uploadPath) throws Exception;

   
    HostDto findHostByNameAndEmail(String name, String email) throws Exception;


    HostDto findHostByIdAndNameAndEmail(String loginId, String name, String email) throws Exception;

    
    void sendHostId(HostDto dto) throws Exception;

    
    void sendHostPwd(HostDto dto) throws Exception;
}