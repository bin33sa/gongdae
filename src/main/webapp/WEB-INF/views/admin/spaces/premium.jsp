<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
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
            </div>
            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <form name="searchForm" action="${pageContext.request.contextPath}/admin/spaces/premium" method="get">
                        <select name="premiumStatus" class="form-select bg-transparent text-main border-secondary" style="width: 160px;" onchange="this.form.submit()">
                            <option value="ACTIVE" ${premiumStatus == 'ACTIVE' ? 'selected' : ''} style="color: #34D399;">★ 현재 적용중</option>
                            <option value="CANCELED" ${premiumStatus == 'CANCELED' ? 'selected' : ''}>만료/취소 내역</option>
                            <option value="" ${premiumStatus == '' ? 'selected' : ''}>전체 이력 보기</option>
                        </select>
                    </form>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>건 조회됨</div>
                </div>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle text-center">
                        <thead>
                            <tr>
                                <th class="admin-th">No.</th>
                                <th class="admin-th text-start">공간명</th>
                                <th class="admin-th">호스트</th>
                                <th class="admin-th">처리 일자</th>
                                <th class="admin-th">상태</th>
                                <th class="admin-th text-end">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr><td colspan="6" class="admin-td py-5 text-muted">조건에 맞는 내역이 없습니다.</td></tr>
                            </c:if>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="admin-td text-muted">${dto.premiumNo}</td>
                                    <td class="admin-td fw-bold text-start text-truncate" style="max-width: 250px;">${dto.spaceName}</td>
                                    <td class="admin-td">${dto.hostName}</td>
                                    <td class="admin-td text-muted small-txt">${dto.appliedAt}</td>
                                    <td class="admin-td">
                                        <c:choose>
                                            <c:when test="${dto.premiumStatus == 'PENDING'}"><span class="badge bg-danger">신청 대기</span></c:when>
                                            <c:when test="${dto.premiumStatus == 'ACTIVE'}"><span class="badge bg-success">적용중</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">취소/만료</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td text-end">
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
</body>
</html>