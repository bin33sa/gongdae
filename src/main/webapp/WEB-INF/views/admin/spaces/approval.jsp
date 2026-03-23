<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 통합 결재함</title>
</head>
<body class="admin-page">
<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content flex-grow-1 p-4" style="width: 0;">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">통합 결재 관리함</h3>
                    <p class="mb-0 text-muted">신규 등록 및 프리미엄 신청 등 관리자 승인이 필요한 내역을 처리합니다.</p>
                </div>
            </div>

            <div class="dashboard-box mb-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-main m-0"><i class="bi bi-shop me-2 text-primary"></i>신규 매장 승인 대기</h5>
                    <span class="badge bg-primary rounded-pill">${spaceCount}건 대기중</span>
                </div>
                <div class="table-responsive" style="max-height: 350px; overflow-y: auto;">
                    <table class="table text-main mb-0 align-middle text-center">
                        <thead>
                            <tr>
                                <th class="admin-th">공간번호</th>
                                <th class="admin-th text-start">공간명</th>
                                <th class="admin-th">호스트</th>
                                <th class="admin-th">신청일</th>
                                <th class="admin-th text-end">결재하기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty spaceList}">
                                <tr><td colspan="5" class="admin-td py-5 text-muted">승인 대기 중인 신규 매장이 없습니다.</td></tr>
                            </c:if>
                            <c:forEach var="dto" items="${spaceList}">
                                <tr>
                                    <td class="admin-td text-muted">#S-${dto.spaceNo}</td>
                                    <td class="admin-td fw-bold text-start text-truncate" style="max-width: 250px;">
                                        <span class="badge bg-secondary bg-opacity-25 text-muted me-2">${dto.categoryName}</span>
                                        ${dto.spaceName}
                                    </td>
                                    <td class="admin-td">${dto.hostName}</td>
                                    <td class="admin-td text-muted small-txt">${dto.createdAt}</td>
                                    <td class="admin-td text-end">
                                        <button class="btn btn-sm btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/admin/spaces/detail/${dto.spaceNo}?from=approval';">상세 심사</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-main m-0"><i class="bi bi-star-fill text-warning me-2"></i>프리미엄 승인 대기</h5>
                    <span class="badge bg-warning text-dark rounded-pill">${premiumCount}건 대기중</span>
                </div>
                <div class="table-responsive" style="max-height: 350px; overflow-y: auto;">
                    <table class="table text-main mb-0 align-middle text-center">
                        <thead>
                            <tr>
                                <th class="admin-th">신청번호</th>
                                <th class="admin-th text-start">공간명</th>
                                <th class="admin-th">호스트</th>
                                <th class="admin-th">신청일시</th>
                                <th class="admin-th text-end">결재하기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty premiumList}">
                                <tr><td colspan="5" class="admin-td py-5 text-muted">승인 대기 중인 프리미엄 내역이 없습니다.</td></tr>
                            </c:if>
                            <c:forEach var="dto" items="${premiumList}">
                                <tr>
                                    <td class="admin-td text-muted">#P-${dto.premiumNo}</td>
                                    <td class="admin-td fw-bold text-start text-truncate" style="max-width: 250px;">${dto.spaceName}</td>
                                    <td class="admin-td">${dto.hostName}</td>
                                    <td class="admin-td text-muted small-txt">${dto.appliedAt}</td>
                                    <td class="admin-td text-end">
                                        <button class="btn btn-sm btn-outline-warning text-dark" onclick="location.href='${pageContext.request.contextPath}/admin/spaces/detail/${dto.spaceNo}?from=approval';">상세 심사</button>
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
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>