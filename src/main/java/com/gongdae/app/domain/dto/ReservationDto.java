package com.gongdae.app.domain.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReservationDto {
	private long res_no;
	private long guest_id;
	private long space_no;
	private long unit_no;
	private String res_date;
	private int start_time;
	private int end_time;
	private String people_count;
	private int total_price;
	private String status;
	private String created_at;
	private String updated_at;
}
