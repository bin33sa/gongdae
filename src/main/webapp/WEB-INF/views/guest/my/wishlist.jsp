<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 찜한 공간</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style>

.wishlist-page{
padding:60px 0;
background:#f8f9ff;
min-height:600px;
}

.wishlist-container{
max-width:1100px;
margin:auto;
}

.wishlist-title{
font-size:30px;
font-weight:700;
text-align:center;
margin-bottom:10px;
}

.wishlist-sub{
text-align:center;
color:#777;
margin-bottom:40px;
}

.wishlist-grid{
display:grid;
grid-template-columns:repeat(auto-fill, minmax(260px,1fr));
gap:25px;
}

.space-card{
background:#fff;
border-radius:16px;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
transition:0.2s;
}

.space-card:hover{
transform:translateY(-4px);
}

.space-img{
width:100%;
height:170px;
object-fit:cover;
background:#ddd;
}

.space-body{
padding:18px;
}

.space-name{
font-size:18px;
font-weight:700;
margin-bottom:6px;
}

.space-location{
font-size:14px;
color:#777;
margin-bottom:10px;
}

.space-price{
font-size:16px;
font-weight:600;
color:#6366f1;
margin-bottom:12px;
}

.space-btn{
display:flex;
justify-content:space-between;
align-items:center;
}

.btn-detail{
padding:6px 12px;
border-radius:8px;
background:#6366f1;
color:#fff;
font-size:13px;
text-decoration:none;
}

.btn-like-cancel{
padding:6px 12px;
border-radius:8px;
background:#ef4444;
color:#fff;
font-size:13px;
border:none;
cursor:pointer;
}

</style>

</head>

<body>

<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<main class="wishlist-page">

<div class="wishlist-container">

<div class="wishlist-title">내가 찜한 공간</div>
<div class="wishlist-sub">관심 공간을 한눈에 확인할 수 있습니다.</div>


<div class="wishlist-grid">


<div class="space-card">

<img class="space-img" src="https://picsum.photos/400/300?random=1">

<div class="space-body">

<div class="space-name">강남 스터디룸</div>
<div class="space-location">서울 강남구</div>
<div class="space-price">시간당 15,000원</div>

<div class="space-btn">
<a href="#" class="btn-detail">상세보기</a>
<button class="btn-like-cancel">찜 취소</button>
</div>

</div>

</div>


<div class="space-card">

<img class="space-img" src="https://picsum.photos/400/300?random=2">

<div class="space-body">

<div class="space-name">홍대 파티룸</div>
<div class="space-location">서울 마포구</div>
<div class="space-price">시간당 30,000원</div>

<div class="space-btn">
<a href="#" class="btn-detail">상세보기</a>
<button class="btn-like-cancel">찜 취소</button>
</div>

</div>

</div>


<div class="space-card">

<img class="space-img" src="https://picsum.photos/400/300?random=3">

<div class="space-body">

<div class="space-name">역삼 회의실</div>
<div class="space-location">서울 강남구</div>
<div class="space-price">시간당 20,000원</div>

<div class="space-btn">
<a href="#" class="btn-detail">상세보기</a>
<button class="btn-like-cancel">찜 취소</button>
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