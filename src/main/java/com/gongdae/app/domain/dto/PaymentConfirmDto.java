package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PaymentConfirmDto {
	private String orderId;
    private String amount;
    private String paymentKey;
	
}
