<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 전용 CSS 연결 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/header.css">

<div class="host-header sticky-top">
    <div class="container host-header-inner">

        <!-- 로고 -->
        <div class="host-logo">
            <a href="<c:url value='/'/>">
                <img src="<c:url value='/dist/images/gds.PNG'/>" alt="logo">
            </a>
            <a href="<c:url value='/host/main/prelogin'/>">
            <span class="host-logo-text">| 호스트센터</span>
            </a>
        </div>

        <!-- 메뉴 -->
        <sec:authorize access="hasRole('HOST')">
            <nav class="host-nav">

                <a href="<c:url value='/host/main/home'/>"
                   class="host-nav-link ${active == 'home' ? 'active' : ''}">
                   메인
                </a>

                <a href="<c:url value='/host/menu/sales'/>"
                   class="host-nav-link ${active == 'sales' ? 'active' : ''}">
                   매출
                </a>

                <a href="<c:url value='/host/menu/reservation'/>"
                   class="host-nav-link ${active == 'reservation' ? 'active' : ''}">
                   예약
                </a>

                <a href="<c:url value='/host/menu/qna'/>"
                   class="host-nav-link ${active == 'qna' ? 'active' : ''}">
                   문의
                </a>

                <a href="<c:url value='/host/menu/store'/>"
                   class="host-nav-link ${active == 'store' ? 'active' : ''}">
                   매장
                </a>

                <a href="<c:url value='/host/menu/space'/>"
                   class="host-nav-link ${active == 'space' ? 'active' : ''}">
                   등록
                </a>

            </nav>
        </sec:authorize>



        <!-- 우측 -->
        <div class="host-user-menu">

            <sec:authorize access="!hasRole('HOST')">
                <a href="/host/member/login">로그인</a>
            </sec:authorize>

            <sec:authorize access="hasRole('HOST')">
                <a href="#">호스트 정보수정</a>

                <form action="/member/logout" method="post" class="m-0">
                    <button type="submit" class="logout-btn">로그아웃</button>
                    <sec:csrfInput/>
                </form>
            </sec:authorize>

        </div>

    </div>
</div>