<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 공지사항 관리</title>
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
                    <h3 class="fw-bold mb-2">공지사항 관리</h3>
                    <p class="mb-0 text-muted">서비스의 주요 소식 및 공지사항을 등록하고 편집합니다.</p>
                </div>
                <button class="btn btn-purple"><i class="bi bi-pencil me-2"></i>공지사항 작성</button>
            </div>

            <div class="dashboard-box">
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th>번호</th>
                                <th>구분</th>
                                <th>제목</th>
                                <th>조회수</th>
                                <th>등록일</th>
                                <th class="text-end">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="background-color: rgba(59, 130, 246, 0.05);">
                                <td><i class="bi bi-pin-angle-fill text-primary"></i></td>
                                <td><span class="badge bg-primary">중요</span></td>
                                <td class="fw-bold">[필독] 파티룸 예약 시스템 이용 약관 개정 안내</td>
                                <td>1,240</td>
                                <td class="small text-muted">2026-03-01</td>
                                <td class="text-end">
                                    <button class="btn btn-outline btn-sm me-1">수정</button>
                                    <button class="btn btn-outline btn-sm text-danger border-danger">삭제</button>
                                </td>
                            </tr>
                            <tr>
                                <td>12</td>
                                <td><span class="badge bg-secondary">일반</span></td>
                                <td>봄 시즌 홍대 지역 대관료 할인 이벤트 안내</td>
                                <td>452</td>
                                <td class="small text-muted">2026-03-08</td>
                                <td class="text-end">
                                    <button class="btn btn-outline btn-sm">수정</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <nav class="mt-4">
                    <ul class="pagination">
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                    </ul>
                </nav>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>