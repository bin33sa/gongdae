<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<aside class="admin-sidebar d-flex flex-column sticky-top" style="height: 100vh; top: 0;">

    <div class="px-4 py-4 fw-bold fs-4 text-white">
        <a href="${pageContext.request.contextPath}/admin/main" class="text-white text-decoration-none">관리자 메뉴</a>
    </div>

    <div class="sidebar-nav flex-grow-1 overflow-auto mt-2">
        
        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-graph-up-arrow me-3"></i> 사이트 매출 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/sales/daily" class="nav-link sub-menu-item">일별 매출</a>
                <a href="${pageContext.request.contextPath}/admin/sales/monthly" class="nav-link sub-menu-item">월별 매출</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-chat-dots me-3"></i> 문의 채팅 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/chat/room" class="nav-link sub-menu-item">채팅 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-people me-3"></i> 게스트 회원 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/guests/list" class="nav-link sub-menu-item">게스트 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-person-badge me-3"></i> 호스트 회원 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/hosts/list" class="nav-link sub-menu-item">호스트 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-shop me-3"></i> 매장 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/spaces/list" class="nav-link sub-menu-item">매장 목록</a>
                <a href="${pageContext.request.contextPath}/admin/spaces/premium" class="nav-link sub-menu-item">프리미엄 목록</a>
                <a href="${pageContext.request.contextPath}/admin/spaces/approval" class="nav-link sub-menu-item">신청 리스트</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-pencil-square me-3"></i> 게시글 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/bbs/notice/list" class="nav-link sub-menu-item">공지사항 관리</a>
                <a href="${pageContext.request.contextPath}/admin/bbs/event/list" class="nav-link sub-menu-item">이벤트 관리</a>
                <a href="${pageContext.request.contextPath}/admin/bbs/faq/list" class="nav-link sub-menu-item">FAQ 관리</a>
            </div>
        </div>

        <div class="menu-group mb-4" data-index="6">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-gear-wide-connected me-3"></i> 
                <span>사이트 관리</span> 
                <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="${pageContext.request.contextPath}/admin/site/report" class="nav-link sub-menu-item">신고 내역 관리</a>
                <a href="${pageContext.request.contextPath}/admin/site/banner" class="nav-link sub-menu-item">배너/팝업 관리</a>
                <a href="${pageContext.request.contextPath}/admin/site/component" class="nav-link sub-menu-item">UI 구성요소 관리</a>
            </div>
        </div>

    </div>

    <div class="sidebar-user-profile mt-auto p-4 border-top">
        <div class="d-flex align-items-center">
            <div class="profile-avatar me-3">
                <sec:authentication property="principal.member.name" htmlEscape="false" var="userName" />
                ${userName.substring(0,1)}
            </div>
            <div>
                <div class="fw-bold text-white"><sec:authentication property="principal.member.name"/></div>
                <div class="small text-muted">관리자 계정</div>
            </div>
        </div>
    </div>

</aside>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const groups = document.querySelectorAll('.menu-group');
        const currentPath = window.location.pathname;
        const STORAGE_KEY = 'admin_sidebar_state_v1';
        let openIndices = [];
        try {
            openIndices = JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
            if (!Array.isArray(openIndices)) openIndices = [];
        } catch(e) {
            openIndices = [];
        }

        groups.forEach((group, index) => {
            const title = group.querySelector('.menu-title');
            const submenu = group.querySelector('.submenu');      
            let isCurrentPage = false;
            const links = group.querySelectorAll('.sub-menu-item');
            links.forEach(link => {
                const href = link.getAttribute('href');
                if (currentPath.includes(href) && href !== "/" && href !== "") {
                    link.classList.add('active');
                    isCurrentPage = true;
                }
            });
            let isOpen = isCurrentPage || openIndices.includes(index);
            const render = () => {
                if (isOpen) {
                    group.classList.add('active');
                    if (submenu) submenu.style.display = 'flex';
                    if (!openIndices.includes(index)) openIndices.push(index);
                } else {
                    group.classList.remove('active');
                    if (submenu) submenu.style.display = 'none';
                    openIndices = openIndices.filter(i => i !== index);
                }
                localStorage.setItem(STORAGE_KEY, JSON.stringify(openIndices));
            };
            render();
            title.onclick = function(e) {
                e.preventDefault();
                e.stopPropagation(); 
                
                isOpen = !isOpen; 
                render();         
            };
        });
    });
</script>