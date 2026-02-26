<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>template</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="section bg-light">
		<div class="container">
			<h3 class="text-center pt-3">template</h3>
			
			<a href="${pageContext.request.contextPath}">template link</a>
			              
			<form name="templateForm" action="" method="post" class="row g-3 mb-2">
				<div class="col-12">
					<p class="form-control-plaintext text-center">
						template
					</p>
				</div>
			                  	                    
				<div class="col-12">
					<input type="text" name="login_id" class="form-control form-control-lg" placeholder="아이디">
				</div>
				<div class="col-12 text-center">
					<button type="button" class="btn-accent btn-lg w-100" onclick="sendOk();">확인 <i class="bi bi-check2"></i></button>
				</div>
          	</form>
			               
			<div>
				<p class="form-control-plaintext text-center text-danger">${message}</p>
			</div>

		</div>
	</div>
</main>

<script type="text/javascript">
function sendOk() {

	f.action = '${pageContext.request.contextPath}/';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>