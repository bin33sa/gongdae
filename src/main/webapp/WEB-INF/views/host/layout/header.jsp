<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
    /* 스페이스클라우드 테마 및 헤더 전용 스타일 */
    :root {
       /* 로고에서 추출한 메인 파란색 */
        --main-color: #1C6296; 
        /* 로고 안의 창문 불빛 노란색 (나중에 버튼이나 호버 효과에 포인트로 쓰기 좋습니다) */
        --point-color: #F8D153;
    }
    
    .header {
        background-color: #fff;
        border-bottom: 1px solid #eee;
        height: 80px; 
    }
    
    .sitename {
        font-size: 24px;
        font-weight: bold;
        color: var(--main-color);
        letter-spacing: -1px;
    }
    .dot { color: #333; }

    /* 중앙 검색창 스타일 */
    .search-bar {
        flex: 1;
        max-width: 400px;
        position: relative;
    }
    .search-bar input {
        width: 100%;
        padding: 10px 20px;
        border: 2px solid var(--main-color);
        border-radius: 30px;
        outline: none;
        font-size: 15px;
    }

    /* 우측 유저 메뉴 스타일 */
    .user-menu {
        display: flex;
        gap: 20px;
        font-size: 14px;
        font-weight: 500;
        align-items: center;
    }
    .user-menu a {
        text-decoration: none;
        color: #333;
        transition: color 0.2s;
    }
    .user-menu a:hover {
        color: var(--main-color);
    }
    .host-btn {
        color: var(--main-color) !important;
        font-weight: bold;
    }
</style>

<div id="header" class="header d-flex align-items-center sticky-top">
    <div class="container position-relative d-flex align-items-center justify-content-between w-100">
        
        <div class="d-flex align-items-center gap-3">
            <a class="btn border-0 p-0 text-dark" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
                <i class="bi bi-list fs-3"></i>
            </a>
            <a href="<c:url value='/' />" class="logo d-flex align-items-center text-decoration-none">
               <img src="<c:url value='/dist/images/gds.PNG' />" alt="HaruClass 로고" style="max-height: 40px; width: auto;">
            </a>
        </div>

        <div class="search-bar d-none d-md-block mx-4">
            <form action="<c:url value='/search'/>" method="GET">
                <input type="text" name="keyword" placeholder="지역, 공간 유형, 공간명 검색">
            </form>
        </div>

        <div class="user-menu">
            <sec:authorize access="isAnonymous()">
                <a href="<c:url value='${pageContext.request.contextPath}/host/login'/>">로그인</a>
                <a href="<c:url value='/host/signup'/>">회원가입</a>
                <a href="<c:url value='/'/>" class="host-btn">공간 등록하기</a>
            </sec:authorize>

            <sec:authorize access="hasRole('ROLE_GUEST')">
                <a href="<c:url value='/mypage'/>">마이페이지</a>
                <form action="<c:url value='/logout'/>" method="post" class="d-inline m-0">
                    <button type="submit" class="btn btn-link p-0 text-decoration-none text-dark" style="font-size:14px; font-weight:500;">로그아웃</button>
                    <sec:csrfInput/>
                </form>
            </sec:authorize>

            <sec:authorize access="hasRole('ROLE_HOST')">
                <a href="<c:url value='/host/center'/>" class="host-btn">호스트 센터</a>
                <a href="<c:url value='/mypage'/>">마이페이지</a>
                <form action="<c:url value='/logout'/>" method="post" class="d-inline m-0">
                    <button type="submit" class="btn btn-link p-0 text-decoration-none text-dark" style="font-size:14px; font-weight:500;">로그아웃</button>
                    <sec:csrfInput/>
                </form>
            </sec:authorize>
            
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <a href="<c:url value='/admin/dashboard'/>">관리자 페이지</a>
                <form action="<c:url value='/logout'/>" method="post" class="d-inline m-0">
                    <button type="submit" class="btn btn-link p-0 text-decoration-none text-dark" style="font-size:14px; font-weight:500;">로그아웃</button>
                    <sec:csrfInput/>
                </form>
            </sec:authorize>
        </div>
        
        <i class="mobile-nav-toggle d-xl-none bi bi-list" style="display:none"></i>
    </div>
</div>

<jsp:include page="/WEB-INF/views/guest/layout/left.jsp"/>