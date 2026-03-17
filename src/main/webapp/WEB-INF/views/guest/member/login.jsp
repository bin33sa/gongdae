<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>로그인</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/page/login.css"
	type="text/css">

</head>


<body>


	<header>
		<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />
	</header>



	<main class="login-wrapper">

		<div class="container">

			<div class="row justify-content-center align-items-center">

				<div class="col-lg-4 col-md-6">

					<div class="login-card">

						<div class="login-title text-center">

							<h2>로그인</h2>

							<p class="login-sub">공대생 공간 예약 서비스</p>

						</div>



						<form name="loginForm" method="post" class="login-form">

							<div class="form-group">

								<input type="text" name="login_id" class="form-control"
									placeholder="아이디">

							</div>


							<div class="form-group">

								<input type="password" name="password" class="form-control"
									placeholder="패스워드" autocomplete="off">

							</div>


							<div class="login-option">

								<label class="form-check-label"> <input
									class="form-check-input rememberMe" type="checkbox"
									id="rememberMe"> 아이디 저장

								</label>

							</div>


							<button type="button" class="btn-login" onclick="sendLogin();">

								로그인</button>


						</form>



						<c:if test="${not empty message}">
							<p class="login-error">${message}</p>
						</c:if>



						<div class="login-links">

							<a href="${pageContext.request.contextPath}/guest/findId">아이디
								찾기</a> <span>|</span> <a
								href="${pageContext.request.contextPath}/guest/findPwd">비밀번호
								찾기</a> <span>|</span> <a
								href="${pageContext.request.contextPath}/guest/signup">회원가입</a>

						</div>



					</div>

				</div>

			</div>

		</div>

	</main>



	<script>
		function sendLogin() {

			const f = document.loginForm;

			if (!f.login_id.value.trim()) {
				f.login_id.focus();
				return;
			}

			if (!f.password.value.trim()) {
				f.password.focus();
				return;
			}

			f.action = '${pageContext.request.contextPath}/member/login';
			f.submit();

		}
	</script>



	<footer>
		<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

</body>

</html>