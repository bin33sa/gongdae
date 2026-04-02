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
	href="${pageContext.request.contextPath}/dist/css/guest/page/paginate.css"
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
				
					<c:forEach var="dto" items="${list}">
						<c:url var="url" value="/event/${dto.num}">
							<c:param name="page" value="${page}"/>
						</c:url>
						
						<div class="col-md-3">
							<div class="event-card" onclick="location.href='${url}'">
								<div class="event-img">
									<img src="/uploads/event/${dto.saveFilename}">
								</div>
								<div class="event-body">
									<span class="event-badge active"> 진행중 </span>
									<h3>${dto.title}</h3>
									<div class="event-period">${dto.start_date} ~ ${dto.end_date}</div>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>

				<!-- 페이지네이션-->
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시글이 없습니다." : paging }
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