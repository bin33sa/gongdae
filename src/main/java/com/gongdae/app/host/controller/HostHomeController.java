package com.gongdae.app.host.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.common.PaginateUtil;
import com.gongdae.app.domain.dto.HostSalesDTO;
import com.gongdae.app.domain.dto.ReservationManageDTO;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceInquiryDTO;
import com.gongdae.app.domain.dto.SpaceManageDTO;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.HostMainService;
import com.gongdae.app.service.ReservationManageService;
import com.gongdae.app.service.SpaceInquiryService;
import com.gongdae.app.service.SpaceManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/host/*")
public class HostHomeController {
	
	private final ReservationManageService reservationService;
    private final SpaceManageService spaceService;
    private final SpaceInquiryService inquiryService;
	private final HostMainService hostMainService;
	private final PaginateUtil paginateUtil;
    @GetMapping("main/prelogin")
    public String prelogin() {
        return "host/main/prelogin";
    }
    
    @GetMapping("main/home")
    public String hostMain(Model model) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        
       
        HostSalesDTO salesDto = hostMainService.getSalesSummary(info.getMember_id());
        model.addAttribute("active", "home");
       
        model.addAttribute("sales", salesDto);
        
        return "host/main/home";
    }
  
    
   
   

    
    @GetMapping("menu/store")
    public String store(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            Model model) throws Exception {
        
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        long hostId = info.getMember_id();
        int size = 6; 

       
        int dataCount = spaceService.dataCountSpace(hostId);

      
        int total_page = paginateUtil.pageCount(dataCount, size);
        if (current_page > total_page) {
            current_page = total_page;
        }

        
        int offset = (current_page - 1) * size;
        if(offset < 0) offset = 0;

       
        Map<String, Object> map = new HashMap<>();
        map.put("hostId", hostId);
        map.put("offset", offset);
        map.put("size", size);

        
        List<SpaceManageDTO> list = spaceService.listSpace(map);

        
        String paging = paginateUtil.pagingMethod(current_page, total_page, "searchStore");

       
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("size", size);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("active", "store");

        return "host/menu/store";
    }

   
    @GetMapping("menu/qna")
    public String qna(@RequestParam(name = "inquiryNo", required = false, defaultValue = "0") long inquiryNo, Model model) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        long hostId = info.getMember_id();

        
        List<SpaceInquiryDTO> list = inquiryService.listInquiryByHost(hostId);
        SpaceInquiryDTO detail = null;

       
        if (inquiryNo != 0) {
            detail = inquiryService.findInquiryById(inquiryNo);
        } else if (!list.isEmpty()) {
            detail = inquiryService.findInquiryById(list.get(0).getInquiryNo());
        }

        model.addAttribute("list", list);
        model.addAttribute("detail", detail);
        model.addAttribute("active", "qna");
        return "host/menu/qna";
    }

   
    @PostMapping("inquiry/reply")
    public String replySubmit(SpaceInquiryDTO dto) throws Exception {
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        try {
            SpaceInquiryDTO verify = inquiryService.findInquiryById(dto.getInquiryNo());
           
            if(verify != null && verify.getHostId() == info.getMember_id()) {
                dto.setHostId(info.getMember_id());
                inquiryService.updateInquiryReply(dto);
            }
        } catch (Exception e) {
            log.error("답변 등록 에러", e);
        }
        return "redirect:/host/menu/qna?inquiryNo=" + dto.getInquiryNo();
    }


   
    @GetMapping("menu/space")
    public String space(Model model) {
        model.addAttribute("active", "space");
        return "host/menu/space";
    }

    @GetMapping("menu/reservation")
    public String reservationList(
            @RequestParam(name = "page", defaultValue = "1") int current_page, 
            Model model) throws Exception {
        
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        long hostId = info.getMember_id();

        int size = 10;
        
        
        int dataCount = reservationService.dataCountReservation(hostId); 
        
  
        int total_page = paginateUtil.pageCount(dataCount, size);
        
       
        if (current_page > total_page) {
            current_page = total_page;
        }

       
        int offset = (current_page - 1) * size;
        if(offset < 0) offset = 0;

       
        Map<String, Object> map = new HashMap<>();
        map.put("hostId", hostId);
        map.put("offset", offset);
        map.put("size", size);

       
        List<ReservationManageDTO> list = reservationService.listReservation(map); 

        
        String listUrl = "/host/menu/reservation";
        String paging = paginateUtil.pagingUrl(current_page, total_page, listUrl);

       
        model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("size", size);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging); 
        model.addAttribute("active", "reservation");

        return "host/menu/reservation";
    }


    @GetMapping("menu/sales")
    public String sales(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "spaceNo", defaultValue = "0") long spaceNo, 
            @RequestParam(name = "startDate", defaultValue = "") String startDate, 
            @RequestParam(name = "endDate", defaultValue = "") String endDate,
            Model model) throws Exception {
        
        SessionInfo info = LoginMemberUtil.getSessionInfo();
        long hostId = info.getMember_id();
        int size = 10;

        Map<String, Object> map = new HashMap<>();
        map.put("hostId", hostId);
        map.put("spaceNo", spaceNo);
        map.put("startDate", startDate);
        map.put("endDate", endDate);

       
        int dataCount = reservationService.dataCountSales(map); 
        int total_page = paginateUtil.pageCount(dataCount, size);
        if (current_page > total_page) current_page = total_page;

        int offset = (current_page - 1) * size;
        if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("size", size);

       
        List<ReservationManageDTO> list = reservationService.listSales(map);
        String paging = paginateUtil.pagingMethod(current_page, total_page, "searchSales");

       
        HostSalesDTO summary = hostMainService.getSalesSummary(hostId);
        
       
        List<SpaceManageDTO> spaceList = spaceService.listSpaceDrop(hostId); 

        model.addAttribute("list", list);
        model.addAttribute("summary", summary);    
        model.addAttribute("spaceList", spaceList); 
        
    
        model.addAttribute("spaceNo", spaceNo);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        
        model.addAttribute("page", current_page);
        model.addAttribute("paging", paging);
        model.addAttribute("active", "sales");

        return "host/menu/sales";
    }
    
    @PostMapping("premium/toggle")
    public String premiumToggle(
            @RequestParam(name = "spaceNo") long spaceNo, 
            @RequestParam(name = "currentPremium", defaultValue = "N") String currentPremium,
            RedirectAttributes rttr) {
        
        try {
            SessionInfo info = LoginMemberUtil.getSessionInfo();
            spaceService.togglePremium(spaceNo, info.getMember_id(), currentPremium);
            
            String msg = "";
            if ("N".equals(currentPremium)) msg = "프리미엄 광고 신청이 접수되었습니다. (관리자 승인 대기)";
            else if ("P".equals(currentPremium)) msg = "프리미엄 광고 신청이 취소되었습니다.";
            else if ("Y".equals(currentPremium)) msg = "프리미엄 광고가 해지되었습니다.";
            
            rttr.addFlashAttribute("message", msg);
        } catch (Exception e) {
            log.error("프리미엄 토글 실패", e);
        }
        return "redirect:/host/menu/store";
    }
    
    
}