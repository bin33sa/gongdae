<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - 월별 매출</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">월별 매출 통계</h3>
                    <p class="mb-0 text-muted">월간 수익 분석 및 성장 지표를 확인합니다.</p>
                </div>
                <button id="btn-export-excel" class="btn btn-purple"><i class="bi bi-file-earmark-arrow-down me-2"></i>월간 정산 보고서</button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="dashboard-box">
                        <div class="stat-label">이번 달 누적 매출 (${thisMonth.salesDate})</div>
                        <div class="stat-value">
                            ₩<fmt:formatNumber value="${thisMonth.payAmount}" pattern="#,###"/>
                            <c:if test="${thisMonth.payAmount > lastMonth.payAmount}">
                                <span class="trend-badge text-success" style="color:#34D399 !important; background-color: rgba(52, 211, 153, 0.15); border: 1px solid rgba(52, 211, 153, 0.3);">▲ 상승</span>
                            </c:if>
                        </div>
                        <p class="text-muted small mt-3">이번 달 누적 결제 : <strong>${thisMonth.payCount}건</strong></p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="dashboard-box">
                        <div class="stat-label">지난 달 총 매출 (${lastMonth.salesDate})</div>
                        <div class="stat-value text-muted">
                            ₩<fmt:formatNumber value="${lastMonth.payAmount}" pattern="#,###"/>
                        </div>
                        <p class="text-muted small mt-3">전월 최종 마감 데이터 기준</p>
                    </div>
                </div>
            </div>

            <div class="dashboard-box">
                <h5 class="fw-bold text-main mb-4">올해 월별 수익 요약 <span class="text-muted fs-6 fw-normal ms-2"></span></h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle text-center w-100">
                        <thead>
                            <tr>
                                <th class="admin-th">해당 월</th>
                                <th class="admin-th">결제 건수</th>
                                <th class="admin-th">월간 총 매출</th>
                                <th class="admin-th">환불 발생액</th>
                                <th class="admin-th text-end">최종 순매출</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${monthlyList}">
                                <tr class="board-row" onclick="goMonthList('${dto.salesDate}')">
                                    <td class="admin-td text-muted">${dto.salesDate}</td>
                                    <td class="admin-td">${dto.payCount}건</td>
                                    <td class="admin-td fw-bold text-main">₩<fmt:formatNumber value="${dto.payAmount}" pattern="#,###"/></td>
                                    <td class="admin-td fw-bold" style="color: #EF4444;">
                                        <c:if test="${dto.refundAmount > 0}">-</c:if>₩<fmt:formatNumber value="${dto.refundAmount}" pattern="#,###"/>
                                    </td>
                                    <td class="admin-td fw-bold text-end" style="color: #3B82F6;">
                                        ₩<fmt:formatNumber value="${dto.netAmount}" pattern="#,###"/>
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
    function goMonthList(dateStr) {
        var year = dateStr.substring(0, 4);
        var month = dateStr.substring(6, 8);
        var lastDay = new Date(year, month, 0).getDate(); 
        
        var startDate = year + "-" + month + "-01";
        var endDate = year + "-" + month + "-" + lastDay;
        
        location.href = '${pageContext.request.contextPath}/admin/sales/list?startDate=' + startDate + '&endDate=' + endDate;
    }

    document.getElementById('btn-export-excel').addEventListener('click', function() {
        var table = document.querySelector('.table');
        var wb = XLSX.utils.table_to_book(table, {sheet: "월별매출통계"});
        
        var today = new Date();
        var dateString = today.getFullYear() + ('0' + (today.getMonth() + 1)).slice(-2) + ('0' + today.getDate()).slice(-2);
        var fileName = '월별_매출_보고서_' + dateString + '.xlsx';
        
        XLSX.writeFile(wb, fileName);
    });
</script>
</body>
</html>