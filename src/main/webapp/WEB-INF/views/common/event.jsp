<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항 목록</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
</head>
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<style>
.event-page{
padding:60px 0;
background:#fff7f9;
}

.event-header{
text-align:center;
margin-bottom:50px;
}

.event-header h2{
font-size:32px;
font-weight:700;
margin-bottom:10px;
}

.event-header p{
color:#777;
}

/* 카드 그리드 */

.event-grid{
display:grid;
grid-template-columns:repeat(4,1fr);
gap:28px;
}


/* 카드 */

.event-card{
background:#fff;
border-radius:16px;
overflow:hidden;
border:1px solid #ffe0e6;
cursor:pointer;
transition:all .2s;
}

.event-card:hover{
transform:translateY(-6px);
box-shadow:0 10px 25px rgba(255,107,138,0.18);
}


/* 이미지 */

.event-img{
height:200px;
overflow:hidden;
}

.event-img img{
width:100%;
height:100%;
object-fit:cover;
}


/* 카드 내용 */

.event-body{
padding:18px;
}

.event-body h3{
font-size:16px;
font-weight:600;
margin-bottom:8px;
line-height:1.4;
}

.event-period{
font-size:13px;
color:#888;
}


/* 페이지네이션 */

.event-pagination{
text-align:center;
margin-top:60px;
}

.event-pagination span{
font-size:20px;
margin:0 10px;
cursor:pointer;
font-weight:600;
}

.event-pagination span:hover{
color:#ff6b8a;
}

</style>

</head>

<body>
<div class="event-page">

<div class="container">

<div class="event-header">
<h2>이벤트</h2>
<p>공대생에서 진행 중인 다양한 이벤트를 확인하세요</p>
</div>


<div class="event-grid">

<!-- 이벤트 카드 -->
<div class="event-card">

<div class="event-img">
<img src="/uploads/sample-event.jpg">
</div>

<div class="event-body">

<h3>신규 가입 5000포인트 지급 이벤트</h3>

<div class="event-period">
2026.03.01 ~ 2026.03.31
</div>

</div>

</div>


<div class="event-card">

<div class="event-img">
<img src="/uploads/sample-event.jpg">
</div>

<div class="event-body">

<h3>공간 예약 첫 이용 할인 이벤트</h3>

<div class="event-period">
2026.02.10 ~ 2026.04.10
</div>

</div>

</div>


<div class="event-card">

<div class="event-img">
<img src="/uploads/sample-event.jpg">
</div>

<div class="event-body">

<h3>리뷰 작성 포인트 지급 이벤트</h3>

<div class="event-period">
2026.03.01 ~ 2026.05.01
</div>

</div>

</div>


<div class="event-card">

<div class="event-img">
<img src="/uploads/sample-event.jpg">
</div>

<div class="event-body">

<h3>공대생 오픈 기념 이벤트</h3>

<div class="event-period">
2026.01.01 ~ 2026.04.01
</div>

</div>

</div>

</div>


<!-- 페이지네이션 -->

<div class="event-pagination">

<span>1</span>
<span>2</span>
<span>3</span>
<span>4</span>

</div>

</div>

</div>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>


</html>