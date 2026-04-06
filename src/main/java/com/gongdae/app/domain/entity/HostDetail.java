package com.gongdae.app.domain.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "host_detail")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HostDetail {

    @Id
    @Column(name = "member_id")
    private Long id; 

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId 
    @JoinColumn(name = "member_id")
    private Member member;

    private String name;
    
    @Column(unique = true)
    private String nickname;
    
    private String email;
    
    @Column(name = "phone")
    private String tel; 
    
    private String gender;
    
    @Column(name = "profile_image_url")
    private String profileImageUrl;
    
    @Column(length = 1000)
    private String content;
}