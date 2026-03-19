<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>공지사항 목록</title>

<!-- 공통 리소스 -->

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />

<!-- 공지 페이지 전용 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/common/notice.css"
	type="text/css">
<!-- 페이지네이션 전용 css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/page/pagination.css"
	type="text/css">

</head>

<body>

	<!-- HEADER -->

	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />

	<main>

		<div class="notice-page">
			<div class="container">

				<!-- =====================================================
SECTION TITLE
===================================================== -->

				<div class="section-head">

					<div>

						<div class="section-eyebrow">NOTICE</div>

						<h2 class="section-title">공지사항</h2>

						<div class="section-desc">공대생 커뮤니티의 중요한 소식을 확인하세요</div>

					</div>

				</div>

				<!-- =====================================================
검색 영역
===================================================== -->

				<div class="notice-search">

					<form>

						<div class="notice-search-bar">

							<i class="bi bi-search notice-search-icon"></i> <input
								type="text" class="notice-search-input"
								placeholder="공지사항을 검색하세요" />

							<button type="submit" class="notice-search-btn">검색</button>

						</div>

					</form>

				</div>

			

				<div class="notice-row">

					<div>

						<span class="notice-badge"> 공지 </span> <span class="notice-title">
							[공지] 공대생 커뮤니티 삼일절 휴무 안내 </span>

					</div>
<a href="<c:url value='/notice/detail'/>" class="btn-notice">
    보기
</a>
					

				</div>

			

				<div class="notice-row">

					<div>

						<span class="notice-badge"> 공지 </span> <span class="notice-title">
							[공지] 공지 제목 땅땅땅 </span>

					</div>

					<button class="btn-notice">보기</button>

				</div>

				<div class="notice-row">

					<div>

						<span class="notice-badge"> 공지 </span> <span class="notice-title">
							[공지] 시스템 점검 안내 </span>

					</div>

					<button class="btn-notice">보기</button>

				</div>

				<div class="notice-row">

					<div>

						<span class="notice-badge"> 공지 </span> <span class="notice-title">
							[공지] 신규 기능 업데이트 안내 </span>

					</div>

					<button class="btn-notice">보기</button>

				</div>

				<div class="notice-row">

					<div>

						<span class="notice-badge"> 공지 </span> <span class="notice-title">
							[공지] 공대생 커뮤니티 삼일절 휴무 안내 </span>

					</div>

					<button class="btn-notice">보기</button>

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
		</div>

	</main>

	<!-- FOOTER -->
<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

</body>

</html>
