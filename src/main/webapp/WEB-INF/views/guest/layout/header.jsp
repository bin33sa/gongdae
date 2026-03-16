<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div id="header" class="header d-flex align-items-center sticky-top">

    <div class="container position-relative d-flex align-items-center justify-content-between w-100">

        <!-- 왼쪽 -->
        <div class="header-left d-flex align-items-center gap-3">

            <!-- 햄버거 -->
            <button class="menu-toggle"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasExample"
                    aria-controls="offcanvasExample">

                <i class="bi bi-list"></i>

            </button>

            <!-- 로고 -->
            <a href="<c:url value='/' />"
               class="logo d-flex align-items-center text-decoration-none">

                <img src="<c:url value='/dist/images/gds.PNG' />"
                     alt="공대생 로고"
                     class="logo-img">

            </a>

        </div>


        

        <!-- 검색 -->
        <div class="search-bar d-none d-md-block">

            <form action="<c:url value='/space/search'/>" method="GET">

                <input type="text"
                       id="searchInput"
                       name="kwd"
                       placeholder="어떤 공간을 찾으시나요?">

                <button type="button"
                        class="search-clear-btn"
                        onclick="clearSearch()">

                    <i class="bi bi-x"></i>

                </button>

                <span class="search-divider"></span>

                <button type="submit"
                        class="search-btn">

                    <i class="bi bi-search"></i>

                </button>

            </form>

        </div>

    </div>

</div>

<jsp:include page="/WEB-INF/views/guest/layout/left.jsp"/>