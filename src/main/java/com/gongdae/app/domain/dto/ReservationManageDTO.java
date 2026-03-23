package com.gongdae.app.domain.dto;

import lombok.Data;

@Data
public class ReservationManageDTO {
    
    private long resNo;
    
    private String spaceName;
    private String unitTitle;
    
    private String guestName;
    
    private String resDate;
    private int startTime;
    private int endTime;
    
    private int peopleCount;
    private int totalPrice;
    
    private String status;
    private String createdAt;
}