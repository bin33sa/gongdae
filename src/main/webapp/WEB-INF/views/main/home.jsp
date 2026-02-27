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
		<div class="container">
			<div>광고, 이벤트, 공지사항 배너</div>
			<div>공간 종류별 카테고리</div>
			<div>최근 등록된 공간</div>
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