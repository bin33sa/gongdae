package com.gongdae.app.admin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gongdae.app.admin.domain.dto.ReportManageDto;
import com.gongdae.app.admin.domain.dto.SiteManageDto;
import com.gongdae.app.admin.service.SiteManageService;
import com.gongdae.app.common.FileManager;
import com.gongdae.app.common.MyUtil;
import com.gongdae.app.common.PaginateUtil;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/site/*")
@Slf4j
public class AdminSiteController {

    private final SiteManageService service;
    private final PaginateUtil paginateUtil;
    private final MyUtil myUtil;
    private final FileManager fileManager;

    @GetMapping("report")
    public String listReport(@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "reporter") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "status", defaultValue = "") String status,
            HttpServletRequest req,
            Model model) throws Exception {

        try {
            int size = 10;
            int total_page = 0;
            int dataCount = 0;

            kwd = myUtil.decodeUrl(kwd);

            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("status", status);

            dataCount = service.dataCountReport(map);
            if (dataCount != 0) {
                total_page = paginateUtil.pageCount(dataCount, size);
            }

            current_page = Math.min(current_page, total_page);
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            List<ReportManageDto> list = service.listReport(map);
            
            String cp = req.getContextPath();
            String listUrl = cp + "/admin/site/report";
            String query = "schType=" + schType + "&status=" + status;
            if (!kwd.isEmpty()) {
                query += "&kwd=" + myUtil.encodeUrl(kwd);
            }
            listUrl += "?" + query;

            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            model.addAttribute("list", list);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("status", status);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);

        } catch (Exception e) {
            log.info("listReport : ", e);
        }

        return "admin/site/report";
    }

    @PostMapping("updateReportStatus")
    @ResponseBody
    public ResponseEntity<?> updateReportStatus(@RequestParam Map<String, Object> paramMap) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            paramMap.put("adminId", info.getMember_id());

            service.updateReportStatus(paramMap);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("updateReportStatus : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("상태 변경에 실패했습니다.");
        }
    }

    @GetMapping("banner")
    public String bannerManage(Model model) {
        try {
            SiteManageDto mainBanner = service.findBanner("MAIN_BANNER");
            SiteManageDto popup = service.findBanner("POPUP");

            model.addAttribute("mainBanner", mainBanner);
            model.addAttribute("popup", popup);

        } catch (Exception e) {
            log.info("bannerManage : ", e);
        }

        return "admin/site/banner";
    }

    @PostMapping("updateBanner")
    public String updateBanner(SiteManageDto dto, HttpSession session) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            dto.setAdminId(info.getMember_id());

            String root = session.getServletContext().getRealPath("/");
            String pathname = root + "uploads" + File.separator + "banner";
            
            MultipartFile mf = dto.getSelectFile();
            if (mf != null && !mf.isEmpty()) {
                SiteManageDto existingBanner = service.findBanner(dto.getType());
                if (existingBanner != null && existingBanner.getSaveFilename() != null) {
                    fileManager.deletePath(pathname + File.separator + existingBanner.getSaveFilename());
                }
                
                if (!fileManager.isDirectoryExist(pathname)) {
                    fileManager.createAllDirectories(pathname);
                }
                
                String originalFilename = mf.getOriginalFilename();
                String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String saveFilename = fileManager.generateUniqueFileName(pathname, extension);
                
                mf.transferTo(new File(pathname, saveFilename));
                
                dto.setSaveFilename(saveFilename);
                dto.setOriginalFilename(originalFilename);
            }

            SiteManageDto existingBanner = service.findBanner(dto.getType());
            if (existingBanner == null) {
                service.insertBanner(dto);
            } else {
                service.updateBanner(dto);
            }

        } catch (Exception e) {
            log.info("updateBanner : ", e);
        }

        return "redirect:/admin/site/banner";
    }

    @PostMapping("deleteBanner")
    @ResponseBody
    public ResponseEntity<?> deleteBanner(@RequestParam(name = "type") String type, HttpSession session) {
        try {
            SiteManageDto dto = service.findBanner(type);
            
            if (dto != null && dto.getSaveFilename() != null) {
                String root = session.getServletContext().getRealPath("/");
                String pathname = root + "uploads" + File.separator + "banner";
                fileManager.deletePath(pathname + File.separator + dto.getSaveFilename());
            }

            service.deleteBanner(type);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("deleteBanner : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("배너 초기화에 실패했습니다.");
        }
    }

    @GetMapping("component")
    public String componentManage(Model model) {
        try {
            List<SiteManageDto> list = service.listComponent();
            model.addAttribute("list", list);

        } catch (Exception e) {
            log.info("componentManage : ", e);
        }

        return "admin/site/component";
    }

    @PostMapping("updateComponent")
    @ResponseBody
    public ResponseEntity<?> updateComponent(SiteManageDto dto) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            dto.setAdminId(info.getMember_id());

            service.updateComponent(dto);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("updateComponent : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("설정 저장에 실패했습니다.");
        }
    }
}