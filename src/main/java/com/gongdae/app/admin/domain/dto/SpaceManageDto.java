package com.gongdae.app.admin.domain.dto;

import org.springframework.web.multipart.MultipartFile;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SpaceManageDto {
    private long spaceNo;
    private long hostId;
    private long categoryNo;
    private long adminId;
    private String spaceName;
    private String bizRegNum;
    private String address;
    private String detailAddr;
    private String region;
    private String bankName;
    private String accountNo;
    private String accountHolder;
    private String createdAt;
    private String updatedAt;
    private String isPremium;
    private String status;

    private String hostLoginId;
    private String hostName;
    private String categoryName;

    private int pricePerHour;

    private String hostEmail;
    private String hostPhone;

    private int minHours;
    private int cancelLimitHr;
    private int cleaningFee;

    private String imageUrl;
    private long unitNo;
    private String unitTitle;
    private int unitPrice;
    private int unitCapacity;

    private long premiumNo;
    private String premiumStatus;
    private String appliedAt;
    private String canceledAt;

    private String adminMemo;
    private String saveFilename;
    private String originalFilename;
    private MultipartFile selectFile;
}