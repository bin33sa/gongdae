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
</head>
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<style>

.reservation-page{
padding:60px 0;
background:#fff7f9;
}

.reservation-header{
text-align:center;
margin-bottom:40px;
}

.reservation-header h2{
font-size:32px;
font-weight:700;
margin-bottom:10px;
}

.reservation-header p{
color:#777;
}

/* 테이블 */

.reservation-table{
width:100%;
border-collapse:collapse;
background:#fff;
border-radius:12px;
overflow:hidden;
box-shadow:0 5px 15px rgba(0,0,0,0.05);
}

.reservation-table thead{
background:#ffe3ea;
}

.reservation-table th{
padding:14px;
font-weight:600;
font-size:14px;
}

.reservation-table td{
padding:16px;
border-top:1px solid #f0f0f0;
font-size:14px;
text-align:center;
}

.reservation-table tr:hover{
background:#fff1f4;
}

/* 상태 배지 */

.status{
padding:6px 12px;
border-radius:20px;
font-size:12px;
font-weight:600;
}

.status.reserved{
background:#ffe0e6;
color:#ff3c6f;
}

.status.done{
background:#e6f7ff;
color:#0077cc;
}

.status.cancel{
background:#eee;
color:#777;
}

/* 버튼 */

.btn-detail{
background:#ff6b8a;
color:#fff;
border:none;
padding:6px 12px;
border-radius:20px;
font-size:12px;
cursor:pointer;
}

.btn-detail:hover{
background:#ff4c70;
}

/* 페이지네이션 */

.reservation-pagination{
text-align:center;
margin-top:40px;
}

.reservation-pagination span{
font-size:18px;
margin:0 10px;
cursor:pointer;
font-weight:600;
}

.reservation-pagination span:hover{
color:#ff6b8a;
}

</style>

</head>

<body>

<%@ page contentType="text/html; charset=UTF-8" %>

<div class="reservation-page">

<div class="container">

<div class="reservation-header">
<h2>예약 내역</h2>
<p>내가 예약한 공간을 확인할 수 있습니다</p>
</div>


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
<button class="btn-detail">상세</button>
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
<button class="btn-detail" onclick="location.href='${pageContext.request.contextPath}/review/write'">후기 작성</button>
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
<button class="btn-detail">상세</button>
</td>

</tr>

</tbody>

</table>


<div class="reservation-pagination">

<span>1</span>
<span>2</span>
<span>3</span>

</div>


</div>
</div>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>


</html>