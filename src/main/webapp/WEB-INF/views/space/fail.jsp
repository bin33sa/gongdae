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

	<div class="row justify-content-center" data-aos="fade-up" data-aos-delay="200">
		<div class="col-md-5">
			<div class="bg-white box-shadow mt-5 mb-5 p-5">
				<h3 class="text-center pt-3">결재 실패</h3>
				<hr class="mt-4">
				
				<div class="my-5">
					<div class="text-center">
						<p class="text-center" id="code"></p>
						<p class="text-center" id="message"></p>
					</div>
				</div>
                   
				<div>
					<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/';">
						메인화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

<script type="text/javascript">
	const urlParams = new URLSearchParams(window.location.search);
	
	const codeElement = document.getElementById("code");
	const messageElement = document.getElementById("message");
	
	codeElement.textContent = "에러코드: " + urlParams.get("code");;
	messageElement.textContent = "실패 사유: " + urlParams.get("message");;
</script>

</body>
</html>