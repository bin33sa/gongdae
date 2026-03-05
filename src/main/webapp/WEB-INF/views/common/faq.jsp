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

.faq-page{
padding:60px 0;
background:#fff7f9;
}

.faq-page .faq-header{
text-align:center;
margin-bottom:40px;
}

.faq-page .faq-header h2{
font-size:30px;
font-weight:700;
margin-bottom:10px;
}

.faq-page .faq-header p{
color:#777;
}

/* 아코디언 카드 */

.faq-page .accordion-item{
border:1px solid #ffd6de;
border-radius:14px;
margin-bottom:12px;
overflow:hidden;
background:#fff;
}

/* 질문 버튼 */

.faq-page .accordion-button{
background:#fff;
font-weight:600;
padding:18px 20px;
border:none;
box-shadow:none;
}

.faq-page .accordion-button:not(.collapsed){
background:#fff1f4;
color:#ff6b8a;
}

/* hover */

.faq-page .accordion-button:hover{
background:#fff1f4;
}

/* 답변 */

.faq-page .accordion-body{
background:#fff7f9;
padding:20px;
color:#444;
line-height:1.6;
}

/* 화살표 색 */

.faq-page .accordion-button::after{
filter:hue-rotate(-20deg);
}

</style>

</head>

<body>


<div class="faq-page">

<div class="container">

<div class="faq-header">
<h2>자주 묻는 질문</h2>
<p>서비스 이용 중 궁금한 내용을 확인해보세요</p>
</div>

<div class="accordion" id="faqAccordion">

<!-- 질문 1 -->
<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq1">

공간 예약은 어떻게 하나요?

</button>

</h2>

<div id="faq1"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

원하는 공간을 선택한 후 예약 날짜와 시간을 선택하면 예약이 가능합니다.

</div>

</div>

</div>


<!-- 질문 2 -->
<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq2">

예약 취소는 언제까지 가능한가요?

</button>

</h2>

<div id="faq2"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

예약 취소는 이용 시작 시간 기준 일정 시간 이전까지 가능합니다.

</div>

</div>

</div>


<!-- 질문 3 -->
<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq3">

결제는 어떤 방식으로 이루어지나요?

</button>

</h2>

<div id="faq3"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

신용카드, 포인트, 간편결제 등 다양한 방식으로 결제가 가능합니다.

</div>

</div>

</div>

</div>

</div>

</div>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>


</html>