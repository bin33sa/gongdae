<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 월별 매출</title>
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
                    <h3 class="fw-bold mb-2">월별 매출 통계</h3>
                    <p class="mb-0 text-muted">월간 수익 분석 및 성장 지표를 확인합니다.</p>
                </div>
                <button class="btn btn-purple">월간 정산 보고서</button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="dashboard-box">
                        <div class="stat-label">이번 달 누적 매출 (3월)</div>
                        <div class="stat-value">₩18,400,000 <span class="trend-badge">8.4% ↑</span></div>
                        <div class="progress mt-3" style="height: 8px; background-color: var(--border-color);">
                            <div class="progress-bar bg-primary" style="width: 74%;"></div>
                        </div>
                        <p class="text-muted small mt-2">목표 대비 74% 달성 중</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="dashboard-box">
                        <div class="stat-label">지난 달 총 매출 (2월)</div>
                        <div class="stat-value">₩16,980,000 <span class="trend-badge text-danger" style="color:#F87171 !important;">3.2% ↓</span></div>
                        <p class="text-muted small mt-3">전월 대비 소폭 상승 흐름</p>
                    </div>
                </div>
            </div>

            <div class="dashboard-box">
                <h5 class="fw-bold text-main mb-4">2026년 월별 수익 요약</h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th>해당 월</th>
                                <th>총 예약 건수</th>
                                <th>월간 매출액</th>
                                <th>전월 대비</th>
                                <th class="text-end">정산 상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">2026년 03월</td>
                                <td class="py-3 border-bottom border-secondary">142건</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">₩18,400,000</td>
                                <td class="py-3 border-bottom border-secondary text-success">+₩1,420,000</td>
                                <td class="py-3 border-bottom border-secondary text-end"><span class="badge-success" style="background-color: rgba(59, 130, 246, 0.15); color: #3B82F6 !important; border-color: rgba(59, 130, 246, 0.3) !important;">진행중</span></td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">2026년 02월</td>
                                <td class="py-3 border-bottom border-secondary">128건</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">₩16,980,000</td>
                                <td class="py-3 border-bottom border-secondary text-danger">-₩520,000</td>
                                <td class="py-3 border-bottom border-secondary text-end"><span class="badge-success">완료</span></td>
                            </tr>
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

</script>

</body>
</html>