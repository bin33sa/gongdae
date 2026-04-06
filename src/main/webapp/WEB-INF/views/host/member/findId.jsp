<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호스트 아이디 찾기</title>
<jsp:include page="/WEB-INF/views/host/layout/headerResources.jsp"/>
</head>
<body>

<header><jsp:include page="/WEB-INF/views/host/layout/header.jsp"/></header>

<main>
	<div class="section bg-light">
		<div class="container">
			<div class="row justify-content-center" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
					<div class="bg-white box-shadow my-5 p-5">
	                    <h3 class="text-center pt-3">호스트 아이디 찾기</h3>
	                    <form name="idForm" action="" method="post" class="row g-3 mb-2 pt-3">
							<div class="col-12">
								<p class="form-control-plaintext text-center">
									가입 시 등록한 담당자 이름과 이메일을 입력하세요.
								</p>
	                        </div>
							<div class="col-12">
								<input type="text" name="name" class="form-control form-control-lg" placeholder="이름">
							</div>
							<div class="col-12">
								<input type="text" name="email" class="form-control form-control-lg" placeholder="이메일">
							</div>
							<div class="col-12 text-center mt-4">
								<button type="button" class="btn-accent btn-lg w-100" onclick="sendOk();">확인 <i class="bi bi-check2"></i></button>
							</div>
	                    </form>
						<div><p class="form-control-plaintext text-center text-danger">${message}</p></div>
	                </div>
				</div>
			</div>
		</div>
	</div>
</main>

<script>
function sendOk() {
	const f = document.idForm;
	if(! f.name.value.trim()) { alert('이름을 입력하세요.'); f.name.focus(); return; }
	if(! f.email.value.trim()) { alert('이메일을 입력하세요.'); f.email.focus(); return; }

	f.action = '${pageContext.request.contextPath}/host/findId';
	f.submit();
}
</script>

<footer><jsp:include page="/WEB-INF/views/host/layout/footer.jsp"/></footer>
<jsp:include page="/WEB-INF/views/host/layout/footerResources.jsp"/>

</body>
</html>