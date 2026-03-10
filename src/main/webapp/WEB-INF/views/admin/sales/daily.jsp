<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 일별 매출</title>
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
                    <h3 class="fw-bold mb-2">일별 매출 내역</h3>
                    <p class="mb-0 text-muted">오늘의 실시간 매출과 최근 일주일간의 정산 현황입니다.</p>
                </div>
                <button class="btn btn-purple">일일 보고서 다운로드</button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="dashboard-box text-center">
                        <div class="stat-label">오늘 총 매출</div>
                        <div class="stat-value justify-content-center">₩1,250,000</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-box text-center">
                        <div class="stat-label">오늘 예약 건수</div>
                        <div class="stat-value justify-content-center">8건</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dashboard-box text-center">
                        <div class="stat-label">취소 및 환불</div>
                        <div class="stat-value justify-content-center text-danger">0건</div>
                    </div>
                </div>
            </div>

            <div class="dashboard-box">
                <h5 class="fw-bold text-main mb-4">최근 7일 상세 내역</h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th>날짜</th>
                                <th>결제 건수</th>
                                <th>매출액</th>
                                <th>환불액</th>
                                <th class="text-end">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">2026-03-10 (화)</td>
                                <td class="py-3 border-bottom border-secondary">8건</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">₩1,250,000</td>
                                <td class="py-3 border-bottom border-secondary text-muted">₩0</td>
                                <td class="py-3 border-bottom border-secondary text-end"><span class="badge-success">정산대기</span></td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">2026-03-09 (월)</td>
                                <td class="py-3 border-bottom border-secondary">5건</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">₩750,000</td>
                                <td class="py-3 border-bottom border-secondary text-muted">₩0</td>
                                <td class="py-3 border-bottom border-secondary text-end"><span class="badge-success">정산완료</span></td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom border-secondary">2026-03-08 (일)</td>
                                <td class="py-3 border-bottom border-secondary">15건</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">₩2,800,000</td>
                                <td class="py-3 border-bottom border-secondary text-danger">-₩150,000</td>
                                <td class="py-3 border-bottom border-secondary text-end"><span class="badge-success">정산완료</span></td>
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