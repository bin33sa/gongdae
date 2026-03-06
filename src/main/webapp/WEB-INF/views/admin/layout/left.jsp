<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<aside class="admin-sidebar d-flex flex-column">

    <div class="px-4 py-4 fw-bold fs-4 text-white">
        관리자 메뉴
    </div>

    <div class="sidebar-nav flex-grow-1 overflow-auto mt-2">
        
        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-graph-up-arrow me-3"></i> 사이트 매출 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/sales/daily" class="nav-link sub-menu-item">일별 매출</a>
                <a href="/admin/sales/monthly" class="nav-link sub-menu-item">월별 매출</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-chat-dots me-3"></i> 문의 채팅 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/chat/list" class="nav-link sub-menu-item">채팅 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-people me-3"></i> 유저 회원 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/users/list" class="nav-link sub-menu-item">회원 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-person-badge me-3"></i> 호스트 회원 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/hosts/list" class="nav-link sub-menu-item">호스트 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-shop me-3"></i> 매장 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/spaces/list" class="nav-link sub-menu-item">매장 목록</a>
            </div>
        </div>

        <div class="menu-group">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-pencil-square me-3"></i> 게시글 관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/notices" class="nav-link sub-menu-item">공지사항</a>
            </div>
        </div>

        <div class="menu-group mb-4">
            <div class="menu-title menu-item d-flex align-items-center px-4" style="cursor:pointer;">
                <i class="bi bi-shield-exclamation me-3"></i> 신고내역관리 <i class="bi bi-chevron-down ms-auto small"></i>
            </div>
            <div class="submenu nav flex-column">
                <a href="/admin/reports/list" class="nav-link sub-menu-item">신고 목록</a>
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