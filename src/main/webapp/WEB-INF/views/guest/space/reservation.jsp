<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>예약목록</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/guest/reservation.css" type="text/css">

</head>


<body>


<header>
	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>



<main>

<section class="section reservation-page">

<div class="container">

<!-- 페이지 헤더 -->

<div class="reservation-header">

<h2 class="section-title">
예약 내역
</h2>

<p class="section-desc">
내가 예약한 공간을 확인할 수 있습니다
</p>

</div>



<!-- 예약 테이블 -->

<div class="reservation-table-wrap">

<table class="reservation-table">

<thead>

<tr>
<th>예약번호</th>
<th>공간</th>
<th>예약날짜</th>
<th>시간</th>
<th>인원</th>
<th>결제금액</th>
<th>상태</th>
<th>관리</th>
</tr>

</thead>

<tbody>

<tr>

<td>1023</td>
<td>강남 스터디룸</td>
<td>2026-03-10</td>
<td>14:00 ~ 16:00</td>
<td>4명</td>
<td>40,000원</td>

<td>
<span class="status reserved">예약완료</span>
</td>

<td>
<button class="btn-reservation">상세</button>
</td>

</tr>


<tr>

<td>1022</td>
<td>홍대 연습실</td>
<td>2026-03-08</td>
<td>19:00 ~ 21:00</td>
<td>3명</td>
<td>30,000원</td>

<td>
<span class="status done">이용완료</span>
</td>

<td>
<button class="btn-reservation"
onclick="location.href='${pageContext.request.contextPath}/review/write'">
후기 작성
</button>
</td>

</tr>


<tr>

<td>1021</td>
<td>회의실 A</td>
<td>2026-03-05</td>
<td>10:00 ~ 12:00</td>
<td>5명</td>
<td>50,000원</td>

<td>
<span class="status cancel">취소</span>
</td>

<td>
<button class="btn-reservation">상세</button>
</td>

</tr>

</tbody>

</table>

</div>



<!-- 페이지네이션 -->

<div class="reservation-pagination">

<button class="page-btn prev">
<i class="bi bi-chevron-left"></i>
</button>

<button class="page-btn active">1</button>
<button class="page-btn">2</button>
<button class="page-btn">3</button>

<button class="page-btn next">
<i class="bi bi-chevron-right"></i>
</button>

</div>


</div>

</section>

</main>



<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>


<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>


</body>

</html>