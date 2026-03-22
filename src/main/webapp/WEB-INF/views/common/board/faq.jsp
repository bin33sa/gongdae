<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>

<html>

<head>
	
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>FAQ</title>
	
	<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
	<!--faq 페이지 전용 CSS -->
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/dist/css/guest/common/faq.css"
		type="text/css">

</head>


<body>


	<header>
		<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
	</header>


	<main>
	
		<section class="section faq-page">
		
			<div class="container">
			
			
			<!-- 페이지 헤더 -->
			
			<div class="faq-header">
			
			<h2 class="section-title">자주 묻는 질문</h2>
			<p class="section-desc">서비스 이용 중 궁금한 내용을 확인해보세요</p>
			</div>
				<!-- FAQ ACCORDION -->
				
				<div class="accordion faq-accordion" id="faqAccordion">
				
					<c:forEach var="dto" items="${list}">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed"
								        data-bs-toggle="collapse"
								        data-bs-target="#faq${dto.num}">
									${dto.title}
								</button>
							</h2>
							<div id="faq${dto.num}"
							     class="accordion-collapse collapse"
							     data-bs-parent="#faqAccordion">
								<div class="accordion-body">
									${dto.content}
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
	
	
	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>


</body>

</html>