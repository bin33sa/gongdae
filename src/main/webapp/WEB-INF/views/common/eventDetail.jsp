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
					신규 가입 5000포인트 지급 이벤트
				</div>

				<div class="event-detail-meta">
					<span class="event-badge active">진행중</span>
					<span>기간 : 2026.03.01 ~ 2026.03.31</span>
				</div>

			</div>

			<!-- 대표 이미지 -->
			<div class="event-detail-image">
				<img src="/uploads/sample-event.jpg" alt="이벤트 이미지">
			</div>

			<!-- 내용 -->
			<div class="event-detail-content">
				안녕하세요 공대생입니다.<br><br>

				신규 가입 회원을 대상으로 특별한 혜택을 준비했습니다! 🎉<br><br>

				■ 이벤트 내용<br>
				회원가입 시 5000 포인트 즉시 지급<br><br>

				■ 참여 방법<br>
				1. 회원가입 진행<br>
				2. 자동 지급된 포인트 확인<br><br>

				지금 바로 가입하고 혜택 받아가세요!
			</div>

			<!-- 하단 -->
			<div class="event-detail-bottom">
				<a href="<c:url value='/event'/>" class="btn-back">
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