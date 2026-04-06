<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 확인 및 결제 - 공대생</title>
    
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/variable/pretendardvariable.css");
        
        :root {
            --primary-color: #E53935; 
            --bg-color: #f4f6f8;
            --card-border-radius: 20px;
        }
        
        body { 
            font-family: 'Pretendard Variable', Pretendard, sans-serif; 
            background-color: var(--bg-color); 
            color: #222; 
        }

        /* 메인 컨테이너 중앙 집중 */
        .checkout-main-container {
            max-width: 840px; 
            margin: 0 auto;
        }

        /* 섹션 카드 스타일 */
        .checkout-card {
            background: #fff;
            border-radius: var(--card-border-radius);
            padding: 40px;
            margin-bottom: 30px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }
        
        .card-title { 
            font-size: 1.4rem; 
            font-weight: 800; 
            margin-bottom: 30px;
            color: #111;
            display: flex;
            align-items: center;
            gap: 10px;
        }

     
        .form-control, .form-select {
            padding: 16px;
            border-radius: 12px;
            border: 1px solid #ddd;
            font-size: 1rem;
            background-color: #fff;
        }
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(229, 57, 53, 0.1);
        }
        .form-label {
            font-weight: 700;
            font-size: 0.95rem;
            color: #444;
            margin-bottom: 8px;
        }

        /* 공간 정보 요약바 */
        .space-info-bar {
            background-color: #f8f9fa;
            border-radius: 16px;
            padding: 20px;
            border: 1px solid #eaeaea;
        }

        /* 하단 최종 결제 카드 전용 스타일 */
        .final-summary-card {
            background: #fff;
            border-radius: var(--card-border-radius);
            padding: 40px;
            border: 2px solid var(--primary-color);
            box-shadow: 0 10px 30px rgba(229, 57, 53, 0.08);
            margin-bottom: 50px;
        }

        /* 결제 수단 선택 라디오 버튼 커스텀 */
        .pay-method-option {
            border: 2px solid #eee;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.2s;
            height: 100%;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .form-check-input:checked + .pay-method-option {
            border-color: var(--primary-color);
            background-color: rgba(229, 57, 53, 0.03);
        }
        .pay-method-icon {
            font-size: 1.5rem;
            color: #555;
        }
        .form-check-input:checked + .pay-method-option .pay-method-icon {
            color: var(--primary-color);
        }

        /* 버튼 스타일 */
        .btn-pay-submit {
            background-color: var(--primary-color);
            border: none;
            color: white;
            padding: 20px;
            font-size: 1.2rem;
            font-weight: 800;
            border-radius: 16px;
            width: 100%;
            transition: background 0.2s;
        }
        .btn-pay-submit:hover { background-color: #c62828; }
        
        .btn-cancel {
            background-color: #eee;
            color: #555;
            padding: 15px;
            border-radius: 12px;
            font-weight: 600;
            border: none;
            width: 100%;
        }

        /* 요약 텍스트 행 */
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            font-size: 1.1rem;
            color: #444;
        }
        /* 계산식 전용 스타일 */
        .calc-formula {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 0.95rem;
            color: #666;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>

<main class="container my-5 py-3">
    <div class="checkout-main-container">
        
        <div class="mb-5 text-center">
            <h1 class="fw-bold" style="font-size: 2.5rem; letter-spacing: -1px;">확인 및 결제</h1>
            <p class="text-muted fs-5 mt-2">예약 정보를 확인하고 결제를 진행해 주세요.</p>
        </div>

        <div class="checkout-card">
            <h4 class="card-title"><i class="bi bi-shop text-danger"></i>예약 공간 정보</h4>
            
            <div class="space-info-bar d-flex align-items-center gap-4 mb-4">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=150&h=150&auto=format&fit=crop" class="rounded-3" style="width:100px; height:100px; object-fit:cover;" alt="공간 이미지">
                <div class="flex-grow-1">
                    <div class="badge bg-white text-danger border border-danger mb-2 fw-bold">${space.category}</div>
                    <div class="fw-bold fs-4 text-dark mb-1">${space.name}</div>
                    <div class="text-secondary"><i class="bi bi-geo-alt me-1"></i>${space.address}</div>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-md-6">
                    <div class="p-3 border rounded-3 bg-light h-100">
                        <div class="text-muted small mb-1 fw-bold">선택 일정</div>
                        <div class="fw-bold text-dark fs-5 mb-1">${reservInfo.res_date}</div>
                        <div class="text-secondary small">${reservInfo.start_time}:00 ~ ${reservInfo.end_time }:00 (총 ${reservInfo.end_time - reservInfo.start_time}시간)</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 border rounded-3 bg-light h-100">
                        <div class="text-muted small mb-1 fw-bold">예약 인원</div>
                        <div class="fw-bold text-dark fs-5 mb-1">총 ${reservInfo.people_count}명</div>
                        <div class="text-secondary small">최대 8인</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="checkout-card">
            <h4 class="card-title"><i class="bi bi-person-circle text-danger"></i>예약자 정보</h4>
            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">이름</label>
                    <input type="text" class="form-control" value="${guest.name}" readonly style="background-color: #f8f9fa; color:#777;">
                </div>
                <div class="col-md-6">
                    <label class="form-label">휴대폰 번호 <span class="text-danger">*</span></label>
                    <input type="tel" class="form-control" value="${guest.tel}" placeholder="숫자만 입력">
                </div>
            </div>
        </div>

        <div class="checkout-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="card-title m-0"><i class="bi bi-p-circle text-danger"></i>포인트 할인</h4>
                <span class="text-muted fw-bold">보유 포인트: <span class="text-dark">5,000</span> P</span>
            </div>
            
            <div class="input-group input-group-lg">
                <input type="number" class="form-control text-end font-monospace" value="0" min="0" placeholder="0">
                <span class="input-group-text bg-white fw-bold">P</span>
                <button class="btn btn-outline-dark px-4 fw-bold" type="button" style="border-radius: 0 12px 12px 0;">전액사용</button>
            </div>
            <p class="text-muted small mt-2 mb-0"><i class="bi bi-info-circle me-1"></i>최소 1,000P부터 100P 단위로 사용 가능합니다.</p>
        </div>

        <div class="checkout-card">
            <!-- 결제 UI -->
       		<div id="payment-method"></div>
       		<!-- 이용약관 UI -->
			<div id="agreement"></div>
        </div>

        <div class="final-summary-card">
            <div class="row align-items-center">
                <div class="col-md-7 pe-md-5">
                    
                    <div class="calc-formula">
                        <span>시간당 <fmt:formatNumber value="${spaceUnit.pricePerHour}" type="number" groupingUsed="true"/>원 <i class="bi bi-x mx-1"></i> 총 ${reservInfo.end_time - reservInfo.start_time}시간</span>
                        <span class="fw-bold text-dark"><fmt:formatNumber value="${reservInfo.total_price}" type="number" groupingUsed="true"/>원</span>
                    </div>

                    <div class="summary-row mt-3">
                        <span class="fw-bold">공간 대여료</span>
                        <span class="fw-bold text-dark"><fmt:formatNumber value="${reservInfo.total_price}" type="number" groupingUsed="true"/>원</span>
                    </div>
                    <div class="summary-row text-danger">
                        <span>포인트 할인</span>
                        <span class="fw-bold">- 0원</span>
                    </div>
                    
                    <hr class="my-3">
                    
                    <div class="d-flex justify-content-between align-items-end mb-2">
                        <span class="fw-bold text-dark fs-5">최종 결제 금액</span>
                        <span class="fw-bold" style="font-size: 2.2rem; color: var(--primary-color); line-height: 1;">
                            <fmt:formatNumber value="${reservInfo.total_price}" type="number" groupingUsed="true"/>원
                        </span>
                    </div>
                    <div class="text-end text-muted small mt-1">
                        결제 완료 시 <span class="fw-bold text-dark"><fmt:formatNumber value="${reservInfo.total_price/10}" type="number" groupingUsed="true"/>P</span> 적립 예정
                    </div>
                </div>
                
                <div class="col-md-5 mt-4 mt-md-0 pl-md-4 border-start">
                    <button type="submit" class="btn btn-pay-submit mb-3" id="payment-button">
                        결제하기
                    </button>
                    <button type="button" class="btn btn-cancel" onclick="history.back();">
                        예약 취소
                    </button>
                </div>
            </div>
        </div>

    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

<!-- SDK 추가 -->
<script src="https://js.tosspayments.com/v2/standard"></script>

<script type="text/javascript">
	main();
	
	async function main() {
		const button = document.getElementById("payment-button");
		
		const amount = {
          	currency: "KRW",
          	value: ${reservInfo.total_price},
        }
		
		// 결제 위젯 초기화
		const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
		const customerKey = "guest${guest.member_id}";
		const tossPayments = TossPayments(clientKey);
        const widgets = tossPayments.widgets({
         	customerKey,
        });

     	// ------ 주문의 결제 금액 설정 ------
       	await widgets.setAmount(amount);

        await Promise.all([
          	// ------  결제 UI 렌더링 ------
          	widgets.renderPaymentMethods({
            	selector: "#payment-method",
            	variantKey: "DEFAULT",
          	}),
          	// ------  이용약관 UI 렌더링 ------
          	widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);
        
     	// ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        button.addEventListener("click", async function () {
          	await widgets.requestPayment({
	            orderId: randomString(8), //"order${reservInfo.res_no}",
	            orderName: "${space.name}, ${spaceUnit.title}",
	            successUrl: window.location.origin + "/payment/success?res_no=${reservInfo.res_no}",
	            failUrl: window.location.origin + "/payment/fail?res_no=${reservInfo.res_no}",
	            customerEmail: "${guest.email}",
	            customerName: "${guest.name}",
	            customerMobilePhone: "${guest.tel}",
          	});
        });
		
	}
	
	function randomString(length) {
		const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		let result = '';
		
		for (let i = 0; i < length; i++) {
		  result += chars.charAt(Math.floor(Math.random() * chars.length));
		}
		
		return result;
	}
	
</script>

</body>
</html>