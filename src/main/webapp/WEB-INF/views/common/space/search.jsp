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
/* 확장 검색 조건 섹션 그림자 */
.search-advanced {
	position: sticky;
    top: 80px; /* 헤더 높이에 맞게 조정 */
    z-index: 996; /* 헤더보다 낮게 */
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}


</style>

</head>
<body>


<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<!-- 확장 검색 조건 섹션 -->
<div class="search-advanced bg-white shadow">
  	<div class="container py-3">
      	<form action="<c:url value='/space/search'/>" method="GET" class="row g-3 align-items-end">


			<!-- 검색 버튼 -->
			<div class="col-12 col-md-1 d-grid">
				<button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
					상세 검색
				</button>
			</div>
			

      	</form>
  	</div>
</div>




<main>
	
	<!-- 프리미엄존 -->
	<div class="section">
		<div class="container">
	
			<!-- 제목 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4 class="fw-bold mb-0">프리미엄존</h4>
			</div>
	
			<div class="row g-4">
				<!-- 상품 카드 -->
    			<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0" onclick="location.href='${pageContext.request.contextPath}/space/detail'">

       		 		<!-- 이미지 영역 -->
        			<div class="position-relative">
          				<img src="${pageContext.request.contextPath}/dist/images/image.png"
               				class="card-img-top product-img"
               					alt="상품이미지">

          				<!-- ❤️ 찜 버튼 -->
          				<button class="wishlist-btn">
            				<i class="bi bi-heart"></i>
          				</button>
        			</div>

        			<!-- 카드 내용 -->
        			<div class="card-body">
          				<h6 class="card-title mb-1">파티룸 A</h6>

          				<!-- ⭐ 평점 -->
          				<div class="rating mb-2">
            				<i class="bi bi-star-fill text-warning"></i>
            				<span class="fw-semibold">4.8</span>
            				<span class="text-muted small">(128)</span>
          				</div>

          				<p class="text-muted small mb-2">서울 강남 · 최대 10명</p>
          				<p class="fw-bold text-primary mb-0">₩120,000</p>
        			</div>

      				</div>
    			</div>
	
				
	
			</div>
			<!-- 더보기 -->
		</div>
	</div>
	
	<!-- 일반 공간 리스트 -->
	<div class="section">
		<div class="container">
	
			<!-- 제목 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4 class="fw-bold mb-0">312개의 공간이 있습니다.</h4>
			</div>
	
			<div class="row g-4">
				<!-- 상품 카드 -->
    			<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0" onclick="location.href='${pageContext.request.contextPath}/space/detail'">

       		 		<!-- 이미지 영역 -->
        			<div class="position-relative">
          				<img src="${pageContext.request.contextPath}/dist/images/image.png"
               				class="card-img-top product-img"
               					alt="상품이미지">

          				<!-- ❤️ 찜 버튼 -->
          				<button class="wishlist-btn">
            				<i class="bi bi-heart"></i>
          				</button>
        			</div>

        			<!-- 카드 내용 -->
        			<div class="card-body">
          				<h6 class="card-title mb-1">파티룸 A</h6>

          				<!-- ⭐ 평점 -->
          				<div class="rating mb-2">
            				<i class="bi bi-star-fill text-warning"></i>
            				<span class="fw-semibold">4.8</span>
            				<span class="text-muted small">(128)</span>
          				</div>

          				<p class="text-muted small mb-2">서울 강남 · 최대 10명</p>
          				<p class="fw-bold text-primary mb-0">₩120,000</p>
        			</div>

      				</div>
    			</div>
	
				
	
			</div>
			<!-- 더보기 -->
		</div>
	</div>
	
	 
		
</main>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>