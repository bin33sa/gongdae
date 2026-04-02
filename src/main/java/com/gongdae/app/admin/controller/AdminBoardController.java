package com.gongdae.app.admin.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gongdae.app.admin.domain.entity.Board;
import com.gongdae.app.admin.service.BoardManageService;
import com.gongdae.app.common.FileManager;
import com.gongdae.app.common.MyUtil;
import com.gongdae.app.common.StorageService;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/bbs/{type}") 
@Slf4j
public class AdminBoardController {
    
    private final BoardManageService service;
    private final StorageService storageService;
    private final FileManager fileManager;
    private final MyUtil myUtil; 

    @Value("${file.upload-root}")
    private String uploadRoot;

    @GetMapping("list")
    public String list(@PathVariable("type") String type,
                       @RequestParam(name = "page", defaultValue = "1") int current_page,
                       @RequestParam(name = "schType", defaultValue = "all") String schType,
                       @RequestParam(name = "kwd", defaultValue = "") String kwd,
                       Model model) {
        try {
            kwd = myUtil.decodeUrl(kwd);
            int size = 10;
            int offset = (current_page - 1) * size;
            Map<String, Object> map = new HashMap<>();
            map.put("type", type.toUpperCase()); 
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("offset", offset);
            map.put("size", size);

            int dataCount = service.dataCount(map);
            List<Board> list = service.listBoard(map);

            model.addAttribute("list", list);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("type", type.toUpperCase()); 
            model.addAttribute("pathType", type.toLowerCase()); 
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            model.addAttribute("page", current_page);
        } catch (Exception e) {
            log.info("list error: ", e); 
        }
        return "admin/bbs/list"; 
    }

    @GetMapping("write")
    public String writeForm(@PathVariable("type") String type, Model model) {
        model.addAttribute("mode", "write");
        model.addAttribute("type", type.toUpperCase());
        model.addAttribute("pathType", type.toLowerCase());
        return "admin/bbs/write"; 
    }

    @PostMapping("write")
    public String writeSubmit(@PathVariable("type") String type,
                              Board dto,
                              @RequestParam(value = "selectFile", required = false) MultipartFile selectFile) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        dto.setMemberId(info.getMember_id()); 
        dto.setType(type.toUpperCase());

        String uploadPath = uploadRoot + File.separator + type.toLowerCase();
        
        if (selectFile != null && !selectFile.isEmpty()) {
            String saveFilename = storageService.uploadFileToServer(selectFile, uploadPath);
            dto.setSaveFilename(saveFilename);
            dto.setOriginalFilename(selectFile.getOriginalFilename());
        }

        service.insertBoard(dto, uploadPath); 

        return "redirect:/admin/bbs/" + type.toLowerCase() + "/list";
    }

    @GetMapping("article/{boardNo}")
    public String article(@PathVariable("type") String type,
                          @PathVariable("boardNo") long boardNo,
                          @RequestParam(name = "page", defaultValue = "1") String page,
                          @RequestParam(name = "schType", defaultValue = "all") String schType,
                          @RequestParam(name = "kwd", defaultValue = "") String kwd,
                          Model model) {
        String query = "page=" + page;
        try {
            kwd = myUtil.decodeUrl(kwd);
            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
            }
            
            service.updateHitCount(boardNo);
            
            Board dto = service.findById(boardNo);
            if (dto == null) return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;

            dto.setContent(myUtil.sanitize(dto.getContent()));

            Map<String, Object> map = new HashMap<>();
            map.put("type", type.toUpperCase());
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("boardNo", boardNo);

            Board prevDto = service.findByPrev(map);
            Board nextDto = service.findByNext(map);

            model.addAttribute("dto", dto);
            model.addAttribute("prevDto", prevDto);
            model.addAttribute("nextDto", nextDto);
            model.addAttribute("type", type.toUpperCase());
            model.addAttribute("pathType", type.toLowerCase());
            model.addAttribute("page", page);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            model.addAttribute("query", query);
        } catch (Exception e) {
            log.info("article error: ", e);
        }
        return "admin/bbs/article"; 
    }

    @GetMapping("download")
    public ResponseEntity<?> download(@PathVariable("type") String type, 
                                      @RequestParam(name = "boardNo") long boardNo) {
        Board dto = service.findById(boardNo);
        String uploadPath = uploadRoot + File.separator + "admin" + File.separator + type.toLowerCase();
        return storageService.downloadFile(uploadPath, dto.getSaveFilename(), dto.getOriginalFilename());
    }

    @GetMapping("update/{boardNo}")
    public String updateForm(@PathVariable("type") String type,
                             @PathVariable("boardNo") long boardNo,
                             @RequestParam(name = "page", defaultValue = "1") String page,
                             @RequestParam(name = "schType", defaultValue = "all") String schType,
                             @RequestParam(name = "kwd", defaultValue = "") String kwd,
                             Model model) throws Exception {
        String query = "page=" + page;
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            kwd = myUtil.decodeUrl(kwd);
            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
            }

            Board dto = Objects.requireNonNull(service.findById(boardNo));
            
            if (dto.getMemberId() != info.getMember_id()) {
                return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
            }
          
            model.addAttribute("dto", dto);
            model.addAttribute("mode", "update");
            model.addAttribute("page", page);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            model.addAttribute("query", query);
            model.addAttribute("type", type.toUpperCase());
            model.addAttribute("pathType", type.toLowerCase());
            
            return "admin/bbs/write";
        } catch (NullPointerException e) {
        } catch (Exception e) {
            log.info("updateForm error : ", e);
        }
        return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
    }

    @PostMapping("update")
    public String updateSubmit(@PathVariable("type") String type,
                               Board dto,
                               @RequestParam(value = "selectFile", required = false) MultipartFile selectFile,
                               @RequestParam(name = "page", defaultValue = "1") String page,
                               @RequestParam(name = "schType", defaultValue = "all") String schType,
                               @RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
        String query = "page=" + page;
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            kwd = myUtil.decodeUrl(kwd);
            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
            }

            dto.setMemberId(info.getMember_id());
            dto.setType(type.toUpperCase());

            String uploadPath = uploadRoot + File.separator + type.toLowerCase();
            
            if (selectFile != null && !selectFile.isEmpty()) {
                if(dto.getSaveFilename() != null && !dto.getSaveFilename().isBlank()) {
                    storageService.deleteFile(uploadPath, dto.getSaveFilename());
                }
                String saveFilename = storageService.uploadFileToServer(selectFile, uploadPath);
                dto.setSaveFilename(saveFilename);
                dto.setOriginalFilename(selectFile.getOriginalFilename());
            }

            service.updateBoard(dto, uploadPath);
        } catch (Exception e) {
            log.info("updateSubmit error : ", e);
        }
        return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
    }

    @GetMapping("deleteFile/{boardNo}")
    public String deleteFile(@PathVariable("type") String type,
                             @PathVariable("boardNo") long boardNo,
                             @RequestParam(name = "page", defaultValue = "1") String page,
                             @RequestParam(name = "schType", defaultValue = "all") String schType,
                             @RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
        String query = "page=" + page;
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            kwd = myUtil.decodeUrl(kwd);
            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
            }

            Board dto = Objects.requireNonNull(service.findById(boardNo));
            
            if (dto.getMemberId() != info.getMember_id()) {
                return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
            }
            
            if (dto.getSaveFilename() != null && !dto.getSaveFilename().isBlank()) {
                String uploadPath = uploadRoot + File.separator + "admin" + File.separator + type.toLowerCase();
                storageService.deleteFile(uploadPath, dto.getSaveFilename());
                
                dto.setSaveFilename("");
                dto.setOriginalFilename("");
                service.updateBoard(dto, uploadPath);
            }
            
            return "redirect:/admin/bbs/" + type.toLowerCase() + "/update/" + boardNo + "?" + query;
        } catch (NullPointerException e) {
        } catch (Exception e) {
            log.info("deleteFile error : ", e);
        }
        return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
    }

    @PostMapping("delete")
    public String delete(@PathVariable("type") String type,
                         @RequestParam(name = "boardNo") long boardNo,
                         @RequestParam(name = "page", defaultValue = "1") String page,
                         @RequestParam(name = "schType", defaultValue = "all") String schType,
                         @RequestParam(name = "kwd", defaultValue = "") String kwd) throws Exception {
        String query = "page=" + page;
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            kwd = myUtil.decodeUrl(kwd);
            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + myUtil.encodeUrl(kwd);
            }
            
            Board dto = service.findById(boardNo);
            if (dto == null || dto.getMemberId() != info.getMember_id()) {
                return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
            }
            
            String uploadPath = uploadRoot + File.separator + "admin" + File.separator + type.toLowerCase();
            service.deleteBoard(boardNo, uploadPath); 
        } catch (Exception e) {
            log.info("delete error : ", e);
        }
        return "redirect:/admin/bbs/" + type.toLowerCase() + "/list?" + query;
    }

    @PostMapping("imageUpload")
    public void imageUpload(@PathVariable("type") String type,
                            @RequestParam("upload") MultipartFile uploadFile,
                            HttpServletRequest req,
                            HttpServletResponse resp) throws Exception {
        resp.setContentType("application/json; charset=utf-8");
        PrintWriter out = resp.getWriter();
        try {
            String uploadPath = uploadRoot + File.separator + "editor";
            
            if(!fileManager.isDirectoryExist(uploadPath)) {
            	fileManager.createAllDirectories(uploadPath);
            }
            
            String saveFilename = storageService.uploadFileToServer(uploadFile, uploadPath);
            String fileUrl = req.getContextPath() + "/uploads/editor/" + saveFilename;
            
            out.print("{\"url\":\"" + fileUrl + "\"}");
        } catch (Exception e) {
            log.error("Image upload error", e);
            out.print("{\"error\":{\"message\":\"업로드 실패\"}}");
        } finally {
            out.close();
        }
    }
}