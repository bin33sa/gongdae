<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>호스트 대시보드 - 공대생</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    
    <style>
        body { background-color: #f4f6f9; font-family: 'Pretendard', sans-serif; }
        
        /* 호스트 전용 포인트 컬러 (사이드바와 맞춘 붉은색 톤) */
        :root {
            --host-primary: #E53935;
        }

        .dashboard-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .page-title { font-size: 1.5rem; font-weight: bold; color: #333; margin-bottom: 24px; }
        
        /* 요약 카드 스타일 */
        .stat-card {
            background: #fff;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: none;
            height: 100%;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 16px;
        }
        .icon-blue { background-color: #e3f2fd; color: #1976d2; }
        .icon-red { background-color: #ffebee; color: #d32f2f; }
        .icon-yellow { background-color: #fff8e1; color: #fbc02d; }
        .icon-green { background-color: #e8f5e9; color: #388e3c; }
        
        .stat-title { font-size: 0.9rem; color: #666; margin-bottom: 8px; }
        .stat-value { font-size: 1.8rem; font-weight: bold; color: #222; margin-bottom: 0; }
        
        /* 테이블/리스트 영역 카드 */
        .content-card {
            background: #fff;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            margin-bottom: 24px;
        }
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .content-title { font-size: 1.1rem; font-weight: bold; margin: 0; }
        .btn-more { font-size: 0.85rem; color: #666; text-decoration: none; }
        .btn-more:hover { color: var(--host-primary); }
        
        /* 배지 스타일 */
        .badge-pending { background-color: #ffebee; color: #d32f2f; padding: 6px 10px; font-weight: normal; }
        .badge-approved { background-color: #e8f5e9; color: #388e3c; padding: 6px 10px; font-weight: normal; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>

    <main class="dashboard-container">
        <%-- <sec:authentication property="principal.member" var="hostInfo"/> --%>

<h2 class="page-title">안녕하세요, 테스트 호스트님! (UI 확인용) <i class="bi bi-emoji-smile text-warning"></i></h2>
        <div class="row g-4 mb-4">
            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="stat-icon icon-red"><i class="bi bi-bell-fill"></i></div>
                    <div class="stat-title">승인 대기 예약</div>
                    <div class="stat-value">3<span style="font-size:1rem; color:#888; font-weight:normal;"> 건</span></div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="stat-icon icon-blue"><i class="bi bi-calendar-check-fill"></i></div>
                    <div class="stat-title">오늘 이용 공간</div>
                    <div class="stat-value">2<span style="font-size:1rem; color:#888; font-weight:normal;"> 건</span></div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="stat-icon icon-yellow"><i class="bi bi-chat-dots-fill"></i></div>
                    <div class="stat-title">미답변 QNA</div>
                    <div class="stat-value">1<span style="font-size:1rem; color:#888; font-weight:normal;"> 건</span></div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-card">
                    <div class="stat-icon icon-green"><i class="bi bi-cash-stack"></i></div>
                    <div class="stat-title">이번 달 정산 예정액</div>
                    <div class="stat-value">450,000<span style="font-size:1rem; color:#888; font-weight:normal;"> 원</span></div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="content-card h-100">
                    <div class="content-header">
                        <h3 class="content-title">최근 예약 요청</h3>
                        <a href="<c:url value='/host/reservation'/>" class="btn-more">전체보기 <i class="bi bi-chevron-right"></i></a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>공간명</th>
                                    <th>예약자</th>
                                    <th>이용일정</th>
                                    <th>상태</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- <c:if test="${empty reservationList}">
                                    <tr><td colspan="5" class="text-center py-4 text-muted">최근 예약 내역이 없습니다.</td></tr>
                                </c:if> --%>
                                
                                <tr>
                                    <td class="fw-bold">홍대 루프탑 파티룸</td>
                                    <td>김게스트</td>
                                    <td>2026.03.10 14:00~18:00</td>
                                    <td><span class="badge rounded-pill badge-pending">승인대기</span></td>
                                    <td><button class="btn btn-sm btn-outline-danger">예약관리</button></td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">사당역 전면거울 댄스룸</td>
                                    <td>이회원</td>
                                    <td>2026.03.05 10:00~12:00</td>
                                    <td><span class="badge rounded-pill badge-approved">예약확정</span></td>
                                    <td><button class="btn btn-sm btn-outline-secondary">상세보기</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="content-card h-100">
                    <div class="content-header">
                        <h3 class="content-title">내 공간 관리</h3>
                        <a href="<c:url value='/host/menu/store'/>" class="btn-more">관리하기 <i class="bi bi-chevron-right"></i></a>
                    </div>
                    
                    <div class="d-grid gap-3">
                        <a href="<c:url value='/host/space/write'/>" class="btn btn-primary py-2 fw-bold" style="background-color: var(--host-primary); border: none;">
                            <i class="bi bi-plus-circle me-1"></i> 새 공간 등록하기
                        </a>
                        
                        <div class="border rounded p-3 mt-2 d-flex justify-content-between align-items-center">
                            <div>
                                <div class="text-muted small">운영 중인 공간</div>
                                <div class="fw-bold fs-5">2 개</div>
                            </div>
                            <i class="bi bi-shop text-muted fs-3"></i>
                        </div>
                        
                        <div class="border rounded p-3 d-flex justify-content-between align-items-center">
                            <div>
                                <div class="text-muted small">검수 대기 중</div>
                                <div class="fw-bold fs-5 text-danger">1 개</div>
                            </div>
                            <i class="bi bi-hourglass-split text-muted fs-3"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>
</body>
</html>