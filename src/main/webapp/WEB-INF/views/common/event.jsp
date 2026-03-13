<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>이벤트</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

</head>


<body>


<header>
	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>



<main>

<section class="section">

<div class="container">

<!-- 페이지 헤더 -->

<div class="event-header text-center mb-5">

<h2>이벤트</h2>

<p class="text-secondary">
공대생에서 진행 중인 다양한 이벤트를 확인하세요
</p>

</div>



<!-- 이벤트 카드 그리드 -->

<div class="event-grid row g-4">



<!-- 이벤트 카드 -->

<div class="col-md-3">

<div class="event-card">

<div class="event-img">

<img src="/uploads/sample-event.jpg" class="img-fluid">

</div>

<div class="event-body">

<h3>신규 가입 5000포인트 지급 이벤트</h3>

<div class="event-period">
2026.03.01 ~ 2026.03.31
</div>

</div>

</div>

</div>



<div class="col-md-3">

<div class="event-card">

<div class="event-img">

<img src="/uploads/sample-event.jpg" class="img-fluid">

</div>

<div class="event-body">

<h3>공간 예약 첫 이용 할인 이벤트</h3>

<div class="event-period">
2026.02.10 ~ 2026.04.10
</div>

</div>

</div>

</div>



<div class="col-md-3">

<div class="event-card">

<div class="event-img">

<img src="/uploads/sample-event.jpg" class="img-fluid">

</div>

<div class="event-body">

<h3>리뷰 작성 포인트 지급 이벤트</h3>

<div class="event-period">
2026.03.01 ~ 2026.05.01
</div>

</div>

</div>

</div>



<div class="col-md-3">

<div class="event-card">

<div class="event-img">

<img src="/uploads/sample-event.jpg" class="img-fluid">

</div>

<div class="event-body">

<h3>공대생 오픈 기념 이벤트</h3>

<div class="event-period">
2026.01.01 ~ 2026.04.01
</div>

</div>

</div>

</div>



</div>



<!-- 페이지네이션 -->

<div class="event-pagination text-center mt-5">

<span class="page-item active">1</span>
<span class="page-item">2</span>
<span class="page-item">3</span>
<span class="page-item">4</span>

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