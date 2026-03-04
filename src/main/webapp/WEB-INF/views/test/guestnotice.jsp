<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항 목록</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
</head>
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<style>
/* 공지 페이지 전용 */

.notice-page{
    background:#fff;
    padding:40px 0;
}


/* 검색 */

.notice-page .notice-search{
    max-width:600px;
    margin:40px auto 25px auto;
}

.notice-page .notice-search input{
    border-radius:30px;
    height:48px;
    border:2px solid #ffd6de;
    background:#fff;
}

.notice-page .notice-search input:focus{
    border-color:#ff6b8a;
    box-shadow:0 0 0 0.2rem rgba(255,107,138,.15);
}

.notice-page .notice-search .btn-warning{
    background:linear-gradient(135deg,#ff6b8a,#ffa0b5);
    border:none;
    color:white;
    font-weight:600;
}


/* 공지 리스트 */

.notice-page .notice-row{
    background:#fff;
    border-radius:14px;
    padding:18px 22px;
    margin-bottom:12px;
    cursor:pointer;
    border:1px solid #ffd6de;
    transition:all .2s ease;
}

.notice-page .notice-row:hover{
    transform:translateY(-2px);
    box-shadow:0 6px 18px rgba(255,107,138,.15);
    border-color:#ff6b8a;
}


/* 공지 제목 */

.notice-page .notice-title{
    font-weight:600;
    color:#333;
}


/* 공지 뱃지 */

.notice-page .notice-badge{
    font-weight:700;
    color:#ff6b8a;
    margin-right:16px;
}


/* 공지 내용 */

.notice-page .notice-content-box{
    background:#fff1f4;
    border-radius:18px;
    padding:60px;
    text-align:center;
    margin:25px auto 45px auto;
    max-width:800px;
    min-height:240px;
    border:1px solid #ffd6de;
}


/* 오른쪽 버튼 */

.notice-page .notice-row .btn-warning{
    background:#ff6b8a;
    border:none;
    color:#fff;
    font-size:13px;
    border-radius:20px;
    padding:6px 14px;
}


/* 페이지네이션 */

.notice-page .pagination-area{
    text-align:center;
    margin-top:45px;
}

.notice-page .pagination-area span{
    font-size:28px;
    font-weight:700;
    margin:0 12px;
    cursor:pointer;
    color:#444;
    transition:.2s;
}

.notice-page .pagination-area span:hover{
    color:#ff6b8a;
}

</style>

</head>

<body>

<div class="notice-page">
<div class="container">




<!-- 열린 공지 -->
<div class="notice-row d-flex justify-content-between align-items-center">

<div>
<span class="notice-badge">공지사항</span>
<span class="notice-title">[공지] 공대생 커뮤니티 삼일절 휴무 안내</span>
</div>

<button class="btn btn-warning btn-sm">버튼</button>

</div>


<!-- 공지 내용 -->
<div class="notice-content-box">

공지내용

</div>


<!-- 공지 리스트 -->

<div class="notice-row d-flex justify-content-between align-items-center">

<div>
<span class="notice-badge">공지사항</span>
<span class="notice-title">[공지] 공지 제목 땅땅땅</span>
</div>

<button class="btn btn-warning btn-sm">버튼</button>

</div>


<div class="notice-row d-flex justify-content-between align-items-center">

<div>
<span class="notice-badge">공지사항</span>
<span class="notice-title">[공지] 공대생 커뮤니티 삼일절 휴무 안내</span>
</div>

<button class="btn btn-warning btn-sm">버튼</button>

</div>


<div class="notice-row d-flex justify-content-between align-items-center">

<div>
<span class="notice-badge">공지사항</span>
<span class="notice-title">[공지] 공대생 커뮤니티 삼일절 휴무 안내</span>
</div>

<button class="btn btn-warning btn-sm">버튼</button>

</div>


<div class="notice-row d-flex justify-content-between align-items-center">

<div>
<span class="notice-badge">공지사항</span>
<span class="notice-title">[공지] 공대생 커뮤니티 삼일절 휴무 안내</span>
</div>

<button class="btn btn-warning btn-sm">버튼</button>

</div>


<!-- 페이지 -->
<div class="pagination-area">

<span>1</span>
<span>2</span>
<span>3</span>
<span>4</span>
<span>5</span>

</div>


</div>
</div>

</body>


</html>