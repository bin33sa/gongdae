<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - 일별 매출</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">일별 매출 내역</h3>
                    <p class="mb-0 text-muted">오늘의 실시간 매출과 최근 일주일간의 정산 현황입니다.</p>
                </div>
                <button id="btn-export-excel" class="btn btn-purple"><i class="bi bi-file-earmark-arrow-down me-2"></i>일일 보고서 다운로드</button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="dashboard-box text-center">
                        <div class="stat-label">오늘 총 매출</div>
                        <div class="stat-value justify-content-center text-main">
                            ₩<fmt:formatNumber value="${today.payAmount}" pattern="#,###"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-box text-center">
                        <div class="stat-label">오늘 결제 건수</div>
                        <div class="stat-value justify-content-center">
                            ${today.payCount}건
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-box text-center">
                        <div class="stat-label">오늘 환불 발생</div>
                        <div class="stat-value justify-content-center" style="color: #EF4444;">
                            <span class="fs-4 me-2">${today.refundCount}건</span>
                            -₩<fmt:formatNumber value="${today.refundAmount}" pattern="#,###"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="dashboard-box">
                <h5 class="fw-bold text-main mb-4">최근 7일 상세 내역 <span class="text-muted fs-6 fw-normal ms-2"></span></h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle text-center w-100">
                        <thead>
                            <tr>
                                <th class="admin-th">날짜</th>
                                <th class="admin-th">결제 건수</th>
                                <th class="admin-th">매출액</th>
                                <th class="admin-th">환불액</th>
                                <th class="admin-th">순매출</th>
                                <th class="admin-th text-end">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${dailyList}" varStatus="status">
                                <c:set var="rawDate" value="${fn:substring(dto.salesDate, 0, 10)}"/>
                                <tr class="board-row" onclick="location.href='${pageContext.request.contextPath}/admin/sales/list?startDate=${rawDate}&endDate=${rawDate}';">
                                    <td class="admin-td text-muted">${dto.salesDate}</td>
                                    <td class="admin-td">${dto.payCount}건</td>
                                    <td class="admin-td fw-bold text-main">₩<fmt:formatNumber value="${dto.payAmount}" pattern="#,###"/></td>
                                    <td class="admin-td fw-bold" style="color: #EF4444;">
                                        <c:if test="${dto.refundAmount > 0}">-</c:if>₩<fmt:formatNumber value="${dto.refundAmount}" pattern="#,###"/>
                                    </td>
                                    <td class="admin-td fw-bold" style="color: #34D399;">₩<fmt:formatNumber value="${dto.netAmount}" pattern="#,###"/></td>
                                    <td class="admin-td text-end">
                                        <c:choose>
                                            <c:when test="${status.index == 0}">
                                                <span class="badge-success" style="background-color: rgba(59, 130, 246, 0.15); color: #3B82F6 !important; border-color: rgba(59, 130, 246, 0.3) !important;">오늘</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-success text-muted" style="background-color: transparent !important; border-color: var(--border-color) !important;">마감</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</footer>
<script type="text/javascript">
    document.getElementById('btn-export-excel').addEventListener('click', function() {
        var table = document.querySelector('.table');
        var wb = XLSX.utils.table_to_book(table, {sheet: "일별매출내역"});
        
        var today = new Date();
        var dateString = today.getFullYear() + ('0' + (today.getMonth() + 1)).slice(-2) + ('0' + today.getDate()).slice(-2);
        var fileName = '일별_매출_보고서_' + dateString + '.xlsx';
        
        XLSX.writeFile(wb, fileName);
    });
</script>
</body>
</html>