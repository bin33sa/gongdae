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

<!-- 질문 4 -->

<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq4">

공간 이용 시간이 초과되면 어떻게 되나요?

</button>

</h2>

<div id="faq4"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

이용 시간 종료 후 추가 사용이 필요한 경우, 현장 상황에 따라 연장이 가능할 수 있으며 추가 요금이 발생할 수 있습니다.

</div>

</div>

</div>

<!-- 질문 5 -->

<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq5">

예약 취소 시 환불은 어떻게 진행되나요?

</button>

</h2>

<div id="faq5"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

취소 시점에 따라 환불 금액이 달라질 수 있으며, 자세한 환불 규정은 각 공간 상세 페이지에서 확인하실 수 있습니다.
</div>

</div>

</div>

<!-- 질문6  -->

<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq6">

공간 이용 중 문제가 발생하면 어떻게 하나요?

</button>

</h2>

<div id="faq6"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

시설 이용 중 문제가 발생한 경우 즉시 호스트에게 문의해주시고, 필요 시 고객센터를 통해 도움을 받으실 수 있습니다.
</div>

</div>

</div>


<!-- 질문 7  -->

<div class="accordion-item">

<h2 class="accordion-header">

<button class="accordion-button collapsed"
        data-bs-toggle="collapse"
        data-bs-target="#faq7">

이용 후 후기는 언제 작성할 수 있나요?

</button>

</h2>

<div id="faq7"
     class="accordion-collapse collapse"
     data-bs-parent="#faqAccordion">

<div class="accordion-body">

공간 이용이 완료된 이후 후기 작성이 가능하며, 작성된 후기는 다른 사용자에게 중요한 참고 자료로 활용됩니다.
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