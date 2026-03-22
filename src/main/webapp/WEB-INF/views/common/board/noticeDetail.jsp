<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>공지사항</title>

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
					<c:out value="${dto.title}"/>
				</div>

				<div class="notice-detail-meta">
					<span>작성자 : ${dto.admin_name}</span>
					<span>작성일 : ${dto.created_at}</span>
				</div>

			</div>

			<!-- 내용 -->
			<div class="notice-detail-content">
				<c:out value="${dto.content}" escapeXml="false"/>
			</div>
			
			<div>
				<c:if test="${not empty dto.saveFilename}">
					<p class="border text-secondary my-1 p-2">
						<i class="bi bi-folder2-open"></i>
						<a href="${pageContext.request.contextPath}/notice/download/${dto.num}">${dto.originalFilename}</a>
					</p>
				</c:if>
			</div>

			<!-- 하단 버튼 -->
			<div class="notice-detail-bottom">
				<a href="<c:url value='/notice?${query}'/>" class="btn-back">
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