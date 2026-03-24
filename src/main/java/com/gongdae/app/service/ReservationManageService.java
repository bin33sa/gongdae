package com.gongdae.app.service;

import java.util.List;
import com.gongdae.app.domain.dto.ReservationManageDTO;

public interface ReservationManageService {
    List<ReservationManageDTO> listReservation(long hostId) throws Exception;
}