<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
    /* 플로팅 버튼 */
    .chat-float-btn {
        position: fixed; bottom: 30px; right: 30px;
        width: 60px; height: 60px;
        background-color: var(--host-primary, #E53935);
        color: white; border-radius: 50%;
        display: flex; justify-content: center; align-items: center;
        font-size: 24px; cursor: pointer; box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        z-index: 1050; transition: transform 0.2s;
    }
    .chat-float-btn:hover { transform: scale(1.1); }

    /* 채팅창 (기본 숨김) */
    .chat-float-window {
        position: fixed; bottom: 100px; right: 30px;
        width: 350px; height: 500px;
        background: white; border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        display: none; flex-direction: column; overflow: hidden;
        z-index: 1050; border: 1px solid #ddd;
    }
    .chat-header {
        background-color: var(--host-primary, #E53935);
        color: white; padding: 15px; font-weight: bold;
        display: flex; justify-content: space-between; align-items: center;
    }
    .chat-body { flex: 1; padding: 15px; overflow-y: auto; background-color: #f8f9fa; }
    .chat-footer { padding: 10px; border-top: 1px solid #eee; background: white; display: flex; gap: 5px; }
    
    /* 말풍선 스타일 */
    .host-msg { background-color: var(--host-primary, #E53935); color: white; padding: 8px 12px; border-radius: 12px 0 12px 12px; max-width: 80%; word-break: break-word; }
    .admin-msg { background-color: #e9ecef; color: #333; padding: 8px 12px; border-radius: 0 12px 12px 12px; max-width: 80%; word-break: break-word; }
</style>

<div class="chat-float-btn" id="chatOpenBtn"><i class="bi bi-chat-dots-fill"></i></div>

<div class="chat-float-window" id="chatWindow">
    <div class="chat-header">
        <span><i class="bi bi-headset"></i> 관리자 1:1 문의</span>
        <button type="button" class="btn-close btn-close-white" id="chatCloseBtn"></button>
    </div>
    <div class="chat-body" id="hostChatBody">
        <div class="text-center text-muted small my-3">상담을 환영합니다. 무엇을 도와드릴까요?</div>
    </div>
    <div class="chat-footer">
        <input type="text" id="hostChatInput" class="form-control form-control-sm" placeholder="메시지를 입력하세요" autocomplete="off">
        <button class="btn btn-sm btn-dark" id="hostChatSendBtn">전송</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

<script>
    var hostStompClient = null;
    var hostRoomId = null; 
    var hostMemberId = '<sec:authentication property="principal.member.member_id" htmlEscape="false" />'; 
    var hostName = '<sec:authentication property="principal.member.name" htmlEscape="false"/>';

    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('chatOpenBtn').addEventListener('click', () => {
            document.getElementById('chatWindow').style.display = 'flex';
            if(!hostStompClient) connectHostChat(); 
        });
        document.getElementById('chatCloseBtn').addEventListener('click', () => {
            document.getElementById('chatWindow').style.display = 'none';
        });

        document.getElementById('hostChatSendBtn').addEventListener('click', sendHostMessage);
        document.getElementById('hostChatInput').addEventListener('keydown', (e) => {
            if(e.key === 'Enter') sendHostMessage();
        });
    });

    async function connectHostChat() {
        try {
            // 이전에 만들어둔 ChatRoomController를 호출하여 내 방 번호를 가져옴
            var res = await fetch('${pageContext.request.contextPath}/chat/myRoom');
            var data = await res.json();
            hostRoomId = data.roomId; 
            
            var historyRes = await fetch('${pageContext.request.contextPath}/chat/history/' + hostRoomId);
            if(historyRes.ok) {
                var history = await historyRes.json();
                history.forEach(msg => drawHostMessage(msg));
            }
        } catch(e) {
            console.error("채팅방 정보를 가져오는 데 실패했습니다.", e);
        }

        var socket = new SockJS('${pageContext.request.contextPath}/ws-chat');
        hostStompClient = Stomp.over(socket);
        hostStompClient.debug = null;

        hostStompClient.connect({}, function (frame) {
            if(hostRoomId) {
                hostStompClient.subscribe('/topic/room/' + hostRoomId, function (res) {
                    var msg = JSON.parse(res.body);
                    drawHostMessage(msg);
                });
            }
        });
    }

    function sendHostMessage() {
        var input = document.getElementById('hostChatInput');
        var text = input.value.trim();
        
        if (text && hostStompClient && hostRoomId) {
            var msg = {
                roomId: hostRoomId,
                memberId: hostMemberId,
                isGuest: 'Y', 
                nickname: hostName,
                sender: hostMemberId,
                message: text
            };
            hostStompClient.send("/app/chat/send", {}, JSON.stringify(msg));
            input.value = '';
            input.focus();
        }
    }

    function drawHostMessage(msg) {
        var container = document.getElementById('hostChatBody');
        var isMe = (msg.isGuest === 'Y'); 

        var wrap = document.createElement('div');
        wrap.className = 'd-flex w-100 mb-2 ' + (isMe ? 'justify-content-end' : 'justify-content-start');

        var bubble = document.createElement('div');
        bubble.className = isMe ? 'host-msg shadow-sm' : 'admin-msg shadow-sm';
        bubble.innerText = msg.message;

        wrap.appendChild(bubble);
        container.appendChild(wrap);
        container.scrollTop = container.scrollHeight; 
    }
</script>