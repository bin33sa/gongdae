<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공대생 호스트 센터 - 로그인</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
<jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>

<style>
:root {
    --host-primary: #E53935;
}

/* 전체 배경 */
.host-page {
    background-color: #fafafa;
}

/* 중앙 정렬 wrapper */
.host-login-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: calc(100vh - 80px);
}

/* 로그인 박스 */
.host-login-box {
    width: 100%;
    max-width: 420px;
    padding: 40px 35px;
    border: 1px solid #eee;
    border-radius: 10px;
    background: #fff;
}

/* 타이틀 */
.host-login-title {
    font-weight: bold;
    color: #222;
}

/* input */
.host-input {
    height: 48px;
    border-radius: 6px;
    border: 1px solid #ddd;
    font-size: 14px;
}

.host-input:focus {
    border-color: var(--host-primary);
    box-shadow: none;
}

/* 버튼 */
.btn-host-login {
    height: 50px;
    background-color: var(--host-primary);
    color: #fff;
    border: none;
    font-weight: bold;
    border-radius: 6px;
    transition: background-color 0.2s;
}

.btn-host-login:hover {
    background-color: #d32f2f;
}

/* 체크박스 */
.form-check-input:checked {
    background-color: var(--host-primary);
    border-color: var(--host-primary);
}

/* 링크 */
.host-login-links a {
    color: #777;
    text-decoration: none;
    font-size: 14px;
}

.host-login-links a:hover {
    color: var(--host-primary);
}

/* 에러 */
.host-error {
    font-size: 14px;
    font-weight: 500;
}
</style>

</head>

<body class="host-page">

<div class="host-login-wrapper">
    <div class="host-login-box">

        <h3 class="text-center mb-4 host-login-title">
            <i class="bi bi-lock"></i> 호스트 로그인
        </h3>

        <form name="loginForm" method="post" class="row g-3">

            <input type="hidden" name="loginType" value="host">

            <div class="col-12">
                <label class="mb-1">아이디</label>
                <input type="text" name="login_id" class="form-control host-input" placeholder="아이디">
            </div>

            <div class="col-12">
                <label class="mb-1">패스워드</label>
                <input type="password" name="password" class="form-control host-input"
                       autocomplete="off" placeholder="패스워드">
            </div>

            <div class="col-12">
                <div class="form-check">
                    <input class="form-check-input rememberMe" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe"> 아이디 저장</label>
                </div>
            </div>

            <div class="col-12">
                <button type="button"
                        class="btn-host-login w-100"
                        onclick="sendLogin();">
                    로그인
                </button>
            </div>
        </form>

        <div class="mt-3">
            <p class="text-center text-danger host-error">
                ${message}${sessionScope.message}
            </p>
            <% session.removeAttribute("message"); %>
        </div>

        <div class="mt-3 host-login-links">
            <p class="text-center mb-0">
                <a href="${pageContext.request.contextPath}/member/findId">아이디 찾기</a> |
                <a href="${pageContext.request.contextPath}/member/findPwd">패스워드 찾기</a> |
                <a href="${pageContext.request.contextPath}/host/signup">호스트 가입</a>
            </p>
        </div>

    </div>
</div>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>
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

</body>
</html>