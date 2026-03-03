<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
</head>
<body>


<jsp:include page="/WEB-INF/views/layout/header.jsp"/>


<main>
	<!--
	<div class="section">
		<div class="container">
			<span style="color: #FF6B6B">메인</span><span style="color: #111111; background-color: #FF6B6B">메인</span>
		</div>
		<div class="container">
			<span style="color: #FFA07A">서브</span><span style="color: #111111; background-color: #FFA07A">서브</span>
		</div>
		<div class="container">
			<span style="color: #FFF8F5">배경</span><span style="color: #111111; background-color: #FFF8F5">배경</span>
		</div>
		<div class="container">
			<span style="color: #FF8C42">포인트</span><span style="color: #111111; background-color: #FF8C42">포인트</span>
		</div>
	</div>
	  -->
	
	<div class="section">
		<div class="container">
			<!-- 배너 -->
			<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
				<!-- 배너 밑 버튼 -->
		 		<div class="carousel-indicators">
		   			<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		    		<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="1" aria-label="Slide 2"></button>
		    		<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="2" aria-label="Slide 3"></button>
		  		</div>
		  		<!-- 배너 이미지 -->
		  		<div class="carousel-inner">
		    		<div class="carousel-item active">
		      			<img src="${pageContext.request.contextPath}/dist/images/bg.png" class="d-block w-100" alt="...">
		    		</div>
		    		<div class="carousel-item">
		      			<img src="${pageContext.request.contextPath}/dist/images/bg.png" class="d-block w-100" alt="...">
		    		</div>
		    		<div class="carousel-item">
		      			<img src="${pageContext.request.contextPath}/dist/images/bg.png" class="d-block w-100" alt="...">
		    		</div>
		  		</div>
		  		<!-- 배너 좌우 버튼 -->
		  		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
		    		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    		<span class="visually-hidden">Previous</span>
		  		</button>
		  		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
		    		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		    		<span class="visually-hidden">Next</span>
		  		</button>
			</div>
		</div>
	</div>
	
	
	<div class="section">
		<!-- 카테고리 영역 -->
		<div class="container mb-5">
			<div class="category-wrap">
			  	<button class="category-btn active">전체</button>
			  	<button class="category-btn">파티룸</button>
				<button class="category-btn">댄스연습실</button>
			  	<button class="category-btn">보컬연습실</button>
			  	<button class="category-btn">악기 연습실</button>
			  	<button class="category-btn">촬영 스튜디오</button>
			  	<button class="category-btn">스터디룸</button>
			  	<button class="category-btn">공연장</button>
			  	<button class="category-btn">공유주방</button>
			  	<button class="category-btn">회의실</button>
			  	<button class="category-btn">화실</button>
			  	<button class="category-btn">글램핑</button>
			</div>
			
		</div>
		<div class="container">
			<div class="row g-4">

   				 <!-- 상품 카드 -->
    			<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0">

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

    			<!-- 카드 복붙해서 여러 개 추가하면 4열 유지 -->

  			</div>
		</div>
	</div>
	
	<div class="section">
	</div>
	
	<div class="section">
		<div class="container">
			<div>최근 작성된 리뷰</div>
			<div>게시판</div>
		</div>
	
	
	</div>
	
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>