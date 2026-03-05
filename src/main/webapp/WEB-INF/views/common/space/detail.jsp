<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style type="text/css">
.detail-container{
    max-width:1200px;
    margin:auto;
    display:flex;
    gap:40px;
    padding:40px 20px;
}

/* 왼쪽 공간 정보 */
.space-info{
    flex:2;
}

/* 오른쪽 예약 영역 */
.reservation-box{
    flex:1;
}

/* 스크롤 따라오는 핵심 */
.reservation-inner{
    position:sticky;
    top:100px;

    border:1px solid #ddd;
    border-radius:10px;
    padding:20px;
    background:#fff;

    box-shadow:0 2px 10px rgba(0,0,0,0.08);
}

.section{
    margin-top:40px;
}

label{
    display:block;
    margin-top:15px;
    font-weight:bold;
}

input, select{
    width:100%;
    padding:8px;
    margin-top:5px;
}

.reserve-btn{
    margin-top:20px;
    width:100%;
    padding:12px;
    background:#ff5a5f;
    color:white;
    border:none;
    border-radius:6px;
    font-size:16px;
    cursor:pointer;
}
</style>

</head>
<body>


<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>


<main>

<div class="detail-container">

    <!-- 공간 상세 정보 -->
    <div class="space-info">
        <h1>공간 이름</h1>
        <p>공간 소개 내용이 들어갑니다.</p>

        <div class="section">
            <h3>공간 소개</h3>
            <p>
                여기에 긴 공간 설명이 들어갑니다.
                여기에 긴 공간 설명이 들어갑니다.
                여기에 긴 공간 설명이 들어갑니다.
            </p>
        </div>

        <div class="section">
            <h3>시설 안내</h3>
            <p>WiFi / 빔프로젝터 / 주차 가능</p>
        </div>

        <div class="section">
            <h3>이용 안내</h3>
            <p>예약 후 사용 가능합니다.</p>
        </div>

        <div style="height:1000px"></div>
    </div>


    <!-- 예약 영역 -->
    <div class="reservation-box">
        <div class="reservation-inner">

            <h3>예약하기</h3>

            <label>날짜</label>
            <input type="date">

            <label>시간</label>
            <select>
                <option>10:00</option>
                <option>11:00</option>
                <option>12:00</option>
            </select>

            <label>옵션</label>
            <div>
                <input type="checkbox"> 빔프로젝터
            </div>
            <div>
                <input type="checkbox"> 마이크
            </div>

            <button class="reserve-btn" onclick="location.href='${pageContext.request.contextPath}/space/payment'">예약하기</button>

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