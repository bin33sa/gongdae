<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상세매출 - 공대생 호스트 센터</title>

    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

    <!-- 🔥 상세매출 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/sales.css">

</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">

    <!-- 페이지 타이틀 -->
    <div class="mb-4">
        <h3 class="fw-bold">상세 매출</h3>
        <p class="text-muted">매장별 매출과 정산 내역을 확인하세요.</p>
    </div>

    <!-- 필터 영역 -->
    <div class="sales-filter-box mb-4">
        <div class="row g-3 align-items-end">

            <div class="col-md-3">
                <label class="form-label small">기간 선택</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-md-3">
                <label class="form-label small">~</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-md-3">
                <label class="form-label small">매장 선택</label>
                <select class="form-select">
                    <option>전체 매장</option>
                    <option>홍대 루프탑 파티룸</option>
                    <option>강남 스터디룸 A호</option>
                </select>
            </div>

            <div class="col-md-3">
                <button class="btn btn-search w-100">조회하기</button>
            </div>

        </div>
    </div>

    <!-- 요약 카드 -->
    <div class="row g-3 mb-4">

        <div class="col-md-4">
            <div class="sales-card">
                <div class="card-title">총 매출</div>
                <div class="card-value">₩ 1,250,000</div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="sales-card">
                <div class="card-title">예약 건수</div>
                <div class="card-value">32건</div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="sales-card">
                <div class="card-title">정산 예정 금액</div>
                <div class="card-value text-danger">₩ 980,000</div>
            </div>
        </div>

    </div>

    <!-- 테이블 -->
    <div class="sales-table-box">

        <div class="table-header">
            <h5 class="fw-bold m-0">매출 상세 내역</h5>
        </div>

        <table class="table sales-table">
            <thead>
                <tr>
                    <th>날짜</th>
                    <th>매장명</th>
                    <th>예약자</th>
                    <th>금액</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>2026-03-12</td>
                    <td>홍대 루프탑 파티룸</td>
                    <td>김공대</td>
                    <td>₩ 150,000</td>
                    <td><span class="badge badge-done">정산 완료</span></td>
                </tr>
                <tr>
                    <td>2026-03-11</td>
                    <td>강남 스터디룸 A호</td>
                    <td>이학생</td>
                    <td>₩ 80,000</td>
                    <td><span class="badge badge-wait">정산 대기</span></td>
                </tr>
            </tbody>
        </table>

    </div>

</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>