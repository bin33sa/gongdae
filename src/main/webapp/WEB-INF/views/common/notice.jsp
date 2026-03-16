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
	href="${pageContext.request.contextPath}/dist/css/common/notice.css"
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

				<!-- =====================================================
열린 공지
===================================================== -->

				<div class="notice-row">

					<div>

						<span class="notice-badge"> 공지 </span> <span class="notice-title">
							[공지] 공대생 커뮤니티 삼일절 휴무 안내 </span>

					</div>

					<button class="btn-notice">보기</button>

				</div>

				<!-- =====================================================
공지 내용
===================================================== -->

				<div class="notice-content-box">공지 내용 영역입니다. 공지 제목을 클릭하면 상세
					페이지로 이동하도록 구현할 수 있습니다.</div>

				<!-- =====================================================
공지 리스트
===================================================== -->

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

				<!-- =====================================================
페이지네이션
===================================================== -->

				<div class="pagination-area">

					<span class="active">1</span> <span>2</span> <span>3</span> <span>4</span>
					<span>5</span>

				</div>

			</div>
		</div>

	</main>

	<!-- FOOTER -->

	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

</body>

</html>
