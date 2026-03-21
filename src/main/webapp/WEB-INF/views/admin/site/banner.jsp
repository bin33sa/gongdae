<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 배너 설정</title>
</head>
<body class="admin-page">
<div class="admin-layout">
    
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content">
            <h3 class="fw-bold mb-5">배너 및 팝업 설정</h3>
            
            <div class="row g-4">
                <div class="col-lg-6">
                    <form action="${pageContext.request.contextPath}/admin/site/updateBanner" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="type" value="MAIN_BANNER">
                        <input type="hidden" name="isActive" value="1">
                        
                        <div class="dashboard-box">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="fw-bold mb-0">메인 슬라이드 배너</h5>
                                <c:if test="${not empty mainBanner.saveFilename}">
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="resetBanner('MAIN_BANNER')">초기화</button>
                                </c:if>
                            </div>
                            
                            <div class="mb-4 text-center border border-secondary border-opacity-50 rounded overflow-hidden" style="background: rgba(255,255,255,0.05); min-height: 150px; position: relative;">
                                <c:choose>
                                    <c:when test="${not empty mainBanner.saveFilename}">
                                        <img src="${pageContext.request.contextPath}/uploads/banner/${mainBanner.saveFilename}" alt="메인 배너" style="width: 100%; height: auto; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="p-5">
                                            <i class="bi bi-image text-muted fs-1"></i>
                                            <p class="mt-2 text-muted mb-0">현재 등록된 배너 이미지가 없습니다.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label text-muted">이미지 파일 첨부</label>
                                <input type="file" name="selectFile" class="form-control bg-transparent text-main border-secondary" accept="image/*">
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted">배너 제목 (관리용)</label>
                                <input type="text" name="title" value="${mainBanner.title}" class="form-control bg-transparent text-main border-secondary" placeholder="예: 신학기 할인 배너">
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted">배너 클릭 시 이동할 URL</label>
                                <input type="text" name="linkUrl" value="${mainBanner.linkUrl}" class="form-control bg-transparent text-main border-secondary" placeholder="https://...">
                            </div>
                            <button type="submit" class="btn btn-purple w-100">메인 배너 저장</button>
                        </div>
                    </form>
                </div>

                <div class="col-lg-6">
                    <form action="${pageContext.request.contextPath}/admin/site/updateBanner" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="type" value="POPUP">
                        
                        <div class="dashboard-box">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="fw-bold mb-0">이벤트/공지 팝업</h5>
                                <c:if test="${not empty popup.saveFilename}">
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="resetBanner('POPUP')">초기화</button>
                                </c:if>
                            </div>

                            <div class="form-check form-switch mb-4">
                                <input class="form-check-input" type="checkbox" name="isActive_check" id="popupSwitch" value="1" ${popup.isActive == 1 ? 'checked' : ''} onchange="document.getElementById('popupActive').value = this.checked ? 1 : 0;">
                                <input type="hidden" name="isActive" id="popupActive" value="${popup.isActive == 1 ? 1 : 0}">
                                <label class="form-check-label text-main" for="popupSwitch">홈페이지 접속 시 팝업 활성화</label>
                            </div>
                            
                            <div class="mb-4 text-center border border-secondary border-opacity-50 rounded overflow-hidden" style="background: rgba(255,255,255,0.05); min-height: 150px;">
                                <c:choose>
                                    <c:when test="${not empty popup.saveFilename}">
                                        <img src="${pageContext.request.contextPath}/uploads/banner/${popup.saveFilename}" alt="팝업 배너" style="width: 100%; height: auto; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="p-5">
                                            <i class="bi bi-window text-muted fs-1"></i>
                                            <p class="mt-2 text-muted mb-0">현재 등록된 팝업 이미지가 없습니다.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="mb-3">
                                <label class="form-label text-muted">팝업 이미지 파일</label>
                                <input type="file" name="selectFile" class="form-control bg-transparent text-main border-secondary" accept="image/*">
                            </div>
                            <div class="mb-3">
                                <label class="form-label text-muted">팝업 제목</label>
                                <input type="text" name="title" value="${popup.title}" class="form-control bg-transparent text-main border-secondary" placeholder="팝업창 제목 입력">
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted">연결 URL</label>
                                <input type="text" name="linkUrl" value="${popup.linkUrl}" class="form-control bg-transparent text-main border-secondary" placeholder="https://...">
                            </div>
                            <button type="submit" class="btn btn-outline-secondary text-white w-100">팝업 설정 저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script>
function resetBanner(type) {
    if(!confirm("해당 배너(팝업)를 삭제하고 초기화하시겠습니까?")) return;
    fetch('${pageContext.request.contextPath}/admin/site/deleteBanner', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'type=' + type
    })
    .then(response => {
        if(response.ok) {
            alert("초기화가 완료되었습니다.");
            location.reload();
        } else {
            alert("초기화에 실패했습니다.");
        }
    });
}
</script>
</body>
</html>