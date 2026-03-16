<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 마일리지 내역</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style>

.mileage-page{
padding:60px 0;
background:#f8f9ff;
min-height:600px;
}

.mileage-container{
width:100%;
max-width:1000px;
margin:auto;
}

.mileage-title{
font-size:30px;
font-weight:700;
text-align:center;
margin-bottom:10px;
}

.mileage-sub{
text-align:center;
color:#777;
margin-bottom:30px;
}

.mileage-current{
background:#fff;
padding:25px;
border-radius:16px;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
text-align:center;
margin-bottom:40px;
}

.mileage-current span{
font-size:34px;
font-weight:700;
color:#6366f1;
}

.mileage-table{
width:100%;
border-collapse:collapse;
background:#fff;
border-radius:16px;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

.mileage-table th{
background:#f1f5ff;
padding:15px;
font-weight:600;
text-align:center;
}

.mileage-table td{
padding:15px;
border-top:1px solid #eee;
text-align:center;
font-size:14px;
}

.mileage-plus{
color:#16a34a;
font-weight:600;
}

.mileage-minus{
color:#dc2626;
font-weight:600;
}

</style>

</head>

<body>

<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<main class="mileage-page">

<div class="mileage-container">

<div class="mileage-title">나의 마일리지</div>
<div class="mileage-sub">적립 및 사용 내역을 확인할 수 있습니다.</div>


<div class="mileage-current">
현재 보유 마일리지<br>
<span>12,500 P</span>
</div>


<table class="mileage-table">

<thead>
<tr>
<th>날짜</th>
<th>내용</th>
<th>변동 마일리지</th>
<th>누적 마일리지</th>
</tr>
</thead>

<tbody>

<tr>
<td>2026-03-16 18:21</td>
<td>공간 예약 이용 적립</td>
<td class="mileage-plus">+500 P</td>
<td>12,500 P</td>
</tr>

<tr>
<td>2026-03-15 12:03</td>
<td>공간 예약 결제 사용</td>
<td class="mileage-minus">-2,000 P</td>
<td>12,000 P</td>
</tr>

<tr>
<td>2026-03-14 09:45</td>
<td>이벤트 참여 적립</td>
<td class="mileage-plus">+1,000 P</td>
<td>14,000 P</td>
</tr>

<tr>
<td>2026-03-12 15:30</td>
<td>첫 가입 보너스</td>
<td class="mileage-plus">+5,000 P</td>
<td>13,000 P</td>
</tr>

<tr>
<td>2026-03-10 10:15</td>
<td>공간 예약 이용</td>
<td class="mileage-minus">-1,500 P</td>
<td>8,000 P</td>
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