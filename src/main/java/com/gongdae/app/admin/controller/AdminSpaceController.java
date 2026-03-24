package com.gongdae.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gongdae.app.admin.domain.dto.SpaceManageDto;
import com.gongdae.app.admin.service.AdminSpaceManageService;
import com.gongdae.app.common.MyUtil;
import com.gongdae.app.common.PaginateUtil;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.security.LoginMemberUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/spaces/*")
@Slf4j
public class AdminSpaceController {
    
    private final AdminSpaceManageService service;
    private final PaginateUtil paginateUtil;
    private final MyUtil myUtil;

    @GetMapping("list")
    public String listSpace(@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "spaceName") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            @RequestParam(name = "status", defaultValue = "") String status,
            @RequestParam(name = "isPremium", defaultValue = "") String isPremium,
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
            map.put("isPremium", isPremium);

            dataCount = service.dataCountSpace(map);
            if (dataCount != 0) {
                total_page = paginateUtil.pageCount(dataCount, size);
            }

            current_page = Math.min(current_page, total_page);
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            List<SpaceManageDto> list = service.listSpace(map);
            
            String cp = req.getContextPath();
            String listUrl = cp + "/admin/spaces/list";
            String query = "schType=" + schType + "&status=" + status + "&isPremium=" + isPremium;
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
            model.addAttribute("isPremium", isPremium);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);

        } catch (Exception e) {
            log.info("listSpace : ", e);
        }
        
        return "admin/spaces/list";
    }

    @GetMapping("approval")
    public String approvalList(HttpServletRequest req, Model model) throws Exception {

        try {
            Map<String, Object> spaceMap = new HashMap<>();
            spaceMap.put("status", "PENDING");
            spaceMap.put("offset", 0);
            spaceMap.put("size", 100);

            List<SpaceManageDto> spaceList = service.listSpace(spaceMap);
            int spaceCount = service.dataCountSpace(spaceMap);

            Map<String, Object> premiumMap = new HashMap<>();
            premiumMap.put("premiumStatus", "PENDING");
            premiumMap.put("offset", 0);
            premiumMap.put("size", 100);

            List<SpaceManageDto> premiumList = service.listPremium(premiumMap);
            int premiumCount = service.dataCountPremium(premiumMap);

            model.addAttribute("spaceList", spaceList);
            model.addAttribute("spaceCount", spaceCount);
            model.addAttribute("premiumList", premiumList);
            model.addAttribute("premiumCount", premiumCount);

        } catch (Exception e) {
            log.info("approvalList : ", e);
        }
        
        return "admin/spaces/approval";
    }

    @GetMapping("premium")
    public String premiumList(@RequestParam(name = "page", defaultValue = "1") int current_page,
                              @RequestParam(name = "premiumStatus", defaultValue = "ACTIVE") String premiumStatus,
                              HttpServletRequest req, Model model) throws Exception {
        try {
            int size = 10;
            int dataCount = 0;
            
            Map<String, Object> map = new HashMap<>();
            map.put("premiumStatus", premiumStatus);

            dataCount = service.dataCountPremium(map);
            int total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            List<SpaceManageDto> list = service.listPremium(map);

            String listUrl = req.getContextPath() + "/admin/spaces/premium?premiumStatus=" + premiumStatus;
            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            model.addAttribute("list", list);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("paging", paging);
            model.addAttribute("premiumStatus", premiumStatus);
            
        } catch (Exception e) {
            log.info("premiumList : ", e);
        }
        
        return "admin/spaces/premium";
    }

    @GetMapping("detail/{spaceNo}")
    public String spaceDetail(@PathVariable("spaceNo") long spaceNo, 
                              @RequestParam(name = "page", defaultValue = "1") String page,
                              @RequestParam(name = "from", defaultValue = "list") String from,
                              Model model) throws Exception {
        try {
            SpaceManageDto dto = service.findByIdSpace(spaceNo);
            if (dto == null) {
                return "redirect:/admin/spaces/" + from + "?page=" + page;
            }
            
            List<SpaceManageDto> imageList = service.listSpaceImage(spaceNo);
            List<SpaceManageDto> unitList = service.listSpaceUnit(spaceNo);

            model.addAttribute("dto", dto);
            model.addAttribute("imageList", imageList);
            model.addAttribute("unitList", unitList);
            model.addAttribute("page", page);
            model.addAttribute("from", from);

        } catch (Exception e) {
            log.info("spaceDetail : ", e);
        }
        
        return "admin/spaces/detail";
    }

    @PostMapping("updateStatus")
    @ResponseBody
    public ResponseEntity<?> updateStatus(@RequestParam Map<String, Object> paramMap) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            paramMap.put("adminId", info.getMember_id());
            
            service.updateSpaceStatus(paramMap);
            
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("updateStatus : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Fail");
        }
    }

    @PostMapping("approvePremium")
    @ResponseBody
    public ResponseEntity<?> approvePremium(@RequestParam Map<String, Object> paramMap) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            paramMap.put("adminId", info.getMember_id());
            
            service.approvePremium(paramMap);
            
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("approvePremium : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Fail");
        }
    }

    @PostMapping("cancelPremium")
    @ResponseBody
    public ResponseEntity<?> cancelPremium(@RequestParam Map<String, Object> paramMap) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            paramMap.put("adminId", info.getMember_id());
            
            service.cancelPremium(paramMap);
            
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("cancelPremium : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Fail");
        }
    }

    @PostMapping("insertPremiumForce")
    @ResponseBody
    public ResponseEntity<?> insertPremiumForce(@RequestParam Map<String, Object> paramMap) {
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            paramMap.put("adminId", info.getMember_id());
            
            service.insertPremiumForce(paramMap);
            
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.info("insertPremiumForce : ", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Fail");
        }
    }
}