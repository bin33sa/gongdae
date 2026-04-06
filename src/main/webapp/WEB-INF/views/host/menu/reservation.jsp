<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 내역 - 공대생 호스트 센터</title>
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/reservation.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">
    <div class="mb-4">
        <h3 class="fw-bold">예약 내역</h3>
        <p class="text-muted">전체 예약 현황을 확인하고 관리하세요.</p>
    </div>

    <div class="reservation-filter-box mb-4">
        <form name="searchForm" action="<c:url value='/host/menu/reservation'/>" method="get">
            <input type="hidden" name="page" value="${page}">
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label small">기간</label>
                    <input type="date" name="startDate" value="${startDate}" class="form-control">
                </div>
                <div class="col-md-3">
                    <label class="form-label small">~</label>
                    <input type="date" name="endDate" value="${endDate}" class="form-control">
                </div>
                <div class="col-md-3">
                    <label class="form-label small">상태</label>
                    <select name="status" class="form-select">
                        <option value="">전체</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>결제 대기 (승인 대기)</option>
                        <option value="RESERVED" ${status == 'RESERVED' ? 'selected' : ''}>예약 확정</option>
                        <option value="COMPLETED" ${status == 'COMPLETED' ? 'selected' : ''}>이용 완료</option>
                        <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>취소/거절</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button type="button" class="btn btn-search w-100" onclick="searchReservation(1)">조회하기</button>
                </div>
            </div>
        </form>
    </div>

    <div class="reservation-table-box">
        <div class="table-header mb-3">
            <h5 class="fw-bold m-0">예약 리스트</h5>
        </div>
        <table class="table reservation-table text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>예약번호</th>
                    <th>예약일</th>
                    <th>매장명 / 룸</th>
                    <th>예약자(인원)</th>
                    <th>이용시간</th>
                    <th>금액</th>
                    <th>상태 및 관리</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="7" class="py-5 text-center text-muted" style="background-color: #f8f9fa;">
                                <i class="bi bi-calendar-x fs-1 d-block mb-3 text-secondary"></i>
                                <h5 class="fw-bold text-dark">조건에 맞는 예약 내역이 없습니다.</h5>
                                <p class="small mb-0">새로운 예약이 들어오면 이곳에서 확인할 수 있습니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="dto" items="${list}">
                            <tr>
                                <td class="fw-bold text-secondary">#R${dto.resNo}</td>
                                <td>${dto.resDate}</td>
                                <td class="text-start">
                                    <div class="fw-bold text-dark">${dto.spaceName}</div>
                                    <div class="small text-muted">${dto.unitTitle}</div>
                                </td>
                                <td>${dto.guestName} <span class="small text-muted">(${dto.peopleCount}명)</span></td>
                                <td>${dto.startTime}:00 ~ ${dto.endTime}:00</td>
                                <td class="fw-bold">₩ <fmt:formatNumber value="${dto.totalPrice}" pattern="#,###"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${dto.status == 'PENDING'}">
                                            <span class="badge bg-warning text-dark mb-2 d-inline-block">승인 대기</span>
                                            <div class="d-flex justify-content-center gap-1">
                                                <form id="approveForm_${dto.resNo}" action="<c:url value='/host/reservation/updateStatus'/>" method="post" class="m-0">
                                                    <input type="hidden" name="resNo" value="${dto.resNo}">
                                                    <input type="hidden" name="status" value="RESERVED">
                                                    <button type="button" class="btn btn-sm btn-success px-2 py-1" style="font-size: 0.75rem;" onclick="confirmAction('approve', 'approveForm_${dto.resNo}')">승인</button>
                                                </form>
                                                <form id="rejectForm_${dto.resNo}" action="<c:url value='/host/reservation/updateStatus'/>" method="post" class="m-0">
                                                    <input type="hidden" name="resNo" value="${dto.resNo}">
                                                    <input type="hidden" name="status" value="CANCELLED">
                                                    <button type="button" class="btn btn-sm btn-danger px-2 py-1" style="font-size: 0.75rem;" onclick="confirmAction('reject', 'rejectForm_${dto.resNo}')">거절</button>
                                                </form>
                                            </div>
                                        </c:when>
                                        <c:when test="${dto.status == 'RESERVED'}">
                                            <span class="badge badge-active">예약 확정</span>
                                        </c:when>
                                        <c:when test="${dto.status == 'COMPLETED'}">
                                            <span class="badge badge-done">이용 완료</span>
                                        </c:when>
                                        <c:when test="${dto.status == 'CANCELLED'}">
                                            <span class="badge badge-cancel">취소/거절</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <div class="d-flex justify-content-center mt-4">
            ${paging}
        </div>
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>
<jsp:include page="/WEB-INF/views/host/layout/chatWidget.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function searchReservation(page) {
        const form = document.searchForm;
        form.page.value = page;
        form.submit();
    }
    
    function confirmAction(actionType, formId) {
        const isApprove = actionType === 'approve';
        
        Swal.fire({
            title: isApprove ? '예약 승인' : '예약 거절',
            text: isApprove ? '이 예약을 확정하시겠습니까?' : '이 예약을 거절(취소) 처리하시겠습니까?',
            icon: isApprove ? 'question' : 'warning',
            showCancelButton: true,
            confirmButtonColor: isApprove ? '#198754' : '#E53935',
            cancelButtonColor: '#6c757d',
            confirmButtonText: isApprove ? '네, 승인합니다' : '네, 거절합니다',
            cancelButtonText: '취소',
            customClass: {
                popup: 'rounded-4 shadow-sm'
            }
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(formId).submit();
            }
        });
    }

    <c:if test="${not empty message}">
        const msg = "${message}";
        const isError = msg.includes("더블") || msg.includes("오류") || msg.includes("거절");
        
        Swal.fire({
            icon: isError ? 'error' : 'success',
            title: isError ? '예약 처리 불가' : '처리 완료',
            html: isError ? `<span style="color: #E53935; font-weight: bold;">\${msg}</span><br><br><span style="font-size: 0.9em; color: #666;">해당 시간에는 이미 확정된 예약이 있습니다.</span>` : msg,
            confirmButtonColor: '#E53935',
            confirmButtonText: '확인',
            background: isError ? '#fffafA' : '#ffffff',
            customClass: {
                popup: 'rounded-4 shadow-lg'
            }
        });
    </c:if>
</script>

</body>
</html>