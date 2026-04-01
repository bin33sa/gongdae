package com.gongdae.app.controller;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gongdae.app.domain.dto.GuestDto;
import com.gongdae.app.domain.dto.PaymentConfirmDto;
import com.gongdae.app.domain.dto.PaymentSubmitDto;
import com.gongdae.app.domain.dto.ReservationDto;
import com.gongdae.app.domain.dto.SessionInfo;
import com.gongdae.app.domain.dto.SpaceUnitDTO;
import com.gongdae.app.guest.service.GuestService;
import com.gongdae.app.security.LoginMemberUtil;
import com.gongdae.app.service.PaymentService;
import com.gongdae.app.service.SpaceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/payment/*")
public class PaymentController {
	private final GuestService guestService;
	private final SpaceService spaceService;
	private final PaymentService paymentService;

	@PostMapping("reservation")
	public String reservation(ReservationDto dto,
			final RedirectAttributes rAttr) {
		
		try {
			// insert reservation table(if it's already booked, throw error)
			// redirect
			SessionInfo info = LoginMemberUtil.getSessionInfo();
			dto.setGuest_id(info.getMember_id());
			SpaceUnitDTO unitDto = spaceService.findSpaceUnitById(dto.getUnit_no());
			int total_price = (dto.getEnd_time() - dto.getStart_time()) * unitDto.getPricePerHour();
			
			dto.setTotal_price(total_price);
			paymentService.insertReservation(dto);
			
			return "redirect:/payment/" + dto.getRes_no();
		} catch (Exception e) {
			rAttr.addFlashAttribute("message", "예약이 실패했습니다.");
		}
		
		return "redirect:/space/" + dto.getSpace_no();
	}
	
	@GetMapping("{reservationId}")
	public String paymentForm(@PathVariable("reservationId") long id,
			Model model) throws Exception {
		
		try {
			ReservationDto reservationDto = paymentService.getReservationById(id);
			GuestDto guestDto = guestService.findById(reservationDto.getGuest_id());
			guestDto.setTel(guestDto.getTel().replace("-", ""));
			
			// 날짜 형식 변환
			DateTimeFormatter inputFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			DateTimeFormatter outputFmt = DateTimeFormatter.ofPattern("yyyy. MM. dd. (E)", Locale.KOREAN);
			
			reservationDto.setRes_date(LocalDate.parse(reservationDto.getRes_date(), inputFmt).format(outputFmt));
			
			model.addAttribute("guest", guestDto);
			model.addAttribute("space", spaceService.findSpaceById(reservationDto.getSpace_no()));
			model.addAttribute("spaceUnit", spaceService.findSpaceUnitById(reservationDto.getUnit_no()));
			model.addAttribute("reservInfo", reservationDto);
			
		} catch (Exception e) {
		}
		
		return "space/payment";
	}
	
	@GetMapping("success")
	public String successPage(@RequestParam("res_no") long res_no, Model model) {
		
		try {
			ReservationDto reservationDto = paymentService.getReservationById(res_no);
			
			// 날짜 형식 변환
			DateTimeFormatter inputFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			DateTimeFormatter outputFmt = DateTimeFormatter.ofPattern("yyyy. MM. dd. (E)", Locale.KOREAN);
			
			reservationDto.setRes_date(LocalDate.parse(reservationDto.getRes_date(), inputFmt).format(outputFmt));
			
			model.addAttribute("space", spaceService.findSpaceById(reservationDto.getSpace_no()));
			model.addAttribute("spaceUnit", spaceService.findSpaceUnitById(reservationDto.getUnit_no()));
			model.addAttribute("reservInfo", reservationDto);
		} catch (Exception e) {
		}
		
		return "space/success";
	}
	
	@GetMapping("fail")
	public String failPage() {
		return "space/fail";
	}
	
	@RequestMapping(value = "/confirm")
    public ResponseEntity<?> confirmPayment(@RequestBody PaymentConfirmDto requestBody) throws Exception {

		long res_no = requestBody.getRes_no();
        String orderId = requestBody.getOrderId();
        String paymentKey = requestBody.getPaymentKey();
        String amount = requestBody.getAmount();
       
        // 토스페이먼츠 API 호출용 map
        Map<String, Object> bodyMap = new HashMap<>();
        bodyMap.put("orderId", orderId);
        bodyMap.put("paymentKey", paymentKey);
        bodyMap.put("amount", amount);

        // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);

        // RestTemplate 사용
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", authorizations);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(bodyMap, headers);
        
        ResponseEntity<String> response = null;
        try {
        	// RestTemplate로 POST 호출
        	response = restTemplate.postForEntity(
        			"https://api.tosspayments.com/v1/payments/confirm",
        			entity,
        			String.class
        			);
        	
        	ObjectMapper mapper = new ObjectMapper();
        	JsonNode jsonNode = mapper.readTree(response.getBody());
        	
        	System.out.println(jsonNode);
        
        	PaymentSubmitDto dto = new PaymentSubmitDto();
        	dto.setRes_no(res_no);
        	dto.setMethod(jsonNode.get("method").asText());
        	dto.setPaymentKey(jsonNode.get("paymentKey").asText());
        	dto.setTotalAmount(jsonNode.get("totalAmount").asInt());
        	
        	paymentService.insertPayment(dto);
        	
        	return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
        } catch (Exception e) {
        	return ResponseEntity.status(response.getStatusCode()).body(response.getBody());        	
        }
        
        
        
		
	}
	
}
