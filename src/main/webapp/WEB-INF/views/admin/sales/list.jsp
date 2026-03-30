<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 예약 및 결제 내역</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-2">예약 및 결제 내역</h3>
                    <p class="mb-0 text-muted">플랫폼에서 발생한 전체 예약 건수 : <strong class="text-main">${dataCount}</strong>건</p>
                </div>
            </div>

            <div class="dashboard-box mb-4 py-3 px-4">
                <form name="searchForm" action="${pageContext.request.contextPath}/admin/sales/list" method="get" class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                    <input type="hidden" name="page" value="1">
                    
                    <div class="d-flex align-items-center gap-3">
                        <select name="status" class="admin-input" style="width: 130px; border-radius: 6px;">
                            <option value="">상태 전체</option>
                            <option value="RESERVED" ${status == 'RESERVED' ? 'selected' : ''}>RESERVED</option>
                            <option value="COMPLETED" ${status == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                            <option value="CANCELLED" ${status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        </select>
                        
                        <div class="d-flex align-items-center gap-2">
                            <input type="date" name="startDate" class="admin-input" value="${startDate}" style="border-radius: 6px;">
                            <span class="text-white">~</span>
                            <input type="date" name="endDate" class="admin-input" value="${endDate}" style="border-radius: 6px;">
                        </div>
                    </div>

                    <div class="d-flex align-items-center gap-2">
                        <select name="col" class="admin-input" style="width: 120px; border-radius: 6px;">
                            <option value="guestName" ${col == 'guestName' ? 'selected' : ''}>예약자명</option>
                            <option value="spaceName" ${col == 'spaceName' ? 'selected' : ''}>공간명</option>
                            <option value="resNo" ${col == 'resNo' ? 'selected' : ''}>예약번호</option>
                        </select>
                        
                        <div class="input-group" style="width: 250px;">
                            <input type="text" name="kw" value="${kw}" placeholder="검색어 입력" class="form-control admin-input bg-transparent text-main border-secondary">
                            <button class="btn btn-outline-secondary" type="submit" onclick="document.searchForm.page.value='1';"><i class="bi bi-search"></i></button>
                        </div>
                        <button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/sales/list';" class="btn btn-outline-secondary ms-1">초기화</button>
                    </div>
                </form>
            </div>

            <div class="dashboard-box">
                <div class="table-responsive">
                    <table class="table mb-0 align-middle text-center w-100">
                        <thead>
                            <tr>
                                <th class="admin-th text-center">예약번호</th>
                                <th class="admin-th text-center">예약자명</th>
                                <th class="admin-th text-center">공간명</th>
                                <th class="admin-th text-center">이용일시</th>
                                <th class="admin-th text-center">결제금액</th>
                                <th class="admin-th text-center">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="6" class="admin-td py-5 text-muted">등록된 예약 내역이 없습니다.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="dto" items="${list}">
                                <tr class="board-row" onclick="location.href='${articleUrl}&resNo=${dto.resNo}'">
                                    <td class="admin-td text-muted">${dto.resNoStr}</td>
                                    <td class="admin-td">${dto.guestName}</td>
                                    <td class="admin-td fw-bold text-truncate" style="max-width: 250px;">${dto.spaceName}</td>
                                    <td class="admin-td text-muted small-txt">${dto.resDate}</td>
                                    <td class="admin-td fw-bold"><fmt:formatNumber value="${dto.amount}" pattern="#,###"/>원</td>
                                    <td class="admin-td fw-bold"><span class="${dto.statusColor}">${dto.resStatus}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-center mt-4">
                    <nav aria-label="Page navigation">
                        <div class="admin-pagination">${paging}</div>
                    </nav>
                </div>
            </div>
        </main>
    </div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</footer>

</body>
</html>