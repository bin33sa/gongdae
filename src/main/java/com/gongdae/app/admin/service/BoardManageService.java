package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import com.gongdae.app.admin.domain.entity.Board;

public interface BoardManageService {
	public void insertBoard(Board dto, String uploadPath) throws Exception;
    public void updateBoard(Board dto, String uploadPath) throws Exception;
    public void deleteBoard(long board_no, String uploadPath) throws Exception;

    public List<Board> listBoard(Map<String, Object> map);
    public int dataCount(Map<String, Object> map);
    public Board findById(long board_no);
    
    public void updateHitCount(long board_no) throws Exception;
    public Board findByPrev(Map<String, Object> map);
    public Board findByNext(Map<String, Object> map);
}
