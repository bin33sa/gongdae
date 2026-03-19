<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>이벤트</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />

<!-- 이벤트 페이지 전용 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/common/event.css"
	type="text/css">
<!-- 페이지네이션 전용 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/page/pagination.css"
	type="text/css">



</head>


<body>


	<header>
		<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />
	</header>


	<main>

		<section class="section">

			<div class="container">


				<!-- ===============================
페이지 헤더
=============================== -->

				<div class="event-header text-center mb-5">

					<h2 class="section-title">이벤트</h2>

					<p class="section-desc">공대생에서 진행 중인 다양한 이벤트를 확인하세요</p>

				</div>



				<!-- ===============================
이벤트 카드 그리드
=============================== -->

				<div class="event-grid row g-4">



					<div class="col-md-3">

						<div class="event-card">
							<a href="<c:url value='/event/detail'/>" class="event-link">

								<div class="event-img">
									<img src="/uploads/sample-event.jpg">
								</div>

								<div class="event-body">

									<span class="event-badge active"> 진행중 </span>

									<h3>신규 가입 5000포인트 지급 이벤트</h3>

									<div class="event-period">2026.03.01 ~ 2026.03.31</div>

								</div>
							</a>

						</div>

					</div>


					<div class="col-md-3">

						<div class="event-card">

							<div class="event-img">
								<img src="/uploads/sample-event.jpg">
							</div>

							<div class="event-body">

								<span class="event-badge active"> 진행중 </span>

								<h3>공간 예약 첫 이용 할인 이벤트</h3>

								<div class="event-period">2026.02.10 ~ 2026.04.10</div>

							</div>

						</div>

					</div>



					<div class="col-md-3">

						<div class="event-card">

							<div class="event-img">
								<img src="/uploads/sample-event.jpg">
							</div>

							<div class="event-body">

								<span class="event-badge active"> 진행중 </span>

								<h3>리뷰 작성 포인트 지급 이벤트</h3>

								<div class="event-period">2026.03.01 ~ 2026.05.01</div>

							</div>

						</div>

					</div>



					<div class="col-md-3">

						<div class="event-card">

							<div class="event-img">
								<img src="/uploads/sample-event.jpg">
							</div>

							<div class="event-body">

								<span class="event-badge"> 종료 </span>

								<h3>공대생 오픈 기념 이벤트</h3>

								<div class="event-period">2026.01.01 ~ 2026.04.01</div>

							</div>

						</div>

					</div>



				</div>




				<!-- 페이지네이션 껍데기 -->
				<div class="pagination-wrap">

					<ul class="pagination">

						<li class="page-item disabled"><span class="page-link">«</span>
						</li>

						<li class="page-item active"><span class="page-link">1</span>
						</li>

						<li class="page-item"><span class="page-link">2</span></li>

						<li class="page-item"><span class="page-link">3</span></li>

						<li class="page-item"><span class="page-link">4</span></li>

						<li class="page-item"><span class="page-link">»</span></li>

					</ul>

				</div>


			</div>

		</section>

	</main>



	<footer>
		<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp" />
	</footer>


	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />


</body>

</html>