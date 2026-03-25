<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - 프리미엄 운영 관리</title>
</head>
<body class="admin-page">
<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2"><i class="bi bi-star-fill text-warning me-2"></i>프리미엄 이력 내역</h3>
                    <p class="mb-0 text-muted">적용 중이거나 만료/취소된 프리미엄 내역을 조회합니다.</p>
                </div>
                <button id="btn-export-excel" class="btn btn-purple"><i class="bi bi-download me-2"></i>엑셀 다운로드</button>
            </div>
            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex gap-2">
                        <form name="searchForm" action="${pageContext.request.contextPath}/admin/spaces/premium" method="get">
                            <select name="premiumStatus" class="form-select bg-transparent text-main border-secondary" style="width: 160px;" onchange="this.form.submit()">
                                <option value="ACTIVE" ${premiumStatus == 'ACTIVE' ? 'selected' : ''} style="color: #34D399;">★ 현재 적용중</option>
                                <option value="CANCELED" ${premiumStatus == 'CANCELED' ? 'selected' : ''}>만료/취소 내역</option>
                                <option value="" ${premiumStatus == '' ? 'selected' : ''}>전체 이력 보기</option>
                            </select>
                        </form>
                    </div>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>건 조회됨</div>
                </div>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th txt-center">공간번호</th>
                                <th class="admin-th">분류</th>
                                <th class="admin-th">공간명</th>
                                <th class="admin-th">호스트</th>
                                <th class="admin-th txt-center">처리 일자</th>
                                <th class="admin-th txt-center">상태</th>
                                <th class="admin-th txt-right" style="padding-right: 28px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="7" class="admin-td txt-center txt-muted" style="padding: 3rem 0;">조건에 맞는 내역이 없습니다.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="admin-td txt-center txt-muted">#S-${dto.spaceNo}</td>
                                    <td class="admin-td"><span class="badge bg-secondary bg-opacity-25 text-muted">${dto.categoryName}</span></td>
                                    <td class="admin-td fw-bold text-truncate" style="max-width: 250px;">
                                        <i class="bi bi-star-fill text-warning me-1"></i>
                                        ${dto.spaceName}
                                    </td>
                                    <td class="admin-td text-info fw-bold">${dto.hostName}</td>
                                    <td class="admin-td txt-center txt-muted small-txt">${dto.appliedAt}</td>
                                    <td class="admin-td txt-center">
                                        <c:choose>
                                            <c:when test="${dto.premiumStatus == 'PENDING'}"><span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">신청 대기</span></c:when>
                                            <c:when test="${dto.premiumStatus == 'ACTIVE'}"><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">적용중</span></c:when>
                                            <c:otherwise><span class="badge bg-light bg-opacity-10 text-main border border-secondary border-opacity-25 px-2 py-1">취소/만료</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td txt-right">
                                        <button class="btn btn-sm btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/spaces/detail/${dto.spaceNo}?page=${page}&from=premium';">상세 보기</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center mt-4">
                    <nav aria-label="Page navigation"><div class="admin-pagination">${paging}</div></nav>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('btn-export-excel').addEventListener('click', function() {
        var table = document.querySelector('.table');
        var cloneTable = table.cloneNode(true);

        var ths = cloneTable.querySelectorAll('th:last-child');
        ths.forEach(th => th.remove());
        var tds = cloneTable.querySelectorAll('td:last-child');
        tds.forEach(td => td.remove());

        var wb = XLSX.utils.table_to_book(cloneTable, {sheet: "프리미엄이력"});

        var today = new Date();
        var dateString = today.getFullYear() + ('0' + (today.getMonth() + 1)).slice(-2) + ('0' + today.getDate()).slice(-2);
        var fileName = '프리미엄_이력_내역_' + dateString + '.xlsx';

        XLSX.writeFile(wb, fileName);
    });
});
</script>
</body>
</html>