<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<body class="admin-page">
<div class="admin-layout">
    <header class="admin-header"><div class="admin-logo">공대생</div></header>
    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content">
            <h3 class="fw-bold mb-5">UI 구성요소 및 테마 관리</h3>
            
            <div class="dashboard-box mb-4">
                <h5 class="fw-bold mb-4">테마 컬러 설정</h5>
                <div class="d-flex gap-4">
                    <div>
                        <label class="text-muted d-block mb-2">포인트 컬러</label>
                        <input type="color" class="form-control form-control-color bg-dark border-0" value="#3B82F6" style="width: 100px; height: 50px;">
                    </div>
                    <div>
                        <label class="text-muted d-block mb-2">배경 테마</label>
                        <select class="form-select" style="width: 200px;">
                            <option selected>다크 모드 (기본)</option>
                            <option>라이트 모드</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="dashboard-box">
                <h5 class="fw-bold mb-4">사이트 하단(Footer) 정보</h5>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="text-muted small mb-1">고객센터 번호</label>
                        <input type="text" class="form-control" value="1588-0000">
                    </div>
                    <div class="col-md-6">
                        <label class="text-muted small mb-1">이메일</label>
                        <input type="text" class="form-control" value="admin@gongdae.com">
                    </div>
                    <div class="col-12 mt-4">
                        <button class="btn btn-purple">변경사항 저장</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>