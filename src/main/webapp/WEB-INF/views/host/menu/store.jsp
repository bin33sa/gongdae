<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매장 관리 - 공대생 호스트 센터</title>

    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/store.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">

    <!-- 타이틀 -->
    <div class="mb-4">
        <h3 class="fw-bold">매장 관리</h3>
        <p class="text-muted">등록된 공간을 관리하고 수정하세요.</p>
    </div>

  

   <div class="row g-4">
        
        <c:if test="${empty list}">
            <div class="col-12 text-center p-5 text-muted border rounded bg-light mt-4">
                <i class="bi bi-shop fs-1 d-block mb-3"></i>
                <h5>등록된 매장이 없습니다.</h5>
                <p>새로운 공간을 등록하고 호스팅을 시작해보세요!</p>
                <a href="<c:url value='/host/space/write'/>" class="btn btn-primary mt-2">공간 등록하기</a>
            </div>
        </c:if>

        <c:forEach var="dto" items="${list}">
            <div class="col-md-4">
                <div class="store-card">

                    <c:choose>
                        <c:when test="${not empty dto.fileUrl}">
                            <img src="${pageContext.request.contextPath}/uploads/space/${dto.fileUrl}" class="store-img" style="object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/400x200?text=No+Image" class="store-img">
                        </c:otherwise>
                    </c:choose>

                    <div class="store-body">
                        <h5 class="store-title">${dto.spaceName}</h5>

                        <p class="store-desc text-truncate">
                            ${not empty dto.spaceIntro ? dto.spaceIntro : '등록된 공간 소개글이 없습니다.'}
                        </p>

                        <div class="store-info">
                            <span><i class="bi bi-geo-alt"></i> ${dto.region}</span>
                            <span><i class="bi bi-people"></i> 최대 ${dto.maxCapacity}명</span>
                        </div>

                        <div class="store-actions">
                            <button type="button" class="btn btn-sm btn-edit" 
                                    onclick="location.href='<c:url value="/host/space/update?spaceNo=${dto.spaceNo}"/>'">수정</button>
                            
                            <form action="<c:url value='/host/space/delete'/>" method="post" class="m-0" onsubmit="return confirm('정말 [${dto.spaceName}] 매장을 삭제하시겠습니까?');">
                                <input type="hidden" name="spaceNo" value="${dto.spaceNo}">
                                <button type="submit" class="btn btn-sm btn-delete">삭제</button>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </c:forEach>

    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>