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

}

.review-container{
    width:600px;
    margin:60px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
}

h2{
    margin-bottom:25px;
}

/* 공간 정보 */

.space-info{
    display:flex;
    gap:15px;
    align-items:center;
    margin-bottom:25px;
}

.space-info img{
    width:120px;
    border-radius:8px;
}

.space-text h3{
    margin:0;
}

.space-text p{
    margin-top:5px;
    color:#777;
}


/* 후기 입력 */

.review-section{
    margin-bottom:20px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:bold;
}

textarea{
    width:100%;
    height:120px;
    padding:10px;
    border:1px solid #ddd;
    border-radius:6px;
    resize:none;
}

/* 별점 */

.star-rating{
    display:flex;
    flex-direction:row-reverse;
    font-size:30px;
}

.star-rating input{
    display:none;
}

.star-rating label{
    color:#ddd;
    cursor:pointer;
}

.star-rating input:checked ~ label{
    color:#ffc107;
}

.star-rating label:hover,
.star-rating label:hover ~ label{
    color:#ffc107;
}

/* 버튼 */

.review-btn{
    width:100%;
    padding:14px;
    font-size:16px;
    border:none;
    border-radius:8px;
    background:#ff5a5f;
    color:white;
    cursor:pointer;
}

.review-btn:hover{
    background:#ff4146;
}

</style>

</head>

<body>

<%@ page contentType="text/html; charset=UTF-8" %>

<div class="section">

<div class="container">

    <h2>후기 작성</h2>

    <!-- 공간 정보 -->
    <div class="space-info">
        <img src="https://via.placeholder.com/120" alt="공간 이미지">
        <div class="space-text">
            <h3>강남 스튜디오</h3>
            <p>2026.03.10 이용</p>
        </div>
    </div>

    <!-- 별점 -->
    <div class="review-section">
        <label>공간 만족도</label>

        <div class="star-rating">
            <input type="radio" name="rating" id="star5"><label for="star5">★</label>
            <input type="radio" name="rating" id="star4"><label for="star4">★</label>
            <input type="radio" name="rating" id="star3"><label for="star3">★</label>
            <input type="radio" name="rating" id="star2"><label for="star2">★</label>
            <input type="radio" name="rating" id="star1"><label for="star1">★</label>
        </div>
    </div>

    <!-- 후기 내용 -->
    <div class="review-section">
        <label>후기 내용</label>
        <textarea placeholder="공간 이용 후기를 작성해주세요"></textarea>
    </div>

    <!-- 사진 업로드 -->
    <div class="review-section">
        <label>사진 업로드</label>
        <input type="file" multiple>
    </div>

    <!-- 버튼 -->
    <button class="review-btn">후기 등록</button>

</div>
</div>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>


</html>