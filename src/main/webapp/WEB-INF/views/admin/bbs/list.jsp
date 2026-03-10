<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 게시글 관리</title>
</head>
<body class="admin-page">

<div class="admin-layout">
    <header class="admin-header">
        <div class="admin-logo">공대생</div>
        <div class="admin-user-area">
            <span><strong><sec:authentication property="principal.member.name"/></strong> 관리자님</span>
            <a href="${pageContext.request.contextPath}/member/logout" class="admin-logout">
                <i class="bi bi-box-arrow-right"></i> 로그아웃
            </a>
        </div>
    </header>

    <div class="admin-body">
        
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">전체 게시글 관리</h3>
                    <p class="mb-0 text-muted">사용자들이 작성한 커뮤니티 및 후기 게시글을 관리합니다.</p>
                </div>
                <button class="btn btn-purple">전체 게시글 다운로드</button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">오늘 등록된 글</div>
                        <div class="stat-value">42개 <span class="trend-badge">12.4% ↑</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">이번 주 누적</div>
                        <div class="stat-value">285개 <span class="trend-badge">3.1% ↑</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">신고된 게시글</div>
                        <div class="stat-value text-danger">5개 <span class="trend-badge" style="color:#F87171; background:rgba(239,68,68,0.1);">위험</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">전체 게시글 수</div>
                        <div class="stat-value">12,402개 <span class="trend-badge">0.8% ↑</span></div>
                    </div>
                </div>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold text-main m-0">게시글 상세 목록</h5>
                    <div class="d-flex gap-2">
                        <select class="form-select form-select-sm bg-dark text-white border-secondary" style="width: 120px;">
                            <option>전체보기</option>
                            <option>파티룸후기</option>
                            <option>자유게시판</option>
                        </select>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th class="fw-normal border-bottom border-secondary pb-3">번호</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">카테고리</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">제목</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">작성자</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">작성일</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-end">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">#882</td>
                                <td class="py-3 border-bottom border-secondary text-muted small">파티룸 후기</td>
                                <td class="py-3 border-bottom border-secondary fw-semibold">성수동 루프탑 파티 너무 즐거웠어요!</td>
                                <td class="py-3 border-bottom border-secondary">이대생</td>
                                <td class="py-3 border-bottom border-secondary text-muted small">2026-03-10</td>
                                <td class="py-3 border-bottom border-secondary text-end">
                                    <button class="btn btn-outline btn-sm">상세</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">#881</td>
                                <td class="py-3 border-bottom border-secondary text-muted small">자유게시판</td>
                                <td class="py-3 border-bottom border-secondary fw-semibold">홍대 근처 파티룸 추천해주실 분?</td>
                                <td class="py-3 border-bottom border-secondary">김철수</td>
                                <td class="py-3 border-bottom border-secondary text-muted small">2026-03-09</td>
                                <td class="py-3 border-bottom border-secondary text-end">
                                    <button class="btn btn-outline btn-sm">상세</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom-0">#880</td>
                                <td class="py-3 border-bottom-0 text-muted small">문의사항</td>
                                <td class="py-3 border-bottom-0 fw-semibold text-danger"><i class="bi bi-exclamation-triangle me-1"></i>부적절한 홍보글입니다.</td>
                                <td class="py-3 border-bottom-0">광고봇01</td>
                                <td class="py-3 border-bottom-0 text-muted small">2026-03-09</td>
                                <td class="py-3 border-bottom-0 text-end">
                                    <button class="btn btn-outline btn-sm text-danger border-danger">삭제</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <nav class="mt-4">
                    <ul class="pagination">
                        <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">다음</a></li>
                    </ul>
                </nav>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>