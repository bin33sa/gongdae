<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 고객 상담</title>
</head>
<body class="admin-page">

<div class="admin-layout">
    <header class="admin-header">
        <div class="admin-logo">공대생</div>
        <div class="admin-user-area">
            <span><strong><sec:authentication property="principal.member.name"/></strong> 관리자님</span>
            <a href="${pageContext.request.contextPath}/member/logout" class="admin-logout"><i class="bi bi-box-arrow-right"></i> 로그아웃</a>
        </div>
    </header>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">실시간 고객 상담</h3>
                    <p class="mb-0 text-muted">문의 사항에 실시간으로 답변하여 고객 만족도를 높이세요.</p>
                </div>
                <div class="badge bg-primary px-3 py-2">STOMP Connected</div>
            </div>

            <div class="dashboard-box">
                <div id="roomListBody" class="room-flex">
                    <c:forEach var="room" items="${rooms}">
                        <div class="room-card" 
                             onclick="openChatModal('${room.roomId}', '${room.nickname}', '${room.memberId}')"
                             data-memberId="${room.memberId}">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div class="fw-bold fs-5">
                                    <span class="${room.online ? 'dot bg-online' : 'dot bg-offline'}"></span>
                                    ${room.nickname}
                                </div>
                                <span class="badge bg-danger rounded-pill">${room.adminUnreadCount == 0 ? '' : room.adminUnreadCount}</span>
                            </div>
                            <div class="text-muted small d-flex justify-content-between">
                                <span>최근 활동</span>
                                <span>${fn:substringBefore(fn:replace(room.lastTime, 'T', ' '), '.')}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </div>
</div>

<div class="modal fade" id="chatModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-chat-dots me-2"></i> <span id="targetNickname"></span>님 상담</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div id="modal-chat-body"></div>
            <div class="modal-footer p-3">
                <div class="input-group">
                    <input type="text" id="adminInput" class="form-control bg-dark border-secondary text-white" placeholder="메시지 입력">
                    <button class="btn btn-purple" onclick="sendAdminMessage()">전송</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script type="text/javascript">
    var stompClient = null;
    var currentRoomId = null;
    var adminId = '<sec:authentication property="principal.member.member_id"/>';
    var lastDate = null;
    
</script>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>