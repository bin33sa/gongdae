<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 나의 회원 등급</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style>

.grade-page{
padding:60px 0;
background:#f8f9ff;
min-height:600px;
}

.grade-container{
width:100%;
max-width:1000px;
margin:auto;
text-align:center;
}

.grade-title{
font-size:30px;
font-weight:700;
margin-bottom:10px;
}

.grade-sub{
color:#777;
margin-bottom:40px;
}

.grade-cards{
display:flex;
justify-content:center;
gap:30px;
margin-bottom:50px;
flex-wrap:wrap;
}

.grade-card{
width:220px;
padding:30px 20px;
border-radius:16px;
background:#fff;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
transition:0.25s;
}

.grade-card.active{
transform:scale(1.05);
border:2px solid #6366f1;
}

.grade-name{
font-size:22px;
font-weight:700;
margin-bottom:10px;
}

.grade-bronze{
color:#cd7f32;
}

.grade-silver{
color:#9ca3af;
}

.grade-gold{
color:#fbbf24;
}

.grade-desc{
font-size:14px;
color:#666;
line-height:1.6;
}

.benefit-box{
margin-top:40px;
background:#fff;
border-radius:16px;
padding:30px;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

.benefit-title{
font-size:22px;
font-weight:700;
margin-bottom:20px;
}

.benefit-list{
text-align:left;
max-width:600px;
margin:auto;
line-height:2;
color:#555;
}

</style>

</head>

<body>

<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<main class="grade-page">

<div class="grade-container">

<div class="grade-title">나의 회원 등급</div>
<div class="grade-sub">공간 이용 횟수와 활동에 따라 회원 등급이 올라갑니다.</div>


<div class="grade-cards">

<div class="grade-card ${memberGrade eq 'BRONZE' ? 'active' : ''}">
<div class="grade-name grade-bronze">BRONZE</div>
<div class="grade-desc">
기본 회원 등급<br>
공간 예약 서비스 이용 가능
</div>
</div>

<div class="grade-card ${memberGrade eq 'SILVER' ? 'active' : ''}">
<div class="grade-name grade-silver">SILVER</div>
<div class="grade-desc">
예약 이용이 늘어난 회원<br>
할인 혜택 제공
</div>
</div>

<div class="grade-card ${memberGrade eq 'GOLD' ? 'active' : ''}">
<div class="grade-name grade-gold">GOLD</div>
<div class="grade-desc">
최상위 VIP 회원<br>
추가 혜택 제공
</div>
</div>

</div>


<div class="benefit-box">

<div class="benefit-title">회원 등급 혜택 안내</div>

<div class="benefit-list">

<strong class="grade-bronze">Bronze</strong><br>
• 기본 공간 예약 서비스 이용 가능<br>
• 일반 이벤트 참여 가능<br><br>

<strong class="grade-silver">Silver</strong><br>
• 공간 예약 시 일부 할인 혜택 제공<br>
• 인기 공간 우선 예약 기회<br><br>

<strong class="grade-gold">Gold</strong><br>
• 프리미엄 공간 할인 혜택<br>
• 이벤트 우선 참여<br>
• 특별 프로모션 제공

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