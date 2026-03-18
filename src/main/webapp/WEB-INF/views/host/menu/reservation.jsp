<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 내역 - 공대생 호스트 센터</title>

    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

    <!-- 예약 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/reservation.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">

    <!-- 타이틀 -->
    <div class="mb-4">
        <h3 class="fw-bold">예약 내역</h3>
        <p class="text-muted">전체 예약 현황을 확인하고 관리하세요.</p>
    </div>

    <!-- 필터 -->
    <div class="reservation-filter-box mb-4">
        <div class="row g-3 align-items-end">

            <div class="col-md-3">
                <label class="form-label small">기간</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-md-3">
                <label class="form-label small">~</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-md-3">
                <label class="form-label small">상태</label>
                <select class="form-select">
                    <option>전체</option>
                    <option>예약 완료</option>
                    <option>이용 중</option>
                    <option>이용 완료</option>
                    <option>취소</option>
                </select>
            </div>

            <div class="col-md-3">
                <button class="btn btn-search w-100">조회하기</button>
            </div>

        </div>
    </div>

    <!-- 테이블 -->
    <div class="reservation-table-box">

        <div class="table-header">
            <h5 class="fw-bold m-0">예약 리스트</h5>
        </div>

        <table class="table reservation-table">
            <thead>
                <tr>
                    <th>예약번호</th>
                    <th>예약일</th>
                    <th>매장명</th>
                    <th>예약자</th>
                    <th>이용시간</th>
                    <th>금액</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td>#R1023</td>
                    <td>2026-03-18</td>
                    <td>홍대 루프탑 파티룸</td>
                    <td>김공대</td>
                    <td>18:00 ~ 21:00</td>
                    <td>₩ 150,000</td>
                    <td><span class="badge badge-active">이용 중</span></td>
                </tr>

                <tr>
                    <td>#R1022</td>
                    <td>2026-03-17</td>
                    <td>강남 스터디룸 A호</td>
                    <td>이학생</td>
                    <td>10:00 ~ 13:00</td>
                    <td>₩ 80,000</td>
                    <td><span class="badge badge-done">이용 완료</span></td>
                </tr>

                <tr>
                    <td>#R1021</td>
                    <td>2026-03-16</td>
                    <td>홍대 루프탑 파티룸</td>
                    <td>박게스트</td>
                    <td>20:00 ~ 23:00</td>
                    <td>₩ 120,000</td>
                    <td><span class="badge badge-cancel">취소</span></td>
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