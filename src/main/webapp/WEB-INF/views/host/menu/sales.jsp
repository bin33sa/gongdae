<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상세매출 - 공대생 호스트 센터</title>

    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    <jsp:include page="/WEB-INF/views/host/layout/chatWidget.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/sales.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">

    <div class="mb-4">
        <h3 class="fw-bold">상세 매출</h3>
        <p class="text-muted">매장별 매출과 정산 내역을 확인하세요.</p>
    </div>

    <div class="sales-filter-box mb-4">
        <form name="searchForm" action="<c:url value='/host/menu/sales'/>" method="get">
            <input type="hidden" name="page" value="${page}">
            
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label small">기간 선택</label>
                    <input type="date" name="startDate" value="${startDate}" class="form-control">
                </div>

                <div class="col-md-3">
                    <label class="form-label small">~</label>
                    <input type="date" name="endDate" value="${endDate}" class="form-control">
                </div>

                <div class="col-md-3">
                    <label class="form-label small">매장 선택</label>
                    <select name="spaceNo" class="form-select">
                        <option value="0">전체 매장</option>
                        <c:forEach var="space" items="${spaceList}">
                            <option value="${space.spaceNo}" ${spaceNo == space.spaceNo ? 'selected' : ''}>${space.spaceName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-3">
                    <button type="button" class="btn btn-search w-100" onclick="searchSales(1)">조회하기</button>
                </div>
            </div>
        </form>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="sales-card">
                <div class="card-title">총 누적 매출</div>
                <div class="card-value">₩ <fmt:formatNumber value="${summary.totalSales}" pattern="#,###"/></div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="sales-card">
                <div class="card-title">총 결제 건수</div>
                <div class="card-value">${summary.totalResCount}건</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="sales-card">
                <div class="card-title">이번 달 당월 매출</div>
                <div class="card-value text-danger">₩ <fmt:formatNumber value="${summary.thisMonthSales}" pattern="#,###"/></div>
            </div>
        </div>
    </div>

    <div class="sales-table-box">

        <div class="table-header mb-3">
            <h5 class="fw-bold m-0">매출 상세 내역</h5>
        </div>

        <table class="table sales-table text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>날짜</th>
                    <th>매장명</th>
                    <th>예약자</th>
                    <th>결제 금액</th>
                    <th>정산 상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="5" class="py-5 text-center text-muted" style="background-color: #f8f9fa;">
                                <i class="bi bi-receipt fs-1 d-block mb-3 text-secondary"></i>
                                <h5 class="fw-bold text-dark">조건에 맞는 매출 내역이 없습니다.</h5>
                                <p class="small mb-0">게스트가 결제를 완료하면 매출로 집계됩니다.</p>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="dto" items="${list}">
                            <tr>
                                <td>${dto.resDate}</td>
                                <td class="text-start">
                                    <div class="fw-bold text-dark">${dto.spaceName}</div>
                                    <div class="small text-muted">${dto.unitTitle}</div>
                                </td>
                                <td>${dto.guestName}</td>
                                <td class="fw-bold">₩ <fmt:formatNumber value="${dto.totalPrice}" pattern="#,###"/></td>
                                <td>
                                   <c:choose>
        <c:when test="${dto.status == 'RESERVED'}">
            <span class="badge badge-active" style="background-color: #e3f2fd; color: #0d6efd; border: 1px solid #0d6efd;">결제 완료</span>
        </c:when>
        
        <c:when test="${dto.status == 'COMPLETED'}">
            <span class="badge badge-wait">정산 대기</span>
        </c:when>
        <c:when test="${dto.status == 'SETTLED'}">
            <span class="badge badge-done">정산 완료</span>
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

<script>
    function searchSales(page) {
        const form = document.searchForm;
        form.page.value = page;
        form.submit();
    }
</script>

</body>
</html>