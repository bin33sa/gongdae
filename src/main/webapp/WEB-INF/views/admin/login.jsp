<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공대생 - 관리자 시스템</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style>
    body {
        font-family: 'Pretendard', -apple-system, sans-serif;
        background-color: #f4f6f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .admin-login-box {
        background: #ffffff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        width: 100%;
        max-width: 400px;
    }
    .admin-login-box h2 {
        text-align: center;
        color: #0a2540;
        margin-bottom: 30px;
        font-weight: 800;
        letter-spacing: -1px;
    }
    .form-group {
        margin-bottom: 20px;
    }
    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #555;
        font-size: 14px;
        font-weight: bold;
    }
    .form-group input {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 15px;
        transition: border-color 0.2s;
    }
    .form-group input:focus {
        border-color: #0a2540;
        outline: none;
    }
    .btn-submit {
        width: 100%;
        padding: 14px;
        background-color: #0a2540;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
        transition: background-color 0.2s;
    }
    .btn-submit:hover {
        background-color: #06182a;
    }
    .error-message {
        color: #dc3545;
        font-size: 13px;
        text-align: center;
        margin-top: 15px;
        font-weight: bold;
    }
    .back-link {
        display: block;
        text-align: center;
        margin-top: 25px;
        color: #888;
        text-decoration: none;
        font-size: 14px;
    }
    .back-link:hover {
        text-decoration: underline;
        color: #333;
    }
</style>
</head>
<body>

    <div class="admin-login-box">
        <h2>⚙️ 공대생 Admin</h2>
        
        <form name="adminLoginForm" action="${pageContext.request.contextPath}/member/login" method="post">
    
		    <input type="hidden" name="loginType" value="admin">
		    
		    <div class="form-group">
		        <label for="login_id">Admin ID</label>
		        <input type="text" id="login_id" name="login_id" class="form-control" placeholder="관리자 아이디를 입력하세요">
		    </div>
		    <div class="form-group">
		        <label for="password">Password</label>
		        <input type="password" id="password" name="password" class="form-control" autocomplete="off" placeholder="패스워드를 입력하세요">
		    </div>
		    
		    <div class="col-12 mt-4 text-center">
		        <button type="button" class="btn btn-primary btn-lg w-100 fw-bold" onclick="sendAdminLogin();">
		            관리자 접속
		        </button>
		    </div>
		</form>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">← 사용자 메인 페이지로 돌아가기</a>
    </div>

    <script type="text/javascript">
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