<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매장 관리 - 공대생 호스트 센터</title>

    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/store.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">

    <!-- 타이틀 -->
    <div class="mb-4">
        <h3 class="fw-bold">매장 관리</h3>
        <p class="text-muted">등록된 공간을 관리하고 수정하세요.</p>
    </div>

  

    <!-- 매장 카드 리스트 -->
    <div class="row g-4">

        <!-- 카드 1 -->
        <div class="col-md-4">
            <div class="store-card">

                <img src="https://via.placeholder.com/400x200" class="store-img">

                <div class="store-body">
                    <h5 class="store-title">홍대 루프탑 파티룸</h5>

                    <p class="store-desc">
                        최대 10명 수용 / 파티, 모임 가능
                    </p>

                    <div class="store-info">
                        <span><i class="bi bi-geo-alt"></i> 홍대입구역 3분</span>
                        <span><i class="bi bi-people"></i> 10명</span>
                    </div>

                    <div class="store-actions">
                        <button class="btn btn-sm btn-edit">수정</button>
                        <button class="btn btn-sm btn-delete">삭제</button>
                    </div>
                </div>

            </div>
        </div>

        <!-- 카드 2 -->
        <div class="col-md-4">
            <div class="store-card">

                <img src="https://via.placeholder.com/400x200" class="store-img">

                <div class="store-body">
                    <h5 class="store-title">강남 스터디룸 A호</h5>

                    <p class="store-desc">
                        조용한 공부 공간 / 와이파이 제공
                    </p>

                    <div class="store-info">
                        <span><i class="bi bi-geo-alt"></i> 강남역 5분</span>
                        <span><i class="bi bi-people"></i> 6명</span>
                    </div>

                    <div class="store-actions">
                        <button class="btn btn-sm btn-edit">수정</button>
                        <button class="btn btn-sm btn-delete">삭제</button>
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