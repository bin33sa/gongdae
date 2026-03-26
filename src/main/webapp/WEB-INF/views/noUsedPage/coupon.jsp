<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 나의 쿠폰</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style>

.coupon-page{
padding:60px 0;
background:#f8f9ff;
min-height:600px;
}

.coupon-container{
max-width:1000px;
margin:auto;
}

.coupon-title{
font-size:30px;
font-weight:700;
text-align:center;
margin-bottom:10px;
}

.coupon-sub{
text-align:center;
color:#777;
margin-bottom:40px;
}

.coupon-count{
background:#fff;
border-radius:16px;
padding:25px;
text-align:center;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
margin-bottom:40px;
}

.coupon-count span{
font-size:34px;
font-weight:700;
color:#6366f1;
}

.coupon-list{
display:flex;
flex-direction:column;
gap:20px;
}

.coupon-card{
display:flex;
justify-content:space-between;
align-items:center;
background:#fff;
border-radius:16px;
padding:25px;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

.coupon-left{
flex:1;
}

.coupon-name{
font-size:18px;
font-weight:700;
margin-bottom:8px;
}

.coupon-desc{
font-size:14px;
color:#666;
}

.coupon-expire{
font-size:13px;
color:#999;
margin-top:6px;
}

.coupon-right{
text-align:right;
}

.coupon-discount{
font-size:26px;
font-weight:700;
color:#f59e0b;
}

.coupon-condition{
font-size:13px;
color:#777;
margin-top:5px;
}

</style>

</head>

<body>

<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<main class="coupon-page">

<div class="coupon-container">

<div class="coupon-title">나의 쿠폰</div>
<div class="coupon-sub">보유한 쿠폰을 확인하고 예약 시 사용할 수 있습니다.</div>


<div class="coupon-count">
보유 쿠폰<br>
<span>3 장</span>
</div>


<div class="coupon-list">


<div class="coupon-card">

<div class="coupon-left">
<div class="coupon-name">첫 예약 할인 쿠폰</div>
<div class="coupon-desc">공간 예약 시 사용 가능한 할인 쿠폰</div>
<div class="coupon-expire">유효기간 : 2026-04-30 까지</div>
</div>

<div class="coupon-right">
<div class="coupon-discount">3,000원</div>
<div class="coupon-condition">5만원 이상 사용</div>
</div>

</div>


<div class="coupon-card">

<div class="coupon-left">
<div class="coupon-name">봄맞이 이벤트 쿠폰</div>
<div class="coupon-desc">이벤트 참여 고객 대상 할인 쿠폰</div>
<div class="coupon-expire">유효기간 : 2026-05-15 까지</div>
</div>

<div class="coupon-right">
<div class="coupon-discount">5%</div>
<div class="coupon-condition">최대 5,000원</div>
</div>

</div>


<div class="coupon-card">

<div class="coupon-left">
<div class="coupon-name">VIP 회원 쿠폰</div>
<div class="coupon-desc">골드 회원 전용 쿠폰</div>
<div class="coupon-expire">유효기간 : 2026-06-30 까지</div>
</div>

<div class="coupon-right">
<div class="coupon-discount">10,000원</div>
<div class="coupon-condition">10만원 이상 사용</div>
</div>

</div>


</div>

</div>

</main>

<footer>
<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>