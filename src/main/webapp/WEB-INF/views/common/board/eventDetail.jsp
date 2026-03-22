<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>이벤트 상세</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />

<!-- 이벤트 상세 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/common/eventDetail.css">

</head>

<body>

<!-- HEADER -->
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />

<main>
	<div class="event-detail-page">
		<div class="container">

			<!-- 상단 -->
			<div class="event-detail-head">

				<div class="event-detail-title">
					${dto.title }
				</div>

				<div class="event-detail-meta">
					<span class="event-badge active">진행중</span>
					<span>기간 : ${dto.start_date} ~ ${dto.end_date}</span>
				</div>

			</div>

			<!-- 대표 이미지 -->
			<c:if test="not empty dto.saveFilename">
				<div class="event-detail-image">
					<img src="/uploads/admin/event/${dto.saveFilename}" alt="이벤트 이미지">
				</div>
			</c:if>

			<!-- 내용 -->
			<div class="event-detail-content">
				${dto.content}
			</div>

			<!-- 하단 -->
			<div class="event-detail-bottom">
				<a href="<c:url value='/event?${query}'/>" class="btn-back">
					목록으로
				</a>
			</div>

		</div>
	</div>
</main>

<!-- FOOTER -->
<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

</body>
</html>