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

        <div class="payment-method">
            <label>
                <input type="radio" name="pay"> 신용카드
            </label>

            <label>
                <input type="radio" name="pay"> 카카오페이
            </label>

            <label>
                <input type="radio" name="pay"> 네이버페이
            </label>
        </div>

        <button class="pay-btn">결제하기</button>
    </div>

</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>