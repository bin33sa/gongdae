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
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">실시간 고객 상담</h3>
                    <p class="mb-0 text-muted">문의 사항에 실시간으로 답변하여 고객 만족도를 높이세요.</p>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <div class="badge bg-primary px-3 py-2">STOMP Connected</div>
                    <button id="btnNewChat" class="btn btn-outline-primary btn-sm px-3 py-2">
                        <i class="bi bi-plus-lg me-1"></i> 새 상담 방 생성
                    </button>
                </div>
            </div>

            <div class="dashboard-box">
                <div id="roomListBody" class="room-flex">
                    <c:if test="${empty rooms}">
                        <div class="w-100 text-center py-5 text-muted">진행 중인 상담 내역이 없습니다.</div>
                    </c:if>
                    <c:forEach var="room" items="${rooms}">
                        <div class="room-card" 
                             data-room-id="${room.roomId}" 
                             data-nickname="${empty room.nickname ? '회원' : room.nickname}" 
                             data-member-id="${room.memberId}">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div class="fw-bold fs-5">
                                    <span class="${room.online ? 'dot bg-online' : 'dot bg-offline'}"></span>
                                    ${empty room.nickname ? '회원' : room.nickname}
                                </div>
                                <span class="badge bg-danger rounded-pill unread-badge">${room.adminUnreadCount == 0 ? '' : room.adminUnreadCount}</span>
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
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-chat-dots me-2"></i> <span id="targetNickname"></span>님 상담</h5>
                <button type="button" id="btnCloseModal" class="btn-close btn-close-white" aria-label="Close"></button>
            </div>
            <div id="modal-chat-body" style="height: 450px; overflow-y: auto; padding: 20px;"></div>
            <div class="modal-footer p-3">
                <div class="input-group">
                    <input type="text" id="adminInput" class="form-control bg-dark border-secondary text-white" placeholder="메시지 입력">
                    <button id="btnSendMessage" class="btn btn-purple">전송</button>
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
    var currentMemberId = null; 
    var currentSubscription = null; 
    var chatModalInstance = null; 
    
    var adminId = '<sec:authentication property="principal.member.member_id" />';
    var adminName = '<sec:authentication property="principal.member.name" htmlEscape="false" />';

    document.addEventListener('DOMContentLoaded', () => {
        connect();
        bindEvents();
        
        var modalEl = document.getElementById('chatModal');
        if (typeof bootstrap !== 'undefined') {
            chatModalInstance = new bootstrap.Modal(modalEl);
            modalEl.addEventListener('hidden.bs.modal', function () {
                closeChatModal();
            });
        }
    });

    function bindEvents() {
        document.getElementById('roomListBody').addEventListener('click', function(e) {
            var card = e.target.closest('.room-card');
            if (!card) return; 
            
            var roomId = card.getAttribute('data-room-id');
            var nickname = card.getAttribute('data-nickname');
            var memberId = card.getAttribute('data-member-id');
            
            openChatModal(roomId, nickname, memberId);
        });

        document.getElementById('btnNewChat').addEventListener('click', async function() {
            var targetId = prompt("대화를 시작할 회원의 고유 번호(Member ID)를 입력하세요.\n(예: 5)");
            if (!targetId || isNaN(targetId)) return;
            
            try {
                var res = await fetch('${pageContext.request.contextPath}/admin/chat/checkRoom?memberId=' + targetId);
                var data = await res.json();
                
                if (data.error) {
                    alert(data.error);
                    return;
                }
                
                openChatModal(data.roomId, data.nickname, targetId);
            } catch(e) {
                alert("방 확인 중 오류가 발생했습니다.");
                console.error(e);
            }
        });

        document.getElementById('btnSendMessage').addEventListener('click', sendAdminMessage);
        document.getElementById('adminInput').addEventListener('keydown', function(e) {
            if(e.key === 'Enter') sendAdminMessage();
        });
        document.getElementById('btnCloseModal').addEventListener('click', closeChatModal);
    }

    function connect() {
        var socket = new SockJS('${pageContext.request.contextPath}/ws-chat');
        stompClient = Stomp.over(socket);
        stompClient.debug = null; 
        
        stompClient.connect({}, function (frame) {
            stompClient.subscribe('/topic/admin/new-room', function (res) {
                location.reload(); 
            });

            stompClient.subscribe('/topic/admin/status', function (res) {
                var data = JSON.parse(res.body);
                var roomCard = document.querySelector(`.room-card[data-member-id="\${data.memberId}"]`);
                if(roomCard) {
                    var dot = roomCard.querySelector('.dot');
                    if(dot) dot.className = data.status === 'ON' ? 'dot bg-online' : 'dot bg-offline';
                }
            });
        });
    }

    async function openChatModal(roomId, nickname, memberId) {
        currentRoomId = roomId;
        currentMemberId = memberId;
        
        document.getElementById('targetNickname').innerText = nickname || '회원';
        var container = document.getElementById('modal-chat-body');
        container.innerHTML = ''; 

        try {
            var res = await fetch('${pageContext.request.contextPath}/chat/history/' + roomId);
            if(res.ok) {
                var history = await res.json();
                history.forEach(msg => appendMessage(msg));
                setTimeout(() => { container.scrollTop = container.scrollHeight; }, 100);
            }
        } catch(e) { 
            console.error(e); 
        }

        if (currentSubscription) {
            currentSubscription.unsubscribe();
        }

        currentSubscription = stompClient.subscribe('/topic/room/' + roomId, function (res) {
            var msg = JSON.parse(res.body);
            appendMessage(msg);
            if (msg.isGuest === 'Y') sendReadStatus();
        });

        sendReadStatus();

        var roomCard = document.querySelector(`.room-card[data-member-id="\${memberId}"]`);
        if(roomCard) {
            var badge = roomCard.querySelector('.unread-badge');
            if(badge) badge.innerText = '';
        }

        showModalSafe(); 
        setTimeout(() => document.getElementById('adminInput').focus(), 500);
    }

    function sendAdminMessage() {
        var input = document.getElementById('adminInput');
        var text = input.value.trim();
        
        if (text && stompClient && currentRoomId) {
            var msg = {
                roomId: currentRoomId,
                memberId: currentMemberId, 
                isGuest: 'N',
                nickname: adminName,
                sender: adminId, 
                message: text
            };
            stompClient.send("/app/chat/send", {}, JSON.stringify(msg));
            input.value = '';
            input.focus();
        }
    }

    function sendReadStatus() {
        if (stompClient && currentRoomId) {
            stompClient.send("/app/chat/read", {}, JSON.stringify({roomId: currentRoomId, readerId: adminId}));
        }
    }

    function showModalSafe() {
        var modalEl = document.getElementById('chatModal');
        try {
            if (typeof bootstrap !== 'undefined') {
                var modal = bootstrap.Modal.getInstance(modalEl);
                if (!modal) modal = new bootstrap.Modal(modalEl);
                modal.show();
                return;
            }
        } catch (e) {}

        modalEl.classList.add('show');
        modalEl.style.display = 'block';
        modalEl.removeAttribute('aria-hidden');
        modalEl.setAttribute('aria-modal', 'true');
        
        if (!document.querySelector('.modal-backdrop')) {
            var backdrop = document.createElement('div');
            backdrop.className = 'modal-backdrop fade show';
            document.body.appendChild(backdrop);
        }
        document.body.classList.add('modal-open');
    }

    function closeChatModal() {
        if (currentSubscription) {
            currentSubscription.unsubscribe();
            currentSubscription = null;
        }
        currentRoomId = null;
        currentMemberId = null;
        
        var modalEl = document.getElementById('chatModal');
        try {
            if (typeof bootstrap !== 'undefined') {
                var modal = bootstrap.Modal.getInstance(modalEl);
                if (modal) modal.hide();
                return;
            }
        } catch (e) {}

        modalEl.classList.remove('show');
        modalEl.style.display = 'none';
        modalEl.setAttribute('aria-hidden', 'true');
        modalEl.removeAttribute('aria-modal');
        var backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) backdrop.remove();
        document.body.classList.remove('modal-open');
    }

    function appendMessage(msg) {
        var container = document.getElementById('modal-chat-body');
        var isMe = (msg.isGuest === 'N'); 

        var wrap = document.createElement('div');
        wrap.className = isMe ? 'msg-wrap my-msg d-flex justify-content-end w-100 mb-3' : 'msg-wrap other-msg d-flex justify-content-start w-100 mb-3';

        var row = document.createElement('div');
        row.className = isMe ? 'msg-row d-flex flex-row-reverse align-items-end gap-2' : 'msg-row d-flex align-items-end gap-2';
        row.style.maxWidth = '85%';

        var bubble = document.createElement('div');
        bubble.className = isMe ? 'p-2 px-3 rounded-3 text-white' : 'p-2 px-3 rounded-3 text-dark bg-light border';
        if (isMe) bubble.style.backgroundColor = 'var(--accent-main, #3B82F6)';
        bubble.innerText = msg.message;
        bubble.style.wordBreak = 'break-word';

        var timeDiv = document.createElement('div');
        timeDiv.className = 'small text-muted';
        timeDiv.style.fontSize = '0.75rem';
        timeDiv.style.whiteSpace = 'nowrap';
        timeDiv.innerText = formatTime(msg.createdAt);

        row.appendChild(bubble);
        row.appendChild(timeDiv);

        wrap.appendChild(row);
        container.appendChild(wrap);
        container.scrollTop = container.scrollHeight;
    }

    function formatTime(dateStr) {
        if (!dateStr) return "";
        var date;
        if (Array.isArray(dateStr)) {
            date = new Date(dateStr[0], dateStr[1]-1, dateStr[2], dateStr[3]||0, dateStr[4]||0, dateStr[5]||0);
        } else {
            date = new Date(dateStr);
        }
        if (isNaN(date)) return ""; 
        var hours = String(date.getHours()).padStart(2, '0');
        var mins = String(date.getMinutes()).padStart(2, '0');
        return hours + ":" + mins;
    }
</script>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>