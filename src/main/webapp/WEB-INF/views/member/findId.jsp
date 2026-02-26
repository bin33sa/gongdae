<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="section bg-light">
		<div class="container">

			<div class="row justify-content-center" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
					<div class="bg-white box-shadow my-5 p-5">
	                    <h3 class="text-center pt-3">아이디 찾기</h3>
	                    
	                    <form name="idForm" action="" method="post" class="row g-3 mb-2">
							<div class="col-12">
								<p class="form-control-plaintext text-center">
									메일 인증을 하고 메일에 아이디롤 보낼지, 마스킹된 아이디를 보여줄지 모르겠다 
								</p>
	                        </div>
	                        	                    
							<div class="col-12">
								<input type="text" name="email" class="form-control form-control-lg" placeholder="메일">
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
			</div>

		</div>
	</div>
</main>

<script type="text/javascript">
function sendOk() {
	const f = document.idForm;

	if(! f.email.value.trim()) {
		alert('이메일을 입력하세요. ');
		f.login_id.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/member/findId';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>