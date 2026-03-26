package com.gongdae.app.controller;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gongdae.app.domain.dto.PaymentConfirmDto;
import com.gongdae.app.service.PaymentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/payment/*")
public class PaymentController {
	//private final PaymentService paymentService;
	
	@GetMapping("payment")
	public String paymentForm(Model model) {
		// 받을 정보: space, space_unit, date, start_time, end_time, capacity
				
		try {
			// insert reservation table(if it's already booked, throw error)
			//paymentService.insertReservation(null);
			
			return "";
		} catch (Exception e) {
			model.addAttribute("message", "결제에 실패했습니다.");
		}
		
		return "";
	}
	
	@PostMapping("paymentOk")
	public String paymentOk(final RedirectAttributes rAttr, Model model) {
		try {
			// payment success -> insert payment, update reservation.
			// payment failure -> update reservation, redirect.
			
			return "";
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "";
		
	}
	
	@GetMapping("success")
	public String successPage() {
		return "space/success";
	}
	
	@GetMapping("fail")
	public String failPage() {
		return "space/fail";
	}
	
	@RequestMapping(value = "/confirm")
    public ResponseEntity<?> confirmPayment(@RequestBody PaymentConfirmDto requestBody) throws Exception {
		

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
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", authorizations);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(bodyMap, headers);
        
        // RestTemplate로 POST 호출
        ResponseEntity<String> response = restTemplate.postForEntity(
                "https://api.tosspayments.com/v1/payments/confirm",
                entity,
                String.class
        );
        
        return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
		
	}
	
}
