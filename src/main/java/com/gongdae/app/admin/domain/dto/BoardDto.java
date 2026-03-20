package com.gongdae.app.admin.domain.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class BoardDto {
	private long board_no;
    private Long member_id;
    private String type;     
    private String title;
    private String content;
    private int view_count;
    private int block;       
    
    private String created_at;
    private String updated_at;
    private String start_date; 
    private String end_date;   
    
    private String save_filename;
    private String original_filename;
    private MultipartFile selectFile; 

    private String adminName;    
    private String adminLoginId; 
    private int replyCount;      
    
    private List<Long> nums;     
}
