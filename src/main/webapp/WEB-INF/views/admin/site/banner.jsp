<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<body class="admin-page">
<div class="admin-layout">
    <header class="admin-header">
        <div class="admin-logo">공대생</div>
        <div class="admin-user-area"><span>관리자님</span></div>
    </header>
    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content">
            <h3 class="fw-bold mb-5">배너 및 팝업 설정</h3>
            
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="dashboard-box">
                        <h5 class="fw-bold mb-4">메인 슬라이드 배너</h5>
                        <div class="mb-4 p-5 text-center border border-dashed rounded" style="background: rgba(255,255,255,0.05);">
                            <i class="bi bi-image text-muted fs-1"></i>
                            <p class="mt-2 text-muted">현재 등록된 배너 이미지가 없습니다.</p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">배너 링크 URL</label>
                            <input type="text" class="form-control" placeholder="https://...">
                        </div>
                        <button class="btn btn-purple w-100">이미지 업로드 및 변경</button>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="dashboard-box">
                        <h5 class="fw-bold mb-4">이벤트/공지 팝업</h5>
                        <div class="form-check form-switch mb-4">
                            <input class="form-check-input" type="checkbox" id="popupSwitch" checked>
                            <label class="form-check-label text-main" for="popupSwitch">홈페이지 접속 시 팝업 노출</label>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">팝업 제목</label>
                            <input type="text" class="form-control" value="신학기 파티룸 대관 할인 이벤트!">
                        </div>
                        <button class="btn btn-outline-secondary text-white w-100">팝업 내용 수정</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>