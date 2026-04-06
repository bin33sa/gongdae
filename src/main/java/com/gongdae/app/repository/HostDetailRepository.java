package com.gongdae.app.repository;

import com.gongdae.app.domain.entity.HostDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface HostDetailRepository extends JpaRepository<HostDetail, Long> {
    boolean existsByNickname(String nickname);
    
   
    Optional<HostDetail> findByNameAndEmail(String name, String email);
    
    
    Optional<HostDetail> findByMember_LoginIdAndNameAndEmail(String loginId, String name, String email);
}