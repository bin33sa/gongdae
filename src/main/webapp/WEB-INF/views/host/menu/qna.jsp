<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 답변 - 공대생 호스트 센터</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/qna.css">
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
						<select class="form-select form-select-sm qna-filter" onchange="filterList(this.value)">
							<option value="all">전체 보기</option>
							<option value="wait">답변 대기만</option>
						</select>
					</div>
					<div class="qna-search-box">
						<input type="text" class="qna-search-input" placeholder="게스트명 또는 공간명 검색">
						<button type="button" class="qna-search-btn"><i class="bi bi-search"></i></button>
					</div>
				</div>

				<div class="qna-list">
                    <c:if test="${empty list}">
                        <div class="p-4 text-center text-muted small">현재 등록된 문의가 없습니다.</div>
                    </c:if>
                    <c:forEach var="item" items="${list}">
                        <div class="qna-item ${item.inquiryNo == detail.inquiryNo ? 'active' : ''} filter-item" 
                             data-status="${item.isAnswered}"
                             onclick="location.href='<c:url value="/host/menu/qna?inquiryNo=${item.inquiryNo}"/>'">
                            
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <c:choose>
                                    <c:when test="${item.isAnswered == 'N'}">
                                        <span class="badge badge-wait rounded-pill">답변 대기</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-done rounded-pill">답변 완료</span>
                                    </c:otherwise>
                                </c:choose>
                                <span class="small text-muted">${item.createdAt.substring(0, 10)}</span>
                            </div>
                            <div class="fw-bold fs-6 text-truncate">${item.title}</div>
                            <div class="small text-muted mt-1 d-flex justify-content-between">
                                <span><i class="bi bi-person me-1"></i>${item.guestName} (${item.spaceName})</span>
                            </div>
                        </div>
                    </c:forEach>
				</div>
			</div>

			<div class="qna-chat-area">
                <c:choose>
                    <c:when test="${not empty detail}">
                        <div class="chat-header">
                            <div>
                                <h5 class="fw-bold m-0 text-truncate" style="max-width: 500px;">${detail.title}</h5>
                                <div class="small text-muted mt-1">문의 공간 : ${detail.spaceName}</div>
                            </div>
                            <div class="text-end">
                                <span class="fw-bold" style="color: var(--host-primary);">${detail.guestName}</span> 게스트
                                <div class="small text-muted">${detail.createdAt}</div>
                            </div>
                        </div>

                        <div class="chat-body" id="chatBody">
                            <div class="text-center mb-4">
                                <span class="badge bg-light text-muted border px-3 py-2 rounded-pill">문의일: ${detail.createdAt.substring(0, 10)}</span>
                            </div>

                            <div class="bubble-wrapper guest-wrapper">
                                <div class="fw-bold small mb-1 ms-1 text-muted">${detail.guestName} 게스트</div>
                                <div class="bubble bubble-guest">
                                    ${detail.content}
                                </div>
                                <div class="bubble-time">${detail.createdAt.substring(11)}</div>
                            </div>

                            <c:if test="${detail.isAnswered == 'Y'}">
                                <div class="bubble-wrapper host-wrapper mt-3 text-end">
                                    <div class="fw-bold small mb-1 me-1" style="color: var(--host-primary);">호스트(나)</div>
                                    <div class="bubble bubble-host text-start d-inline-block">
                                        ${detail.answer}
                                    </div>
                                    <div class="bubble-time">${detail.answeredAt.substring(11)}</div>
                                </div>
                            </c:if>
                        </div>

                        <c:if test="${detail.isAnswered == 'N'}">
                            <form action="<c:url value='/host/inquiry/reply'/>" method="post" class="chat-input-wrapper m-0">
                                <input type="hidden" name="inquiryNo" value="${detail.inquiryNo}">

                                <div class="d-flex gap-2">
                                    <textarea name="answer" class="form-control chat-textarea"
                                        placeholder="게스트에게 친절하게 답변을 남겨주세요." required></textarea>

                                    <button type="submit" class="btn-send">
                                        <i class="bi bi-send-fill"></i>
                                    </button>
                                </div>
                                <sec:csrfInput />
                            </form>
                        </c:if>
                        
                        <c:if test="${detail.isAnswered == 'Y'}">
                             <div class="chat-input-wrapper m-0 bg-light text-center text-muted p-3 border-top">
                                답변이 완료된 문의입니다.
                             </div>
                        </c:if>
                    </c:when>

                    <c:otherwise>
                        <div class="d-flex justify-content-center align-items-center h-100 text-muted">
                            <div class="text-center">
                                <i class="bi bi-chat-dots fs-1 mb-2"></i>
                                <p>왼쪽 목록에서 문의를 선택해주세요.</p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
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
            if(chatBody) chatBody.scrollTop = chatBody.scrollHeight;
		}

        // 답변 대기 필터 기능
        function filterList(val) {
            const items = document.querySelectorAll('.filter-item');
            items.forEach(item => {
                if (val === 'all') {
                    item.style.display = 'block';
                } else if (val === 'wait') {
                    if (item.getAttribute('data-status') === 'N') {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                }
            });
        }
	</script>

</body>
</html>