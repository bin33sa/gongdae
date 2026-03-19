<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>공지사항 상세</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />

<!-- 상세페이지 전용 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/common/noticeDetail.css">

</head>

<body>

<!-- HEADER -->
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />

<main>
	<div class="notice-detail-page">
		<div class="container">

			<!-- 상단 타이틀 -->
			<div class="notice-detail-head">

				<div class="notice-detail-title">
					[공지] 공대생 커뮤니티 삼일절 휴무 안내
				</div>

				<div class="notice-detail-meta">
					<span>작성자 : 관리자</span>
					<span>작성일 : 2026.03.01 14:30</span>
				</div>

			</div>

			<!-- 내용 -->
			<div class="notice-detail-content">
				안녕하세요. 공대생 커뮤니티입니다.<br><br>
				삼일절을 맞이하여 아래와 같이 서비스가 일시 중단될 예정입니다.<br><br>

				■ 휴무 일정 : 2026년 3월 1일 (월)<br>
				■ 정상 운영 : 2026년 3월 2일 (화)부터<br><br>

				이용에 불편을 드려 죄송하며, 더 나은 서비스로 보답하겠습니다.<br><br>
				감사합니다.
			</div>

			<!-- 하단 버튼 -->
			<div class="notice-detail-bottom">
				<a href="<c:url value='/notice'/>" class="btn-back">
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