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

<c:forEach var="e" items="${eventList}">

    <div class="col-md-3">

        <div class="event-card">

            <div class="event-img">
                <img src="${e.imageUrl}">
            </div>

            <div class="event-body">

                <!-- 상태 뱃지 -->
                <c:choose>
                    <c:when test="${e.endDate >= now}">
                        <span class="event-badge active">진행중</span>
                    </c:when>
                    <c:otherwise>
                        <span class="event-badge">종료</span>
                    </c:otherwise>
                </c:choose>

                <h3>${e.title}</h3>

                <div class="event-period">
                    <fmt:formatDate value="${e.startDate}" pattern="yyyy.MM.dd"/>
                    ~
                    <fmt:formatDate value="${e.endDate}" pattern="yyyy.MM.dd"/>
                </div>

            </div>

        </div>

    </div>

</c:forEach>

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