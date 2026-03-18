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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/guest/page/home.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>

<main class="home-page">

	<!-- 메인 배너 -->
	<section class="section home-hero-section">
		<div class="container">
			<div class="hero-shell">
				<div id="carouselExampleAutoplaying" class="carousel slide home-carousel" data-bs-ride="carousel" data-bs-interval="5000">
					
					<div class="carousel-indicators">
			   			<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    		<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="1" aria-label="Slide 2"></button>
			    		<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="2" aria-label="Slide 3"></button>
			  		</div>

			  		<div class="carousel-inner">
			    		<div class="carousel-item active">
			      			<img src="${pageContext.request.contextPath}/dist/images/bg1.png" class="d-block w-100" alt="배너이미지1">
			    		</div>
			    		<div class="carousel-item">
			      			<img src="${pageContext.request.contextPath}/dist/images/bg2.png" class="d-block w-100" alt="배너이미지2">
			    		</div>
			    		<div class="carousel-item">
			      			<img src="${pageContext.request.contextPath}/dist/images/bg3.png" class="d-block w-100" alt="배너이미지3">
			    		</div>
			  		</div>

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
	</section>

	<!-- 카테고리 -->
	<section class="section home-category-section">
		<div class="container">
			<div class="section-head">
				<div>
					<span class="section-eyebrow">CATEGORY</span>
					<h3 class="section-title">어떤 공간을 찾고 있나요?</h3>
				</div>
				<a href="${pageContext.request.contextPath}/space/search" class="section-more">더보기</a>
			</div>

			<div class="category-panel">
				<div class="category-slider">
					<button class="slide-btn left" onclick="scrollCategory(-200)">◀</button>

					<div class="category-mask">
						<div class="category-wrap">
							<button class="category-btn active">전체</button>
							<c:forEach var="category" items="${categoryList}">
			       				<button class="category-btn">${category.name}</button>
			       			</c:forEach>
						</div>
					</div>

			        <button class="slide-btn right" onclick="scrollCategory(200)">▶</button>
				</div>
			</div>
		</div>
	</section>

	<!-- 공간 리스트 -->
	<section class="section home-space-section">
		<div class="container">
			<div class="row g-4">

   				<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0" onclick="location.href='${pageContext.request.contextPath}/space/detail/1'">
	        			<div class="position-relative product-thumb">
	          				<img src="${pageContext.request.contextPath}/dist/images/image.png" class="card-img-top product-img" alt="상품이미지">
	          				<button class="wishlist-btn">
	            				<i class="bi bi-heart"></i>
	          				</button>
	        			</div>

	        			<div class="card-body product-body">
	          				<h6 class="card-title mb-1">파티룸 A</h6>

	          				<div class="rating mb-2">
	            				<i class="bi bi-star-fill text-warning"></i>
	            				<span class="fw-semibold">4.8</span>
	            				<span class="text-muted small">(128)</span>
	          				</div>

	          				<p class="text-muted small mb-2">서울 강남 · 최대 10명</p>
	          				<p class="fw-bold product-price mb-0">₩120,000</p>
	        			</div>
      				</div>
    			</div>

    			<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0">
	        			<div class="position-relative product-thumb">
	          				<img src="${pageContext.request.contextPath}/dist/images/image.png" class="card-img-top product-img" alt="상품이미지">
	          				<button class="wishlist-btn">
	            				<i class="bi bi-heart"></i>
	          				</button>
	        			</div>

	        			<div class="card-body product-body">
	          				<h6 class="card-title mb-1">스터디룸 B</h6>
	          				<div class="rating mb-2">
	            				<i class="bi bi-star-fill text-warning"></i>
	            				<span class="fw-semibold">4.7</span>
	            				<span class="text-muted small">(92)</span>
	          				</div>
	          				<p class="text-muted small mb-2">서울 마포 · 최대 6명</p>
	          				<p class="fw-bold product-price mb-0">₩45,000</p>
	        			</div>
      				</div>
    			</div>

    			<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0">
	        			<div class="position-relative product-thumb">
	          				<img src="${pageContext.request.contextPath}/dist/images/image.png" class="card-img-top product-img" alt="상품이미지">
	          				<button class="wishlist-btn">
	            				<i class="bi bi-heart"></i>
	          				</button>
	        			</div>

	        			<div class="card-body product-body">
	          				<h6 class="card-title mb-1">촬영 스튜디오 C</h6>
	          				<div class="rating mb-2">
	            				<i class="bi bi-star-fill text-warning"></i>
	            				<span class="fw-semibold">4.9</span>
	            				<span class="text-muted small">(201)</span>
	          				</div>
	          				<p class="text-muted small mb-2">서울 성수 · 최대 8명</p>
	          				<p class="fw-bold product-price mb-0">₩89,000</p>
	        			</div>
      				</div>
    			</div>

    			<div class="col-12 col-sm-6 col-lg-3">
      				<div class="card product-card h-100 border-0">
	        			<div class="position-relative product-thumb">
	          				<img src="${pageContext.request.contextPath}/dist/images/image.png" class="card-img-top product-img" alt="상품이미지">
	          				<button class="wishlist-btn">
	            				<i class="bi bi-heart"></i>
	          				</button>
	        			</div>

	        			<div class="card-body product-body">
	          				<h6 class="card-title mb-1">회의실 D</h6>
	          				<div class="rating mb-2">
	            				<i class="bi bi-star-fill text-warning"></i>
	            				<span class="fw-semibold">4.6</span>
	            				<span class="text-muted small">(74)</span>
	          				</div>
	          				<p class="text-muted small mb-2">서울 종로 · 최대 12명</p>
	          				<p class="fw-bold product-price mb-0">₩65,000</p>
	        			</div>
      				</div>
    			</div>
  			</div>
		</div>
	</section>

	<!-- 리뷰 -->
	<section class="section home-review-section">
		<div class="container">
			<div class="section-head">
				<div>
					<span class="section-eyebrow">REVIEWS</span>
					<h3 class="section-title">최근 작성된 리뷰</h3>
					<p class="section-desc">실제 이용자들의 생생한 후기를 확인해보세요.</p>
				</div>
			</div>

			<div class="row g-4">
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card review-card h-100 border-0">
						<div class="card-body">
							<div class="review-badge">BEST REVIEW</div>
							<h6 class="fw-bold mb-2">친구들이랑 파티하기 좋았어요</h6>
							<p class="text-muted small mb-3">
								공간이 깔끔하고 위치도 좋아서 친구들이랑 생일 파티하기 딱 좋았습니다.
								다음에도 또 이용할 것 같아요.
							</p>
							<div class="d-flex justify-content-between align-items-center small text-muted">
								<span>홍길동</span>
								<span>2026.03.04</span>
							</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-md-6 col-lg-4">
					<div class="card review-card h-100 border-0">
						<div class="card-body">
							<div class="review-badge">USER REVIEW</div>
							<h6 class="fw-bold mb-2">스터디 모임에 딱입니다</h6>
							<p class="text-muted small mb-3">
								조용하고 테이블도 넓어서 스터디 모임하기 좋았어요.
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
					<div class="card review-card h-100 border-0">
						<div class="card-body">
							<div class="review-badge">USER REVIEW</div>
							<h6 class="fw-bold mb-2">시설이 깔끔합니다</h6>
							<p class="text-muted small mb-3">
								시설이 생각보다 깨끗하고 에어컨도 잘 나와서 편하게 이용했습니다.
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
	</section>

	<!-- 공지사항 -->
	<section class="section home-notice-section">
		<div class="container">
			<div class="section-head">
				<div>
					<span class="section-eyebrow">NOTICE</span>
					<h3 class="section-title">공지사항</h3>
					<p class="section-desc">서비스 이용 전에 중요한 안내를 확인해 주세요.</p>
				</div>
				<a href="${pageContext.request.contextPath}/notice" class="section-more">더보기</a>
			</div>

			<div class="row g-4">
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card notice-card h-100 border-0">
						<div class="card-body">
							<span class="badge notice-badge-danger mb-2">공지</span>
							<h6 class="fw-bold mb-2">공간 예약 시스템 점검 안내</h6>
							<p class="text-muted small mb-3">
								보다 안정적인 서비스 제공을 위해 예약 시스템 점검이 진행됩니다.
								점검 시간 동안 일부 서비스 이용이 제한될 수 있습니다.
							</p>
							<div class="text-muted small">2026.03.04</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-md-6 col-lg-4">
					<div class="card notice-card h-100 border-0">
						<div class="card-body">
							<span class="badge notice-badge-default mb-2">안내</span>
							<h6 class="fw-bold mb-2">신규 공간 등록 이벤트 안내</h6>
							<p class="text-muted small mb-3">
								신규 공간을 등록하시는 호스트 분들께 등록 수수료 할인 이벤트가 진행됩니다.
							</p>
							<div class="text-muted small">2026.03.02</div>
						</div>
					</div>
				</div>

				<div class="col-12 col-md-6 col-lg-4">
					<div class="card notice-card h-100 border-0">
						<div class="card-body">
							<span class="badge notice-badge-default mb-2">안내</span>
							<h6 class="fw-bold mb-2">서비스 이용약관 개정 안내</h6>
							<p class="text-muted small mb-3">
								서비스 이용약관이 일부 개정되어 2026년 3월 10일부터 적용됩니다.
							</p>
							<div class="text-muted small">2026.02.28</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

</main>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<script type="text/javascript">
// 카테고리 창 관련 js
const wrap = document.querySelector('.category-wrap');
const mask = document.querySelector('.category-mask');
const spaceSection = document.querySelector('.home-space-section .row.g-4')

function updateFade() {
    if (!wrap || !mask) return;

    if (wrap.scrollLeft <= 0) {
        mask.classList.add('no-left-fade');
    } else {
        mask.classList.remove('no-left-fade');
    }

    if (wrap.scrollLeft + wrap.clientWidth >= wrap.scrollWidth - 1) {
        mask.classList.add('no-right-fade');
    } else {
        mask.classList.remove('no-right-fade');
    }
}

updateFade();

if (wrap) {
    wrap.addEventListener('scroll', updateFade);
}

function scrollCategory(amount) {
    if (!wrap) return;
    wrap.scrollBy({ left: amount, behavior: 'smooth' });
    setTimeout(updateFade, 220);
}

// 카테고리 별 공간 출력
mask.addEventListener('click', function(e) {
	if(e.target.matches('.category-btn')) {
		const categoryBtns = this.querySelectorAll('.category-btn');
		categoryBtns.forEach(btn => btn.classList.remove('active'));
		e.target.classList.add('active');
		
		const url = '${pageContext.request.contextPath}/space/list';
		const params = 'category=';
		
		const fn = function(data) {

			
			
			let out = '';
			
			for(let space of data.list) {
					
				out += `
					<div class="col-12 col-sm-6 col-lg-3">
	      				<div class="card product-card h-100 border-0" onclick="location.href='${pageContext.request.contextPath}/space/detail'">
		        			<div class="position-relative product-thumb">
		          				<img src="${pageContext.request.contextPath}/dist/images/image.png" class="card-img-top product-img" alt="상품이미지">
		          				<button class="wishlist-btn">
		            				<i class="bi bi-heart"></i>
		          				</button>
		        			</div>
	
		        			<div class="card-body product-body">
		          				<h6 class="card-title mb-1">` + space.title +  `</h6>
	
		          				<div class="rating mb-2">
		            				<i class="bi bi-star-fill text-warning"></i>
		            				<span class="fw-semibold">4.8</span>
		            				<span class="text-muted small">(128)</span>
		          				</div>
	
		          				<p class="text-muted small mb-2">` + space.region + ` · 최대 ` + space.capacity + `명</p>
		          				<p class="fw-bold product-price mb-0">₩` + space.price + `</p>
		        			</div>
	      				</div>
	    			</div>
				`;
				
		
			}
			
			
			spaceSection.insertAdjacentHTML('beforeend', out);
		};
		
		const headers = {'Content-Type': 'application/x-www-form-urlencoded'};
		const options = {
				method: 'POST',
				headers: headers,
				body: params,
		};
		
		fetch(url, options)
			.then(res => res.json())
			.then(data => fn(data))
			.catch(err => console.log("error:", err));
	}
});

</script>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>