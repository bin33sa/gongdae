<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header class="admin-header">
    <div class="admin-logo">
        공대생 관리자 
    </div>

    <div class="admin-user-area">
        <span><strong><sec:authentication property="principal.member.name"/></strong> 관리자님</span>
        
        <a href="${pageContext.request.contextPath}/member/logout" class="admin-logout">
            <i class="bi bi-box-arrow-right"></i> 로그아웃
        </a>
    </div>
</header>