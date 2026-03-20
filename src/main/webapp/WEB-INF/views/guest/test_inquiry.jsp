<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게스트 문의 등록 테스트</title>
    
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    
    <style>
        body { background-color: #f8f9fa; }
        .test-container { max-width: 600px; margin: 50px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>

<main class="container">
    <div class="test-container">
        <h3 class="fw-bold mb-2 text-center text-primary"><i class="bi bi-envelope-paper"></i> 게스트 문의하기 (테스트)</h3>
        <p class="text-muted text-center mb-4">호스트에게 공간에 대한 질문을 남겨보세요.</p>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <strong>알림!</strong> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="<c:url value='/guest/inquiry/write'/>" method="post">
            
            <div class="mb-3">
                <label class="form-label fw-bold">문의할 공간 번호 (SPACE_NO)</label>
                <input type="number" name="spaceNo" class="form-control" placeholder="예: 15 (DB에 존재하는 공간 번호)" required>
                <div class="form-text text-danger">* 반드시 DB의 SPACE 테이블에 있는 본인의 공간 번호를 입력해야 호스트 센터에 뜹니다!</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">문의 제목</label>
                <input type="text" name="title" class="form-control" placeholder="예: 주차 관련 문의드립니다." required>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">문의 내용</label>
                <textarea name="content" class="form-control" rows="5" placeholder="궁금한 점을 상세히 적어주세요." required></textarea>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">호스트에게 전송하기</button>
            </div>

            <sec:csrfInput/>
        </form>
    </div>
</main>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>