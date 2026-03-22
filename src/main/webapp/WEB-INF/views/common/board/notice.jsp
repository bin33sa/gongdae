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
	href="${pageContext.request.contextPath}/dist/css/guest/page/paginate.css"
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

					<form name="searchForm">

						<div class="notice-search-bar">

							<i class="bi bi-search notice-search-icon"></i> <input
								type="text" class="notice-search-input" name="kwd" value="${kwd}"
								placeholder="공지사항을 검색하세요" />

							<button type="submit" class="notice-search-btn">검색</button>

						</div>

					</form>

				</div>

			
				<c:forEach var="dto" items="${list}">
					<c:url var="url" value="/notice/${dto.num}">
						<c:param name="page" value="${page}"/>
						<c:if test="${not empty kwd}">
							<c:param name="kwd" value="${kwd}"/>
						</c:if>
					</c:url>
					<div class="notice-row" onclick="location.href='${url}'">
	
						<div>
	
							<span class="notice-badge"> 공지 </span>
							<span class="notice-title"><c:out value="${dto.title}"/></span>
	
						</div>
	
					</div>
				
				</c:forEach>

				<!-- 페이지네이션 -->
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시글이 없습니다" : paging }
				</div>


			</div>
		</div>

	</main>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
	const inputEl = document.querySelector('form input[name=kwd]');
	
	inputEl.addEventListener('keydown', e => {
		if(e.key === 'Enter') {
			e.preventDefault();
			
			searchNotice();
		}
	})
})

function searchNotice() {
	const f = document.Form;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	const params = new URLSearchParams(formData).toString();
	
	const url = '${pageContext.request.contextPath}/bbs/list?' + params;
	location.href = url;
}

</script>

	<!-- FOOTER -->
<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

</body>

</html>
