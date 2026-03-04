<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호스트 로그인 - 공대생</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        :root {
            --main-color: #1C6296; 
            --point-color: #F8D153; 
        }
        
        /* 화면 전체를 사용하여 중앙 정렬 */
        body {
            background-color: #f8f9fa;
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }
        
        /* 로그인 카드 폼 */
        .login-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            overflow: hidden;
            width: 100%;
            max-width: 420px;
            margin: 20px;
        }
        
        .login-header {
            background-color: var(--main-color);
            color: #fff;
            padding: 40px 20px;
            text-align: center;
        }
        
        .login-body {
            padding: 40px 30px;
        }
        
        /* 입력창 스타일 */
        .form-control {
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 15px;
        }
        
        .form-control:focus {
            border-color: var(--main-color);
            box-shadow: 0 0 0 0.2rem rgba(28, 98, 150, 0.25);
        }
        
        /* 로그인 버튼 */
        .btn-login {
            background-color: var(--point-color);
            color: #333;
            font-weight: bold;
            font-size: 1.1rem;
            padding: 14px;
            border-radius: 8px;
            border: none;
            width: 100%;
            margin-top: 15px;
            transition: all 0.2s ease;
        }
        
        .btn-login:hover {
            background-color: #e5bf42;
            transform: translateY(-2px);
        }
        
        /* 하단 링크 (아이디 찾기 등) */
        .login-footer {
            text-align: center;
            margin-top: 25px;
            font-size: 0.9rem;
        }
        
        .login-footer a {
            color: #666;
            text-decoration: none;
            margin: 0 8px;
        }
        
        .login-footer a:hover {
            color: var(--main-color);
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="login-header">
            <h3 class="fw-bold mb-0">호스트 로그인</h3>
            <p class="mt-2 mb-0 opacity-75 small">공간을 등록하고 수익을 관리하세요</p>
        </div>
        
        <div class="login-body">
            <form action="<c:url value='/host/loginProc'/>" method="post">
                
                <div class="mb-3">
                    <label for="username" class="form-label text-muted small fw-bold">아이디 (이메일)</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="아이디를 입력해주세요" required autofocus>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label text-muted small fw-bold">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요" required>
                </div>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger p-2 small mb-3 text-center" style="font-size: 13px;">
                        <i class="bi bi-exclamation-circle"></i> 아이디 또는 비밀번호가 일치하지 않습니다.
                    </div>
                </c:if>

                <sec:csrfInput/>
                
                <button type="submit" class="btn btn-login">로그인</button>
            </form>
            
            <div class="login-footer">
                <a href="<c:url value='/host/findId'/>">아이디 찾기</a> | 
                <a href="<c:url value='/host/findPwd'/>">비밀번호 찾기</a> | 
                <a href="<c:url value='/host/signup'/>" class="fw-bold" style="color: var(--main-color);">호스트 가입</a>
            </div>
            
            <div class="text-center mt-4">
                <a href="<c:url value='${pageContext.request.contextPath}/host/dashboard'/>" class="text-muted small text-decoration-none">
                    <i class="bi bi-house-door"></i> 로그인 테스트
                </a>
            </div>
        </div>
    </div>

</body>
</html>