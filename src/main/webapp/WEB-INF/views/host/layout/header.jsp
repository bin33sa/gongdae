<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
    /* 호스트 테마: 붉은색 포인트 컬러 (#E53935), 그림자(Shadow) 제거 */
    :root {
        --host-primary: #E53935; 
    }
    
    .host-header {
        background-color: #ffffff;
        border-bottom: 2px solid var(--host-primary); /* 하단 적색 엣지 포인트 */
        height: 80px; 
    }
    
    .host-logo-text {
        color: var(--host-primary);
        font-size: 1.2rem;
        font-weight: bold;
        letter-spacing: -0.5px;
        margin-left: 8px;
    }

    /* 플랫 디자인 네비게이션 */
    .host-nav-link {
        color: #555;
        text-decoration: none;
        font-weight: 500;
        font-size: 16px;
        padding: 8px 12px;
        transition: color 0.2s;
    }
    .host-nav-link:hover, .host-nav-link.active {
        color: var(--host-primary); 
        border-bottom: 2px solid var(--host-primary); /* 마우스 호버 시 글자 아래 엣지 */
    }
    
    /* 우측 유저 메뉴 */
    .host-user-menu {
        display: flex;
        gap: 20px;
        font-size: 14px;
        font-weight: 500;
        align-items: center;
    }
    .host-user-menu a {
        text-decoration: none;
        color: #333;
        transition: color 0.2s;
    }
    .host-user-menu a:hover {
        color: var(--host-primary);
    }
    
    /* 테두리만 있는 플랫 버튼 */
    .btn-outline-host {
        background-color: transparent;
        color: var(--host-primary) !important;
        border: 1px solid var(--host-primary);
        border-radius: 4px;
        padding: 6px 16px;
        font-weight: bold;
        transition: background-color 0.2s;
    }
    .btn-outline-host:hover {
        background-color: #fff8f8;
    }
</style>

<div id="host-header" class="host-header d-flex align-items-center sticky-top">
    <div class="container position-relative d-flex align-items-center justify-content-between w-100">
        
        <div class="d-flex align-items-center gap-3">
          
            <a href="<c:url value='/'/>" class="d-flex align-items-center text-decoration-none">
               <img src="<c:url value='/dist/images/gds.PNG' />" alt="로고" style="max-height: 40px; width: auto;">
            </a>
            <a href="<c:url value='/host/main/prelogin'/>" class="d-flex align-items-center text-decoration-none">
               <span class="host-logo-text" style="max-height: 40px; width: auto;">| 호스트 센터</span>
            </a>
            
        </div>

        <div class="d-none d-md-flex flex-grow-1 justify-content-center">
            <sec:authorize access="isAnonymous()">
                <span class="fs-5 fw-bold" style="color: var(--host-primary);">공대생 <span class="text-dark fw-normal">| 공간 대여가 생각날 때</span></span>
            </sec:authorize>
            
            <sec:authorize access="isAuthenticated()">
                <nav class="d-inline-flex gap-3">
                    <a href="<c:url value='/host/main/home'/>" class="host-nav-link active">메인화면</a>
                    <a href="#" class="host-nav-link">상세매출</a>
                    <a href="#" class="host-nav-link">예약내역</a>
                    <a href="${pageContext.request.contextPath}/host/space/qna" class="host-nav-link">문의 답변</a>
                    <a href="#" class="host-nav-link">매장 관리</a>
                    <a href="<c:url value='/host/space/register'/>" class="host-nav-link">매장등록</a>
                    <a href="#" class="host-nav-link">공지사항</a>
                </nav>
            </sec:authorize>
        </div>

        <div class="host-user-menu">
            <sec:authorize access="isAnonymous()">
                <a href="<c:url value='/'/>" class="text-muted"><i class="bi bi-house-door"></i> 유저홈페이지</a>
                <a href="<c:url value='/host/member/login'/>" class="btn-outline-host">로그인</a>
            </sec:authorize>

            <sec:authorize access="isAuthenticated()">
                <a href="<c:url value='/'/>" class="text-muted"><i class="bi bi-house-door"></i> 유저홈페이지</a>
                <a href="#">호스트 정보수정</a>
                <form action="<c:url value='/logout'/>" method="post" class="d-inline m-0">
                    <button type="submit" class="btn btn-link p-0 text-decoration-none text-dark" style="font-size:14px; font-weight:500;">로그아웃</button>
                    <sec:csrfInput/>
                </form>
            </sec:authorize>
        </div>
        
    </div>
</div>