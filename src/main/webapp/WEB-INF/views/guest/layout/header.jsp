<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<div id="header" class="header d-flex align-items-center sticky-top">
    <div class="container position-relative d-flex align-items-center justify-content-between w-100">
        
        <div class="d-flex align-items-center gap-3">
            <a class="btn border-0 p-0 text-dark" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
                <i class="bi bi-list fs-3"></i>
            </a>
            <a href="<c:url value='/' />" class="logo d-flex align-items-center text-decoration-none">
            <img src="<c:url value='/dist/images/gds.PNG' />" alt="공대생 로고" class="logo-img">
            </a>
        </div>

        <div class="search-bar d-none d-md-block mx-4">
            <form action="<c:url value='/space/search'/>" method="GET">
                <input type="text" id="searchInput" name="kwd" placeholder="어떤 공간을 찾으시나요?">
                <!-- X 버튼 -->
	            <button type="button" class="search-clear-btn" onclick="clearSearch()">
	                <i class="bi bi-x"></i>
	            </button>
	            <span class="search-divider"></span>
	            <!-- 검색 버튼 -->
	            <button type="submit" class="search-btn">
	                <i class="bi bi-search"></i>
	            </button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/guest/layout/left.jsp"/>