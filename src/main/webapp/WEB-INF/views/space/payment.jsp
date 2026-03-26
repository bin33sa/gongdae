<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style type="text/css">
.payment-container{
    max-width:1100px;
    margin:auto;
    display:flex;
    gap:40px;
    padding:40px 20px;
}

/* 좌측 예약정보 */

.booking-info{
    flex:1;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 2px 10px rgba(0,0,0,0.08);
}

.space-card{
    display:flex;
    gap:15px;
    margin-bottom:20px;
}

.space-card img{
    width:120px;
    border-radius:8px;
}

.info-row,
.price-row{
    display:flex;
    justify-content:space-between;
    margin:10px 0;
}

.total{
    display:flex;
    justify-content:space-between;
    font-size:18px;
    font-weight:bold;
    margin-top:15px;
}


/* 우측 결제박스 */

.payment-box{
    flex:1;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 2px 10px rgba(0,0,0,0.08);
}

label{
    display:block;
    margin-top:15px;
    font-weight:bold;
}

input{
    width:100%;
    padding:10px;
    margin-top:5px;
    border:1px solid #ddd;
    border-radius:6px;
}

.payment-method{
    margin-top:10px;
}

.payment-method label{
    display:block;
    margin-top:8px;
    font-weight:normal;
}

.pay-btn{
    width:100%;
    margin-top:25px;
    padding:14px;
    font-size:16px;
    border:none;
    border-radius:8px;
    background:#ff5a5f;
    color:white;
    cursor:pointer;
}

.pay-btn:hover{
    background:#ff4146;
}
</style>

</head>
<body>


<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>


<main>

<div class="payment-container">

    <!-- 예약 정보 -->
    <div class="booking-info">
        <h2>예약 정보</h2>

        <div class="space-card">
            <img src="https://via.placeholder.com/120">
            <div>
                <h3>강남 스튜디오</h3>
                <p>서울 강남구</p>
            </div>
        </div>

        <div class="info-row">
            <span>예약 날짜</span>
            <span>2026-03-10</span>
        </div>

        <div class="info-row">
            <span>예약 시간</span>
            <span>14:00 ~ 18:00</span>
        </div>

        <div class="info-row">
            <span>옵션</span>
            <span>빔프로젝터</span>
        </div>

        <hr>

        <div class="price-row">
            <span>공간 이용료</span>
            <span>80,000원</span>
        </div>

        <div class="price-row">
            <span>옵션</span>
            <span>10,000원</span>
        </div>

        <div class="total">
            <span>총 결제금액</span>
            <span>90,000원</span>
        </div>
    </div>


    <!-- 결제 정보 -->
    <div class="payment-box">
        <h2>결제 정보</h2>

        <label>이름</label>
        <input type="text" placeholder="이름 입력">

        <label>이메일</label>
        <input type="email" placeholder="example@email.com">

        <label>전화번호</label>
        <input type="text" placeholder="010-0000-0000">

        <h3>결제 방법</h3>

		<!-- 결제 UI -->
        <div id="payment-method"></div>
		<!-- 이용약관 UI -->
		<div id="agreement"></div>
		<!-- 결재하기 버튼 -->
        <button class="pay-btn" id="payment-button" >결제하기</button>
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
          	value: 5000,
        }
		
		// 결제 위젯 초기화
		const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
		const customerKey = generateRandomString();
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
	            orderId: "4G5Pk49qYHo7WYBeMjck5",
	            orderName: "토스 티셔츠 외 2건",
	            successUrl: window.location.origin + "/payment/success",
	            failUrl: window.location.origin + "/payment/fail",
	            customerEmail: "customer123@gmail.com",
	            customerName: "김토스",
	            customerMobilePhone: "01012341234",
          	});
        });
		
	}
	
	function generateRandomString() {
		return window.btoa(Math.random()).slice(0, 20);
	}
</script>

</body>
</html>