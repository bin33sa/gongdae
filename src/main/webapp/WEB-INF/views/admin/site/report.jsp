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
    <header class="admin-header">
        <div class="admin-logo">공대생</div>
        <div class="admin-user-area">
            <span><strong><sec:authentication property="principal.member.name"/></strong> 관리자님</span>
            <a href="${pageContext.request.contextPath}/member/logout" class="admin-logout"><i class="bi bi-box-arrow-right"></i> 로그아웃</a>
        </div>
    </header>
    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">신고 내역 관리</h3>
                    <p class="mb-0 text-muted">서비스 정책 위반 신고 건을 검토하고 처리합니다.</p>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-outline-secondary text-white border-secondary">미처리 건만 보기</button>
                </div>
            </div>

            <div class="dashboard-box">
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th>번호</th>
                                <th>신고유형</th>
                                <th>피신고자(ID)</th>
                                <th>신고 사유</th>
                                <th>신고일</th>
                                <th class="text-end">처리상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#R-102</td>
                                <td><span class="badge bg-secondary">허위정보</span></td>
                                <td class="fw-bold">이대생 (host01)</td>
                                <td class="text-truncate" style="max-width: 200px;">파티룸 사진과 실물이 너무 다릅니다.</td>
                                <td class="small text-muted">2026-03-10</td>
                                <td class="text-end"><span class="badge-success" style="background-color: rgba(59, 130, 246, 0.15); color: #3B82F6 !important;">검토중</span></td>
                            </tr>
                            <tr>
                                <td>#R-101</td>
                                <td><span class="badge bg-secondary">욕설/비방</span></td>
                                <td class="fw-bold">김철수 (guest99)</td>
                                <td class="text-truncate" style="max-width: 200px;">호스트에게 무례한 채팅을 보냈습니다.</td>
                                <td class="small text-muted">2026-03-09</td>
                                <td class="text-end"><span class="badge-success">처리완료</span></td>
                            </tr>
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