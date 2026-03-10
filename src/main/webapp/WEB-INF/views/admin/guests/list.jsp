<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 게스트 관리</title>
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
                    <h3 class="fw-bold mb-2">게스트 회원 관리</h3>
                    <p class="mb-0 text-muted">파티룸을 이용하는 일반 유저 목록을 조회하고 관리합니다.</p>
                </div>
                <button class="btn btn-purple"><i class="bi bi-download me-2"></i>엑셀 다운로드</button>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex gap-2">
                        <select class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                            <option value="all">전체 상태</option>
                            <option value="active">정상 이용</option>
                            <option value="banned">이용 정지</option>
                        </select>
                        <select class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                            <option value="name">이름</option>
                            <option value="email">이메일</option>
                        </select>
                        <div class="input-group" style="width: 250px;">
                            <input type="text" class="form-control bg-transparent text-main border-secondary" placeholder="검색어 입력">
                            <button class="btn btn-outline-secondary" type="button"><i class="bi bi-search"></i></button>
                        </div>
                    </div>
                    <div class="text-muted small">총 <strong class="text-main">1,204</strong>명의 게스트</div>
                </div>

                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th class="fw-normal border-bottom border-secondary pb-3">회원번호</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">이름</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">이메일</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-center">총 예약건수</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-center">가입일</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-center">상태</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-end">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="py-3 border-bottom border-secondary text-muted">#G-8932</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">김민준</td>
                                <td class="py-3 border-bottom border-secondary">minjun.k@example.com</td>
                                <td class="py-3 border-bottom border-secondary text-center text-info fw-bold">12건</td>
                                <td class="py-3 border-bottom border-secondary text-center text-muted small">2025-10-15</td>
                                <td class="py-3 border-bottom border-secondary text-center"><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">정상</span></td>
                                <td class="py-3 border-bottom border-secondary text-end">
                                    <button class="btn btn-sm btn-outline-secondary">상세</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom border-secondary text-muted">#G-8931</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">이지은</td>
                                <td class="py-3 border-bottom border-secondary">jieun_lee@test.com</td>
                                <td class="py-3 border-bottom border-secondary text-center fw-bold">3건</td>
                                <td class="py-3 border-bottom border-secondary text-center text-muted small">2026-01-22</td>
                                <td class="py-3 border-bottom border-secondary text-center"><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">정상</span></td>
                                <td class="py-3 border-bottom border-secondary text-end">
                                    <button class="btn btn-sm btn-outline-secondary">상세</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom-0 text-muted">#G-8930</td>
                                <td class="py-3 border-bottom-0 fw-bold text-decoration-line-through text-muted">박서준</td>
                                <td class="py-3 border-bottom-0 text-muted">bad_user@spam.com</td>
                                <td class="py-3 border-bottom-0 text-center fw-bold text-muted">0건</td>
                                <td class="py-3 border-bottom-0 text-center text-muted small">2026-03-01</td>
                                <td class="py-3 border-bottom-0 text-center"><span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">정지</span></td>
                                <td class="py-3 border-bottom-0 text-end">
                                    <button class="btn btn-sm btn-outline-secondary">상세</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-center mt-4 pt-3 border-top border-secondary border-opacity-25">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item disabled"><a class="page-link bg-transparent border-secondary text-muted" href="#">이전</a></li>
                        <li class="page-item active"><a class="page-link border-primary" style="background-color: var(--accent-main);" href="#">1</a></li>
                        <li class="page-item"><a class="page-link bg-transparent border-secondary text-muted" href="#">2</a></li>
                        <li class="page-item"><a class="page-link bg-transparent border-secondary text-muted" href="#">3</a></li>
                        <li class="page-item"><a class="page-link bg-transparent border-secondary text-muted" href="#">다음</a></li>
                    </ul>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>