package com.gongdae.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.gongdae.app.admin.domain.entity.Board;
import com.gongdae.app.admin.mapper.BoardManageMapper;
import com.gongdae.app.admin.repository.BoardRepository;
import com.gongdae.app.common.StorageService;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardManageServiceImpl implements BoardManageService {
    
    private final BoardManageMapper mapper;
    private final BoardRepository boardRepository;
    private final StorageService storageService;
    
    @Transactional
    @Override
    public void insertBoard(Board dto, String uploadPath) throws Exception {
        try {
            if(dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
                String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
                dto.setSaveFilename(saveFilename);
                dto.setOriginalFilename(dto.getSelectFile().getOriginalFilename());
            }

            boardRepository.save(dto);
        } catch (Exception e) {
            log.info("insertBoard : ", e);
            throw e; 
        }
    }
    
    @Transactional
    @Override
    public void updateBoard(Board dto, String uploadPath) throws Exception {
        try {
            if(dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
                if(dto.getSaveFilename() != null && !dto.getSaveFilename().isBlank()) {
                    storageService.deleteFile(uploadPath, dto.getSaveFilename());
                }
                
                String saveFilename = storageService.uploadFileToServer(dto.getSelectFile(), uploadPath);
                dto.setSaveFilename(saveFilename);
                dto.setOriginalFilename(dto.getSelectFile().getOriginalFilename());
            }           

            boardRepository.save(dto);
        } catch (Exception e) {
            log.info("updateBoard : ", e);
            throw e;
        }
    }
    
    @Transactional
    @Override
    public void deleteBoard(long boardNo, String uploadPath) throws Exception {
        try {
            Board dto = boardRepository.findById(boardNo).orElseThrow();
            
            if (dto.getSaveFilename() != null) {
                storageService.deleteFile(uploadPath, dto.getSaveFilename());
            }

            boardRepository.deleteById(boardNo);
        } catch (Exception e) {
            log.info("deleteBoard : ", e);
            throw e;
        }
    }

    @Override
    public List<Board> listBoard(Map<String, Object> map) {
        return mapper.listBoard(map);
    }

    @Override
    public int dataCount(Map<String, Object> map) {
        return mapper.dataCount(map);
    }

    @Override
    public Board findById(long boardNo) {
        return mapper.findById(boardNo);
    }
    
    @Transactional
    @Override
    public void updateHitCount(long boardNo) throws Exception {
        try {
            Board dto = boardRepository.findById(boardNo).orElseThrow();
            dto.setViewCount(dto.getViewCount() + 1);
        } catch (Exception e) {
            log.info("updateHitCount : ", e);
            
            throw e;
        }
    }
    
    @Override
	public Board findByPrev(Map<String, Object> map) {
		Board dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			log.info("findByPrev : ", e);
			
			throw e;
		}

		return dto;
	}

	@Override
	public Board findByNext(Map<String, Object> map) {
		Board dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			log.info("findByNext : ", e);
			
			throw e;
		}

		return dto;
	}
}