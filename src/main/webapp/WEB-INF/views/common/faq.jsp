<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>FAQ</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
<!--faq 페이지 전용 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/common/faq.css"
	type="text/css">

</head>


<body>


<header>
	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>


<main>

<section class="section faq-page">

<div class="container">


<!-- 페이지 헤더 -->

<div class="faq-header">

<h2 class="section-title">
자주 묻는 질문
</h2>

<p class="section-desc">
서비스 이용 중 궁금한 내용을 확인해보세요
</p>

</div>



<!-- FAQ ACCORDION -->

<div class="accordion faq-accordion" id="faqAccordion">


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

</section>

</main>


<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>


<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>


</body>

</html>