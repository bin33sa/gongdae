<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%-- 현재 로그인한 사용자가 호스트(ROLE_HOST)인지 확인하여 isHost 변수에 저장 --%>
<sec:authorize access="hasRole('ROLE_HOST')" var="isHost" />

<%-- 권한에 따른 테마 색상 및 텍스트 동적 설정 --%>
<c:choose>
    <c:when test="${isHost}">
       
        <c:set var="headerBg" value="#E53935" /> 
        <c:set var="bottomBg" value="#1C6296" /> 
        <c:set var="bottomHover" value="#154c75" />
        <c:set var="bottomText" value="공대생 홈(게스트)으로 이동" />
        <c:set var="bottomLink" value="${pageContext.request.contextPath}/" />
    </c:when>
    <c:otherwise>
        <%-- 게스트/비로그인 모드: 상단 파란색, 하단 빨간색(호스트로 이동) --%>
        <c:set var="headerBg" value="#1C6296" /> 
        <c:set var="bottomBg" value="#E53935" /> 
        <c:set var="bottomHover" value="#c62828" />
        <c:set var="bottomText" value="호스트 센터로 이동" />
        <c:set var="bottomLink" value="${pageContext.request.contextPath}/host/main/prelogin" />
    </c:otherwise>
</c:choose>

<style>
    /* 오프캔버스 기본 너비 설정 */
    .offcanvas-start { width: 320px; border-right: none; }

    /* 1. 상단 프로필 영역 (동적 배경색 적용) */
    .menu-header {
        background-color: ${headerBg};
        color: #fff;
        transition: background-color 0.3s ease;
    }
    .profile-img img {
        width: 60px; 
        height: 60px;
        border-radius: 50%;
        background-color: #fff;
        object-fit: cover;
        border: 2px solid #fff;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    /* 어두운 배경에 맞춰 텍스트 색상 흰색 톤으로 조정 */
    .menu-header a, .menu-header .text-secondary { color: rgba(255,255,255,0.8) !important; text-decoration: none; }
    .menu-header a:hover { color: #fff !important; text-decoration: underline; }

    /* 2. 아이콘 메뉴 영역 */
    .icon-menu { border-bottom: 8px solid #f4f4f4; }
    .icon-menu .col-3 { cursor: pointer; transition: transform 0.2s; }
    .icon-menu .col-3:hover { transform: translateY(-2px); }
    .icon-menu i { color: #555; }

    /* 3. 리스트 메뉴 영역 */
    .menu-list li {
        padding: 16px 24px;
        border-bottom: 1px solid #f0f0f0;
        font-size: 15px;
        color: #333;
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: background-color 0.2s;
    }
    .menu-list li:hover { background-color: #f9f9f9; }
    
    /* 메뉴 우측 화살표 아이콘 자동 추가 */
    .menu-list li::after {
        content: '\F285'; /* Bootstrap Icon: bi-chevron-right */
        font-family: bootstrap-icons;
        color: #ccc;
        font-size: 14px;
    }

    /* 4. 하단 고정 버튼 (동적 배경색 적용) */
    .bottom-fixed {
        background-color: ${bottomBg};
        transition: background-color 0.3s ease;
    }
    .bottom-fixed a {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        padding: 18px;
        color: #fff;
        font-weight: bold;
        font-size: 16px;
        text-decoration: none;
        transition: background-color 0.2s;
    }
    .bottom-fixed a:hover {
        background-color: ${bottomHover}; 
    }
</style>

<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-body p-0 d-flex flex-column h-100">

        <div class="menu-header p-4">
            <div class="d-flex align-items-center">
                <sec:authorize access="isAnonymous()">
                    <div class="profile-img me-3">
                        <img src="${pageContext.request.contextPath}/dist/images/avatar.png" alt="기본 프로필">
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/member/login" title="로그인" class="fw-bold fs-5 text-white">유저로<br>로그인/회원가입</a>
                    </div>
                </sec:authorize>
                
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.member" var="member"/>
                    <div class="profile-img me-3">
                        <c:choose>
                            <c:when test="${not empty member.avatar}">
                                <img src="${pageContext.request.contextPath}/uploads/member/${member.avatar}" 
                                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/dist/images/avatar.png';">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/avatar.png" alt="기본 프로필">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <div class="fw-bold fs-5 mb-1 text-white">${member.name} 님</div>
                        <a href="${pageContext.request.contextPath}/member/edit" class="small text-secondary">정보수정</a> <span class="text-secondary">|</span>
                        <a href="${pageContext.request.contextPath}/member/logout" class="small text-secondary" title="로그아웃">로그아웃</a>
                    </div>
                </sec:authorize>
            </div>
        </div>

        <div class="icon-menu py-4">
            <div class="row text-center g-0">
                <div class="col-3">
                    <div class="mb-1"><i class="bi bi-award fs-4"></i></div>
                    <div class="small text-muted">내 등급<br><span class="text-dark fw-bold">브론즈</span></div>
                </div>
                <div class="col-3">
                    <div class="mb-1"><i class="bi bi-cash-coin fs-4"></i></div>
                    <div class="small text-muted">마일리지<br><span class="text-dark fw-bold">3,500</span></div>
                </div>
                <div class="col-3">
                    <div class="mb-1"><i class="bi bi-ticket-perforated fs-4"></i></div>
                    <div class="small text-muted">쿠폰<br><span class="text-dark fw-bold">0 장</span></div>
                </div>
                <div class="col-3">
                    <div class="mb-1"><i class="bi bi-heart fs-4"></i></div>
                    <div class="small text-muted">찜한 공간<br><span class="text-dark fw-bold">0</span></div>
                </div>
            </div>
        </div>

        <div class="flex-grow-1 overflow-auto">
            <ul class="menu-list list-unstyled m-0">
                <li onclick="location.href='${pageContext.request.contextPath}/'">공대생 홈</li>
                <li>관리자 문의(미구현)</li>
                <li onclick="location.href='${pageContext.request.contextPath}/notice'">공지사항</li>
                <li onclick="location.href='${pageContext.request.contextPath}/event'">이벤트</li>
                <li onclick="location.href='${pageContext.request.contextPath}/faq'">자주 묻는 질문</li>
                <li>예약리스트</li>
                <li>후기 작성</li>
            </ul>
        </div>

        <div class="bottom-fixed text-center mt-auto">
            <a href="${bottomLink}">
                ${bottomText} <i class="bi bi-arrow-right-circle ms-1"></i>
            </a>
        </div>

    </div>
</div>