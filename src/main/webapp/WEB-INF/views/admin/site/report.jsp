<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 신고 내역 관리</title>
</head>
<body class="admin-page">
<div class="admin-layout">
    
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">신고 내역 관리</h3>
                    <p class="mb-0 text-muted">서비스 정책 위반 신고 건을 검토하고 처리합니다.</p>
                </div>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <form name="searchForm" action="${pageContext.request.contextPath}/admin/site/report" method="get" class="d-flex gap-2">
                        <input type="hidden" name="page" value="1">
                        <select name="status" class="form-select bg-transparent text-main border-secondary" style="width: 130px;" onchange="searchList()">
                            <option value="" ${status == '' ? 'selected' : ''}>전체 상태</option>
                            <option value="WAITING" ${status == 'WAITING' ? 'selected' : ''}>미처리(대기)</option>
                            <option value="DONE" ${status == 'DONE' ? 'selected' : ''}>처리 완료</option>
                        </select>
                        <select name="schType" class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                            <option value="reporter" ${schType == 'reporter' ? 'selected' : ''}>신고자(ID)</option>
                            <option value="reason" ${schType == 'reason' ? 'selected' : ''}>신고 사유</option>
                        </select>
                        <div class="input-group" style="width: 250px;">
                            <input type="text" name="kwd" value="${kwd}" class="form-control bg-transparent text-main border-secondary" placeholder="검색어 입력">
                            <button class="btn btn-outline-secondary" type="submit" onclick="searchList()"><i class="bi bi-search"></i></button>
                        </div>
                    </form>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>건의 신고</div>
                </div>

                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th text-center">번호</th>
                                <th class="admin-th">피신고자/대상</th>
                                <th class="admin-th">신고자</th>
                                <th class="admin-th">신고 사유</th>
                                <th class="admin-th text-center">신고일</th>
                                <th class="admin-th text-center">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="6" class="admin-td text-center py-5 text-muted">
                                        <i class="bi bi-info-circle me-2"></i>접수된 신고 내역이 없습니다.
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="admin-td text-center text-muted">#R-${dto.reportNo}</td>
                                    <td class="admin-td fw-bold">${dto.targetType} (NO. ${dto.targetNo})</td>
                                    <td class="admin-td">${dto.reporterName}</td>
                                    <td class="admin-td text-truncate" style="max-width: 250px;" title="${dto.reason}">${dto.reason}</td>
                                    <td class="admin-td text-center small text-muted">${dto.createdAt}</td>
                                    <td class="admin-td text-center">
                                        <c:choose>
                                            <c:when test="${dto.status == 'WAITING' or empty dto.status}">
                                                <span class="badge" style="background-color: rgba(245, 158, 11, 0.15); color: #F59E0B !important;">미처리</span>
                                            </c:when>
                                            <c:when test="${dto.status == 'DONE'}">
                                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">처리완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${dto.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
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
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script>
function searchList() {
    const f = document.searchForm;
    f.page.value = "1";
    f.submit();
}
</script>
</body>
</html>