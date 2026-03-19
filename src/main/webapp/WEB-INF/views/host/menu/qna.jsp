<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 답변 - 공대생 호스트 센터</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />

<!-- qna CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/host/menu/qna.css">
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/host/layout/header.jsp" />
	</header>

	<main class="container mt-5 mb-5">

		<div class="mb-4">
			<h3 class="fw-bold" style="color: #333;">1:1 문의 답변</h3>
			<p class="text-muted">게스트가 남긴 공간 문의에 신속하게 답변해 보세요.</p>
		</div>

		<div class="qna-container">

			<div class="qna-sidebar">
				<div class="qna-sidebar-header">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h5 class="fw-bold m-0">문의 내역</h5>
						<select class="form-select form-select-sm qna-filter">
							<option value="all">전체 보기</option>
							<option value="wait" selected>답변 대기만</option>
						</select>
					</div>
					<div class="qna-search-box">

						<input type="text" class="qna-search-input"
							placeholder="게스트명 또는 공간명 검색">

						<button type="button" class="qna-search-btn">
							<i class="bi bi-search"></i>
						</button>

					</div>
				</div>

				<div class="qna-list">
					<div class="qna-item active">
						<div
							class="d-flex justify-content-between align-items-center mb-2">
							<span class="badge badge-wait rounded-pill">답변 대기</span> <span
								class="small text-muted">2시간 전</span>
						</div>
						<div class="fw-bold fs-6 text-truncate">빔 프로젝터 HDMI 선 있나요?</div>
						<div class="small text-muted mt-1 d-flex justify-content-between">
							<span><i class="bi bi-person me-1"></i>김공대 (홍대 루프탑 파티룸)</span>
						</div>
					</div>

					<div class="qna-item">
						<div
							class="d-flex justify-content-between align-items-center mb-2">
							<span class="badge badge-done rounded-pill">답변 완료</span> <span
								class="small text-muted">어제 14:30</span>
						</div>
						<div class="fw-bold fs-6 text-truncate text-muted">주차장 이용 관련
							문의드립니다.</div>
						<div class="small text-muted mt-1 d-flex justify-content-between">
							<span><i class="bi bi-person me-1"></i>이학생 (강남 스터디룸 A호)</span>
						</div>
					</div>
				</div>
			</div>

			<div class="qna-chat-area">

				<div class="chat-header">
					<div>
						<h5 class="fw-bold m-0">빔 프로젝터 HDMI 선 있나요?</h5>
						<div class="small text-muted mt-1">문의 공간 : 홍대 루프탑 파티룸</div>
					</div>
					<div class="text-end">
						<span class="fw-bold" style="color: var(--host-primary);">김공대</span>
						게스트
						<div class="small text-muted">2026.03.12 15:30</div>
					</div>
				</div>

				<div class="chat-body" id="chatBody">

					<div class="text-center mb-4">
						<span
							class="badge bg-light text-muted border px-3 py-2 rounded-pill">2026년
							3월 12일</span>
					</div>

					<div class="bubble-wrapper guest-wrapper">
						<div class="fw-bold small mb-1 ms-1 text-muted">김공대 게스트</div>
						<div class="bubble bubble-guest">
							안녕하세요! 이번 주 토요일에 예약한 사람입니다.<br> 노트북을 가져가려고 하는데, 빔 프로젝터에 연결할
							수 있는 HDMI 선이 공간에 기본으로 구비되어 있는지 궁금합니다! 혹시 C타입 젠더도 있을까요?
						</div>
						<div class="bubble-time">오후 3:30</div>
					</div>

				</div>

				<form action="<c:url value='/space/inquiry/reply'/>" method="post"
					class="chat-input-wrapper m-0">
					<input type="hidden" name="inquiryNo" value="1">

					<div class="d-flex gap-2">
						<textarea name="answer" class="form-control chat-textarea"
							placeholder="게스트에게 친절하게 답변을 남겨주세요." required></textarea>

						<button type="submit" class="btn-send">
							<i class="bi bi-send-fill"></i>
						</button>
					</div>


					<sec:csrfInput />
				</form>

			</div>

		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

	<script>
		// 페이지 로드 시 채팅창 스크롤을 항상 맨 아래로 이동
		window.onload = function() {
			const chatBody = document.getElementById('chatBody');
			chatBody.scrollTop = chatBody.scrollHeight;
		}
	</script>

</body>
</html>