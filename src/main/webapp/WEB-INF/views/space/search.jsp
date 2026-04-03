<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/guest/page/home.css" type="text/css">
<style type="text/css"> 
/* ============================= */
/* 🔥 검색 바 전체 */
/* ============================= */
.search-bar-wrapper {
    position: sticky;
    top: 72px;
    z-index: 1000;
    background: var(--background-color);
    padding: 16px 0;
    border-bottom: 1px solid var(--border-soft-color);
}

/* 상단 라인 */
.search-top {
    display: flex;
    gap: 12px;
    align-items: center;
}

/* ============================= */
/* 🔥 정렬 버튼 */
/* ============================= */
.sort-group {
    flex: 0 0 180px;
    position: relative;
}

.filter-chip {
    width: 100%;
    height: 44px;
    border-radius: var(--radius-md);
    border: 1px solid var(--border-color);
    background: var(--surface-color);
    font-weight: 500;
    color: var(--default-color);
    transition: var(--transition-fast);
}

.filter-chip:hover {
    border-color: var(--accent-color);
    color: var(--accent-color);
}

/* 활성 */
.filter-chip.active {
    border-color: var(--accent-color);
    background: var(--accent-soft-color);
    color: var(--accent-color);
}

/* ============================= */
/* 🔥 드롭다운 */
/* ============================= */
.filter-dropdown {
    position: absolute;
    top: 52px;
    left: 0;
    width: 100%;

    background: var(--surface-color);
    border-radius: var(--radius-lg);
    border: 1px solid var(--border-soft-color);
    box-shadow: var(--shadow-md);

    padding: 12px;

    opacity: 0;
    transform: translateY(10px);
    pointer-events: none;

    transition: var(--transition-fast);
}

.filter-group.open .filter-dropdown {
    opacity: 1;
    transform: translateY(0);
    pointer-events: auto;
}

/* ============================= */
/* 🔥 검색창 */
/* ============================= */
.search-input-box {
    flex: 1;
    display: flex;
    border: 1px solid var(--border-color);
    border-radius: var(--radius-md);
    overflow: hidden;
    background: var(--surface-color);
    transition: var(--transition-fast);
}

.search-input-box:hover {
    border-color: var(--accent-color);
}

.search-input-box input {
    flex: 1;
    border: none;
    padding: 0 14px;
    height: 44px;
    outline: none;
    font-size: 14px;
    color: var(--default-color);
}

.search-input-box input::placeholder {
    color: var(--subtle-color);
}

/* 검색 버튼 */
.search-input-box button {
    width: 90px;
    border: none;
    background: linear-gradient(135deg, var(--accent-color), var(--accent-hover-color));
    color: var(--contrast-color);
    font-weight: 500;
    transition: var(--transition-fast);
}

.search-input-box button:hover {
    filter: brightness(1.05);
}

/* ============================= */
/* 🔥 펼쳐진 필터 */
/* ============================= */
.search-expanded {
    margin-top: 16px;
}

/* 필터 줄 */
.filter-row {
    display: flex;
    align-items: flex-start;
    margin-bottom: 12px;
}

/* 라벨 */
.filter-row .label {
    width: 90px;
    font-weight: 600;
    font-size: 14px;
    color: var(--heading-color);
    padding-top: 6px;
}

/* ============================= */
/* 🔥 옵션 버튼 */
/* ============================= */
.option-list {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
}

.option-btn {
    padding: 6px 12px;
    border-radius: var(--radius-pill);
    border: 1px solid var(--border-color);
    background: var(--surface-color);
    font-size: 13px;
    color: var(--default-color);
    cursor: pointer;
    transition: var(--transition-fast);
}

/* hover */
.option-btn:hover {
    border-color: var(--accent-color);
    color: var(--accent-color);
    background: var(--accent-soft-color);
}

/* 선택 */
.option-btn.active {
    background: var(--accent-color);
    color: var(--contrast-color);
    border-color: var(--accent-color);
}

/* ============================= */
/* 🔥 반응형 */
/* ============================= */
@media (max-width: 768px) {
    .search-top {
        flex-direction: column;
        gap: 10px;
    }

    .sort-group {
        width: 100%;
    }

    .search-input-box {
        width: 100%;
    }

    .filter-row {
        flex-direction: column;
    }

    .filter-row .label {
        width: auto;
        margin-bottom: 6px;
    }
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />
	<!-- 🔥 검색 필터 바 -->
<div class="search-bar-wrapper">
    <div class="container">

        <!-- 상단 라인 -->
        <div class="search-top">

            <!-- 정렬 (2칸 차지) -->
            <div class="filter-group sort-group">
                <button class="filter-chip">정렬 ▾</button>

                <div class="filter-dropdown full">
                    <div class="option-list">
                        <button class="option-btn">가격 높은순</button>
                        <button class="option-btn">가격 낮은순</button>
                    </div>
                </div>
            </div>

            <!-- 🔍 검색 -->
            <div class="search-input-box">
                <input type="text" name="kwdInput" value="${kwd}" placeholder="지역, 공간명, 키워드 검색">
                <button onclick="kwdSearch()">검색</button>
            </div>

        </div>

		<!-- 검색조건: 검색어, 공간종류, 지역, 날짜, 시간, 인원 -->
		<!-- 정렬조건: 최신순, 별점 높은 순, 후기 많은 순, 가격작은순, 가격높은순 -->

        <!-- 펼쳐진 필터 -->
        <div class="search-expanded">

            <!-- 공간 종류 -->
            <div class="filter-row">
                <div class="label">공간 종류</div>
                <div class="option-list">
                	<button class="option-btn 
                		${category == ''? 'active': ''}"
                		onclick="categorySearch('')">전체</button>
                	<c:forEach var="categoryBtn" items="${categoryList}">
                		<button class="option-btn 
                			${category == categoryBtn.categoryNo? 'active': ''}"
                			onclick="categorySearch(${categoryBtn.categoryNo})">
                			${categoryBtn.name}</button>
                	</c:forEach>
                </div>
            </div>

            <!-- 지역 -->
            <div class="filter-row">
                <div class="label">지역</div>
                <div class="option-list">
                    <button class="option-btn ${region == '' ? 'active' : ''}"
                   		onclick="regionSearch('')">전체</button>
                    <button class="option-btn ${region == '서울' ? 'active' : ''}"
                    	onclick="regionSearch('서울')">서울</button>
                    <button class="option-btn ${region == '경기' ? 'active' : ''}"
                    	onclick="regionSearch('경기')">경기</button>
                    <button class="option-btn ${region == '인천' ? 'active' : ''}"
                    	onclick="regionSearch('인천')">인천</button>
                    <button class="option-btn ${region == '강원' ? 'active' : ''}"
                    	onclick="regionSearch('강원')">강원</button>
                    <button class="option-btn ${region == '충청' ? 'active' : ''}"
                    	onclick="regionSearch('충청')">충청</button>
                    <button class="option-btn ${region == '전라' ? 'active' : ''}"
                    	onclick="regionSearch('전라')">전라</button>
                    <button class="option-btn ${region == '경상' ? 'active' : ''}"
                    	onclick="regionSearch('경상')">경상</button>
                    <button class="option-btn ${region == '제주' ? 'active' : ''}"
                    	onclick="regionSearch('제주')">제주</button>
                </div>
            </div>

        </div>

    </div>
</div>
	<main>
		<!-- 프리미엄존 -->
		<div class="section">
			<div class="container mt-5 premium-space-section">
				<!-- 제목 -->
				<c:if test="${premiumCount != 0}">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="fw-bold mb-0">프리미엄존</h4>
					</div>
				</c:if>
				<div class="row g-4"></div>
				<!-- 더보기 -->
			</div>
		</div>
		<!-- 일반 공간 리스트 -->
		<div class="section">
			<div class="container normal-space-section">
				<!-- 제목 -->
				<div class="d-flex justify-content-between align-items-center mb-3">
					<h4 class="fw-bold mb-0">${spaceCount}개의 공간이 있습니다.</h4>
				</div>
				<div class="row g-4"></div>
				<!-- 더보기 -->
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />
</body>

<script type="text/javascript">
document.querySelectorAll('.filter-chip').forEach(btn => {
    btn.addEventListener('click', function () {
        const group = this.parentElement;

        // 다른거 닫기
        document.querySelectorAll('.filter-group').forEach(g => {
            if (g !== group) g.classList.remove('open');
        });

        group.classList.toggle('open');
        this.classList.toggle('active');
    });
});

// 바깥 클릭 시 닫기
document.addEventListener('click', function (e) {
    if (!e.target.closest('.filter-group')) {
        document.querySelectorAll('.filter-group').forEach(g => {
            g.classList.remove('open');
            g.querySelector('.filter-chip')?.classList.remove('active');
        });
    }
});


function kwdSearch() {
	const params = new URLSearchParams(window.location.search);
	params.set("kwd", document.querySelector('input[name="kwdInput"]').value);
	console.log(params.toString());
	
	location.href='${pageContext.request.contextPath}/space/search?' + params.toString();
}

function categorySearch(category) {
	const params = new URLSearchParams(window.location.search);
	params.set("category", category);
	console.log(params.toString());
	
	location.href='${pageContext.request.contextPath}/space/search?' + params.toString();
}

function regionSearch(region) {
	const params = new URLSearchParams(window.location.search);
	params.set("region", region);
	console.log(params.toString());
	
	location.href='${pageContext.request.contextPath}/space/search?' + params.toString();
}


const normalSpaceSection = document.querySelector('.normal-space-section .row.g-4');
const premiumSpaceSection = document.querySelector('.premium-space-section .row.g-4');

function loadPremiumSpaceList() {
	const url = '${pageContext.request.contextPath}/space/premiumSpaceList';
	const params = new URLSearchParams(window.location.search);
	
	console.log(params.toString());
	
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
		
		premiumSpaceSection.innerHTML = out;
	};
	
	const headers = {'Content-Type': 'application/x-www-form-urlencoded'};
	const options = {
			method: 'POST',
			headers: headers,
			body: params.toString(),
	};
	
	fetch(url, options)
		.then(res => res.json())
		.then(data => fn(data))
		.catch(err => console.log("error:", err));

}

function loadSpaceList() {
	const url = '${pageContext.request.contextPath}/space/list';
	const params = new URLSearchParams(window.location.search);
	
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
		
		normalSpaceSection.innerHTML = out;
	};
	
	const headers = {'Content-Type': 'application/x-www-form-urlencoded'};
	const options = {
			method: 'POST',
			headers: headers,
			body: params.toString(),
	};
	
	fetch(url, options)
		.then(res => res.json())
		.then(data => fn(data))
		.catch(err => console.log("error:", err));

}

loadPremiumSpaceList();
loadSpaceList();


</script>
</html>