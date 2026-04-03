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
						<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="1" class="active" aria-current="true" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide-to="2" class="active" aria-current="true" aria-label="Slide 3"></button>
			  		</div>

			  		<div class="carousel-inner">
			  		
			  			<div class="carousel-item active">
			      			<img src="${pageContext.request.contextPath}/dist/images/bg1.png" class="d-block w-100" alt="배너이미지	1">
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
				<div onClick="homeSearch()" class="section-more">더보기</div>
			</div>

			<div class="category-panel">
				<div class="category-slider">
					<button class="slide-btn left" onclick="scrollCategory(-200)">◀</button>

					<div class="category-mask">
						<div class="category-wrap">
							<button class="category-btn active" data-num="">전체</button>
							<c:forEach var="category" items="${categoryList}">
			       				<button class="category-btn" data-num="${category.categoryNo}">${category.name}</button>
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
			<div class="row g-4"></div>
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
				<c:forEach var="board" items="${boardList}">
					<div class="col-12 col-md-6 col-lg-4">
						<div class="card notice-card h-100 border-0"
							onclick="location.href='${pageContext.request.contextPath}/${board.type == 'NOTICE' ? 'notice' : 'event'}/${board.num}'">
							<div class="card-body">
								<span class="badge ${board.type == 'NOTICE' ? 'notice-badge-danger' : 'notice-badge-default'} mb-2">${board.type == 'NOTICE' ? '공지' : '안내'}</span>
								<h6 class="fw-bold mb-2">${board.title}</h6>
								<div class="text-muted small mb-3">${board.content}</div>
								<div class="text-muted small">${board.created_at}</div>
							</div>
						</div>
					</div>
				</c:forEach>
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

function homeSearch() {
	const categoryBtns = document.querySelectorAll('.category-btn');
	
	categoryBtns.forEach(btn => {
		if(btn.classList.contains('active')) {
			location.href = '${pageContext.request.contextPath}/space/search?category=' + btn.dataset.num;
		}
	});	

}

// 카테고리 별 공간 출력
function loadSpaceList(categoryNo) {
	const url = '${pageContext.request.contextPath}/space/homeSpacelist';
	const params = 'category=' + categoryNo;
	
	const fn = function(data) {
		let out = '';

		for(let space of data.list) {
			
			out += `
				<div class="col-12 col-sm-6 col-lg-3">
	  				<div class="card product-card h-100 border-0" onclick="location.href='${pageContext.request.contextPath}/space/\${space.num}'">
	        			<div class="position-relative product-thumb">
	          				<img src="${pageContext.request.contextPath}/uploads/space/\${space.thumbnail}" class="card-img-top product-img" alt="상품이미지">
	          				<button class="wishlist-btn">
	            				<i class="bi bi-heart"></i>
	          				</button>
	        			</div>

	        			<div class="card-body product-body">
	          				<h6 class="card-title mb-1">\${space.name}</h6>

	          				<div class="rating mb-2">
	            				<i class="bi bi-star-fill text-warning"></i>
	            				<span class="fw-semibold">4.8</span>
	            				<span class="text-muted small">(128)</span>
	          				</div>

	          				<p class="text-muted small mb-2">\${space.address} · 최대 \${space.capacity}명</p>
	          				<p class="fw-bold product-price mb-0">₩\${space.price.toLocaleString('ko-KR')}</p>
	          				
	        			</div>
	  				</div>
				</div>
			`;
		}
		
		spaceSection.innerHTML = out;
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

loadSpaceList('');

mask.addEventListener('click', function(e) {
	if(e.target.matches('.category-btn')) {
		const categoryBtns = this.querySelectorAll('.category-btn');
		categoryBtns.forEach(btn => btn.classList.remove('active'));
		e.target.classList.add('active');
		
		loadSpaceList(e.target.dataset.num);
	}
});

</script>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>