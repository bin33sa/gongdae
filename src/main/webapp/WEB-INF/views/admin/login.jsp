<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공대생 Admin - 로그인</title>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="admin-page admin-login-body">

    <div class="admin-login-box">
        <h2>⚙️ 공대생 Admin</h2>
        
        <form name="adminLoginForm" action="${pageContext.request.contextPath}/member/login" method="post">
            <input type="hidden" name="loginType" value="admin">
            
            <div class="form-group">
                <label for="login_id">Admin ID</label>
                <input type="text" id="login_id" name="login_id" placeholder="관리자 아이디">
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" autocomplete="off" placeholder="패스워드">
            </div>
            
            <button type="button" class="btn btn-purple w-100 py-3 mt-2" onclick="sendAdminLogin();">
                관리자 접속
            </button>
        </form>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">
            <i class="bi bi-arrow-left"></i> 사용자 메인 페이지로 돌아가기
        </a>
    </div>

    <script type="text/javascript">
        localStorage.removeItem('admin_sidebar_state_v1');

        function sendAdminLogin() {
            const f = document.adminLoginForm;
            
            if( ! f.login_id.value.trim() ) {
                alert("관리자 아이디를 입력하세요.");
                f.login_id.focus();
                return;
            }

            if( ! f.password.value.trim() ) {
                alert("패스워드를 입력하세요.");
                f.password.focus();
                return;
            }
            
            f.submit();
        }
        
        document.addEventListener("keydown", function(event) {
            if (event.key === "Enter") {
                sendAdminLogin();
            }
        });
    </script>

</body>
</html>