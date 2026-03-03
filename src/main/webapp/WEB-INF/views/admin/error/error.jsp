<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 오류 페이지</title>

<jsp:include page="/WEB-INF/views/admin/include/headerResources.jsp" />
</head>
<body class="admin-page">

	<div class="admin-layout">

		<jsp:include page="/WEB-INF/views/admin/include/header.jsp" />

		<div class="admin-body">

			<jsp:include page="/WEB-INF/views/admin/include/left.jsp" />

			<main class="admin-content">

				<div class="dashboard-box"
					style="max-width: 600px; margin: 80px auto; text-align: center;">

					<h3 style="margin-bottom: 20px;">${title}</h3>
					<hr>

					<div style="margin: 40px 0;">
						<p>${message}</p>
					</div>

					<button type="button" class="btn btn-danger w-100"
						onclick="history.back();">이전화면으로 이동</button>

				</div>

			</main>

		</div>

		<jsp:include page="/WEB-INF/views/admin/include/footer.jsp" />

	</div>

	<jsp:include page="/WEB-INF/views/admin/include/footerResources.jsp" />

</body>
</html>