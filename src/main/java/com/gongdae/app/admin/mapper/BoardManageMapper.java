package com.gongdae.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gongdae.app.admin.domain.entity.Board;

@Mapper
public interface BoardManageMapper {
	public List<Board> listBoard(Map<String, Object> map);

    public int dataCount(Map<String, Object> map);

    public Board findById(long board_no);

    public Board findByPrev(Map<String, Object> map);
    public Board findByNext(Map<String, Object> map);
    
    public void updateHitCount(long board_no);
}
