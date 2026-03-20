package com.gongdae.app.admin.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gongdae.app.admin.domain.entity.Board;

public interface BoardRepository extends JpaRepository<Board, Long>{
	List<Board> findByType(String type);
    
    Optional<Board> findByBoardNo(Long boardNo);
    
    List<Board> findByBlock(int block);
    
    long countByMemberId(Long memberId);
}	
