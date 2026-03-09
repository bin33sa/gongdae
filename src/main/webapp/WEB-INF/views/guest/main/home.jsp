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
</head>
<body>


<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>


<main>
	
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
	
	<!-- 공간 리스트 -->
	<div class="section">
		<!-- 카테고리 영역 -->
		<div class="container mb-5">
			<div class="category-slider">
				<!-- 왼쪽 버튼 -->
				<button class="slide-btn left" onclick="scrollCategory(-200)">
				    ◀
				</button>
				
				<!-- 카테고리 영역 -->
				<div class="category-mask">
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
				<!-- 오른쪽 버튼 -->
		        <button class="slide-btn right" onclick="scrollCategory(200)">
		            ▶
		        </button>
				
			</div>
		</div>
		
		<div class="container">
			<div class="row g-4 mb-3">

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
  			</div>
  			
  			<!-- 더보기 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<a href="${pageContext.request.contextPath}/space/search" class="small text-decoration-none ms-auto">더보기</a>
			</div>
  			
		</div>
		
		
	</div>
	
	
	<!-- 리뷰 -->
	<div class="section">
		<div class="container">
	
			<!-- 제목 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h5 class="fw-bold mb-0">최근 작성된 리뷰</h5>
			</div>
	
			<div class="row g-4 mb-3">
	
				<!-- 리뷰 카드 -->
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card review-card h-100 border-0 shadow-sm">
	
						<div class="card-body">
	
							<!-- 리뷰 제목 -->
							<h6 class="fw-bold mb-2">친구들이랑 파티하기 좋았어요</h6>
	
							<!-- 리뷰 내용 -->
							<p class="text-muted small mb-3">
								공간이 깔끔하고 위치도 좋아서 친구들이랑
								생일 파티하기 딱 좋았습니다.
								다음에도 또 이용할 것 같아요.
							</p>
	
							<!-- 하단 정보 -->
							<div class="d-flex justify-content-between align-items-center small text-muted">
								<span>홍길동</span>
								<span>2026.03.04</span>
							</div>
	
						</div>
					</div>
				</div>
	
				<!-- 카드 복붙해서 여러개 -->
	
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card review-card h-100 border-0 shadow-sm">
						<div class="card-body">
							<h6 class="fw-bold mb-2">스터디 모임에 딱입니다</h6>
							<p class="text-muted small mb-3">
								조용하고 테이블도 넓어서
								스터디 모임하기 좋았어요.
								가격도 괜찮은 편입니다.
							</p>
							<div class="d-flex justify-content-between small text-muted">
								<span>김철수</span>
								<span>2026.03.02</span>
							</div>
						</div>
					</div>
				</div>
	
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card review-card h-100 border-0 shadow-sm">
						<div class="card-body">
							<h6 class="fw-bold mb-2">시설이 깔끔합니다</h6>
							<p class="text-muted small mb-3">
								시설이 생각보다 깨끗하고
								에어컨도 잘 나와서 편하게 이용했습니다.
							</p>
							<div class="d-flex justify-content-between small text-muted">
								<span>이영희</span>
								<span>2026.02.28</span>
							</div>
						</div>
					</div>
				</div>
	
			</div>
			
			
		</div>
	</div>
	
	<!-- 홈화면 공지사항 -->
	<div class="section">
		<div class="container">
	
			<!-- 제목 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h5 class="fw-bold mb-0">공지사항</h5>
			</div>
	
			<div class="row g-4 mb-3">
	
				<!-- 공지 카드 -->
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card notice-card h-100 border-0 shadow-sm">
						<div class="card-body">
	
							<!-- 공지 뱃지 -->
							<span class="badge bg-danger mb-2">공지</span>
	
							<!-- 제목 -->
							<h6 class="fw-bold mb-2">
								공간 예약 시스템 점검 안내
							</h6>
	
							<!-- 내용 요약 -->
							<p class="text-muted small mb-3">
								보다 안정적인 서비스 제공을 위해
								예약 시스템 점검이 진행됩니다.
								점검 시간 동안 일부 서비스 이용이 제한될 수 있습니다.
							</p>
	
							<!-- 날짜 -->
							<div class="text-muted small">
								2026.03.04
							</div>
	
						</div>
					</div>
				</div>
	
				<!-- 카드 2 -->
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card notice-card h-100 border-0 shadow-sm">
						<div class="card-body">
	
							<span class="badge bg-secondary mb-2">안내</span>
	
							<h6 class="fw-bold mb-2">
								신규 공간 등록 이벤트 안내
							</h6>
	
							<p class="text-muted small mb-3">
								신규 공간을 등록하시는 호스트 분들께
								등록 수수료 할인 이벤트가 진행됩니다.
							</p>
	
							<div class="text-muted small">
								2026.03.02
							</div>
	
						</div>
					</div>
				</div>
	
				<!-- 카드 3 -->
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card notice-card h-100 border-0 shadow-sm">
						<div class="card-body">
	
							<span class="badge bg-secondary mb-2">안내</span>
	
							<h6 class="fw-bold mb-2">
								서비스 이용약관 개정 안내
							</h6>
	
							<p class="text-muted small mb-3">
								서비스 이용약관이 일부 개정되어
								2026년 3월 10일부터 적용됩니다.
							</p>
	
							<div class="text-muted small">
								2026.02.28
							</div>
	
						</div>
					</div>
				</div>
	
			</div>
			<!-- 더보기 -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<a href="${pageContext.request.contextPath}/notice" class="small text-decoration-none ms-auto">더보기</a>
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