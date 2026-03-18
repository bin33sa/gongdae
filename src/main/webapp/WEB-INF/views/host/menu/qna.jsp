<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 답변 - 공대생 호스트 센터</title>
    
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    
    <style>
        :root {
            --host-primary: #E53935;
            --host-bg: #f4f6f9;
        }
        
        body { 
            background-color: var(--host-bg); 
            font-family: 'Pretendard', sans-serif; 
        }

        /* 메인 컨테이너 (플랫 엣지 박스) */
        .qna-container {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-top: 4px solid var(--host-primary);
            border-radius: 6px;
            height: 75vh; /* 화면 높이에 맞춤 */
            min-height: 600px;
            display: flex;
            overflow: hidden;
        }

        /* ========================================== */
        /* 좌측: 문의 리스트 영역 */
        /* ========================================== */
        .qna-sidebar {
            width: 35%;
            border-right: 1px solid #eee;
            display: flex;
            flex-direction: column;
            background-color: #fff;
        }
        .qna-sidebar-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            background-color: #fafafa;
        }
        .qna-list {
            flex-grow: 1;
            overflow-y: auto;
        }
        .qna-item {
            padding: 16px 20px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .qna-item:hover { background-color: #f9f9f9; }
        .qna-item.active {
            background-color: #fffafa;
            border-left: 4px solid var(--host-primary);
        }
        
        /* 뱃지 커스텀 */
        .badge-wait { background-color: #ffebee; color: #d32f2f; border: 1px solid #ffcdd2; font-weight: normal;}
        .badge-done { background-color: #e8f5e9; color: #388e3c; border: 1px solid #c8e6c9; font-weight: normal;}

        /* ========================================== */
        /* 우측: 채팅(상세) 영역 */
        /* ========================================== */
        .qna-chat-area {
            width: 65%;
            display: flex;
            flex-direction: column;
            background-color: #fff;
        }
        .chat-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .chat-body {
            flex-grow: 1;
            padding: 30px;
            overflow-y: auto;
            background-color: #fcfcfc; /* 살짝 어두운 배경으로 말풍선 돋보이게 */
        }

        /* 말풍선 공통 스타일 */
        .bubble-wrapper {
            margin-bottom: 25px;
            clear: both;
            display: flex;
            flex-direction: column;
        }
        .bubble {
            max-width: 70%;
            padding: 12px 18px;
            border-radius: 12px;
            font-size: 0.95rem;
            line-height: 1.5;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
        .bubble-time {
            font-size: 0.75rem;
            color: #999;
            margin-top: 6px;
        }

        /* 게스트(질문자) 말풍선 - 왼쪽 회색 */
        .guest-wrapper { align-items: flex-start; }
        .bubble-guest {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-top-left-radius: 2px;
            color: #333;
        }
        
        /* 호스트(답변자) 말풍선 - 오른쪽 적색 */
        .host-wrapper { align-items: flex-end; }
        .bubble-host {
            background-color: var(--host-primary);
            color: #ffffff;
            border-top-right-radius: 2px;
        }

        /* 입력창 영역 */
        .chat-input-wrapper {
            padding: 20px;
            background-color: #ffffff;
            border-top: 1px solid #eee;
        }
        .chat-textarea {
            resize: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 12px;
            font-size: 0.95rem;
            height: 100px;
        }
        .chat-textarea:focus {
            outline: none;
            border-color: var(--host-primary);
        }
        .btn-send {
            background-color: var(--host-primary);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            height: 100px;
            width: 100%;
            transition: background-color 0.2s;
        }
        .btn-send:hover { background-color: #c62828; color: white; }

        /* 스크롤바 디자인 */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #ddd; border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: #bbb; }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">
    
    <div class="mb-4">
        <h3 class="fw-bold" style="color: #333;">1:1 문의 답변</h3>
        <p class="text-muted">게스트가 남긴 공간 문의에 신속하게 답변해 보세요.</p>
    </div>

    <div class="qna-container">
        
        <div class="qna-sidebar">
            <div class="qna-sidebar-header">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold m-0">문의 내역</h5>
                    <select class="form-select form-select-sm w-auto">
                        <option value="all">전체 보기</option>
                        <option value="wait" selected>답변 대기만</option>
                    </select>
                </div>
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control border-start-0 ps-0" placeholder="게스트명 또는 공간명 검색">
                </div>
            </div>

            <div class="qna-list">
                <div class="qna-item active">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge badge-wait rounded-pill">답변 대기</span>
                        <span class="small text-muted">2시간 전</span>
                    </div>
                    <div class="fw-bold fs-6 text-truncate">빔 프로젝터 HDMI 선 있나요?</div>
                    <div class="small text-muted mt-1 d-flex justify-content-between">
                        <span><i class="bi bi-person me-1"></i>김공대 (홍대 루프탑 파티룸)</span>
                    </div>
                </div>

                <div class="qna-item">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge badge-done rounded-pill">답변 완료</span>
                        <span class="small text-muted">어제 14:30</span>
                    </div>
                    <div class="fw-bold fs-6 text-truncate text-muted">주차장 이용 관련 문의드립니다.</div>
                    <div class="small text-muted mt-1 d-flex justify-content-between">
                        <span><i class="bi bi-person me-1"></i>이학생 (강남 스터디룸 A호)</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="qna-chat-area">
            
            <div class="chat-header">
                <div>
                    <h5 class="fw-bold m-0">빔 프로젝터 HDMI 선 있나요?</h5>
                    <div class="small text-muted mt-1">문의 공간 : 홍대 루프탑 파티룸</div>
                </div>
                <div class="text-end">
                    <span class="fw-bold" style="color: var(--host-primary);">김공대</span> 게스트
                    <div class="small text-muted">2026.03.12 15:30</div>
                </div>
            </div>

            <div class="chat-body" id="chatBody">
                
                <div class="text-center mb-4">
                    <span class="badge bg-light text-muted border px-3 py-2 rounded-pill">2026년 3월 12일</span>
                </div>

                <div class="bubble-wrapper guest-wrapper">
                    <div class="fw-bold small mb-1 ms-1 text-muted">김공대 게스트</div>
                    <div class="bubble bubble-guest">
                        안녕하세요! 이번 주 토요일에 예약한 사람입니다.<br>
                        노트북을 가져가려고 하는데, 빔 프로젝터에 연결할 수 있는 HDMI 선이 공간에 기본으로 구비되어 있는지 궁금합니다! 
                        혹시 C타입 젠더도 있을까요?
                    </div>
                    <div class="bubble-time">오후 3:30</div>
                </div>

                </div>

            <form action="<c:url value='/space/inquiry/reply'/>" method="post" class="chat-input-wrapper m-0">
                <input type="hidden" name="inquiryNo" value="1">
                
                <div class="row g-2">
                    <div class="col-10">
                        <textarea name="answer" class="form-control chat-textarea" placeholder="게스트에게 친절하게 답변을 남겨주세요." required></textarea>
                    </div>
                    <div class="col-2">
                        <button type="submit" class="btn-send">
                            <i class="bi bi-send-fill fs-4 d-block mb-1"></i>
                            답변 전송
                        </button>
                    </div>
                </div>
                <sec:csrfInput/>
            </form>

        </div>

    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

<script>
    // 페이지 로드 시 채팅창 스크롤을 항상 맨 아래로 이동
    window.onload = function() {
        const chatBody = document.getElementById('chatBody');
        chatBody.scrollTop = chatBody.scrollHeight;
    }
</script>

</body>
</html>