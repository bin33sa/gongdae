package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PaymentSubmitDto {
	private long res_no;
    private String method;
    private String paymentKey;
    private int totalAmount;
}
