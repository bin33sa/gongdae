<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - UI 구성요소 관리</title>
</head>
<body class="admin-page">
<div class="admin-layout">
    
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        
        <main class="admin-content">
            <h3 class="fw-bold mb-2">UI 구성요소 및 테마 관리</h3>
            <p class="text-muted mb-5">서비스 전반에 걸쳐 사용되는 텍스트 및 기본 설정값을 관리합니다.</p>
            
            <div class="dashboard-box">
                <div class="row g-4">
                    <c:forEach var="dto" items="${list}">
                        <div class="col-md-6">
                            <form class="component-form p-3 border border-secondary border-opacity-25 rounded bg-dark bg-opacity-25" onsubmit="event.preventDefault(); saveComponent(this);">
                                <input type="hidden" name="componentKey" value="${dto.componentKey}">
                                
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <label class="fw-bold text-main mb-0">${dto.description}</label>
                                    <span class="badge bg-secondary bg-opacity-25 text-muted font-monospace">${dto.componentKey}</span>
                                </div>
                                
                                <div class="input-group mt-3">
                                    <c:choose>
                                        <c:when test="${dto.componentKey == 'POINT_COLOR'}">
                                            <input type="color" name="componentValue" class="form-control form-control-color bg-transparent border-secondary" value="${dto.componentValue}" title="색상 선택">
                                            <input type="text" class="form-control bg-transparent text-main border-secondary w-50" value="${dto.componentValue}" readonly>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" name="componentValue" class="form-control bg-transparent text-main border-secondary" value="${dto.componentValue}">
                                        </c:otherwise>
                                    </c:choose>
                                    <button type="submit" class="btn btn-purple">저장</button>
                                </div>
                                <div class="mt-2 text-end text-muted small" style="font-size: 0.75rem;">
                                    최종 수정: ${dto.adminName != null ? dto.adminName : '시스템'} (${dto.updatedAt})
                                </div>
                            </form>
                        </div>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <div class="col-12 py-5 text-center text-muted">
                            등록된 시스템 컴포넌트 값이 없습니다.
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script>
function saveComponent(formElement) {
    const formData = new FormData(formElement);
    const query = new URLSearchParams(formData).toString();
    
    fetch('${pageContext.request.contextPath}/admin/site/updateComponent', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: query
    })
    .then(response => {
        if(response.ok) {
            alert("설정이 성공적으로 저장되었습니다.");
            location.reload();
        } else {
            alert("저장에 실패했습니다.");
        }
    })
    .catch(error => {
        console.error("통신 오류:", error);
    });
}
</script>
</body>
</html>