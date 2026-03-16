<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample">

    <div class="offcanvas-body p-0 d-flex flex-column h-100">

        <!-- ===================== -->
        <!-- PROFILE HEADER -->
        <!-- ===================== -->
        <div class="menu-header p-4">
            <div class="d-flex align-items-center">

                <!-- 비로그인 -->
                <sec:authorize access="isAnonymous()">
                    <div class="profile-img me-3">
                        <img src="${pageContext.request.contextPath}/dist/images/avatar.png">
                    </div>

                    <div>
                        <a href="${pageContext.request.contextPath}/member/login"
                           class="fw-bold fs-5 text-white">
                            유저로<br>로그인/회원가입
                        </a>
                    </div>
                </sec:authorize>


                <!-- 로그인 -->
                <sec:authorize access="isAuthenticated()">
                    <sec:authentication property="principal.member" var="member"/>

                    <div class="profile-img me-3">

                        <c:choose>
                            <c:when test="${not empty member.avatar}">
                                <img src="${pageContext.request.contextPath}/uploads/member/${member.avatar}"
                                     onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/avatar.png">
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <div>
                        <div class="fw-bold fs-5 mb-1 text-white">
                            ${member.nickname != null ? member.nickname : member.name} 님
                        </div>

                        <a href="${pageContext.request.contextPath}/member/edit"
                           class="small text-secondary text-white">
                           정보수정
                        </a>

                        <span class="text-secondary">|</span>

                        <a href="${pageContext.request.contextPath}/member/logout"
                           class="small text-secondary text-white">
                           로그아웃
                        </a>
                    </div>

                </sec:authorize>

            </div>
        </div>


        <!-- ===================== -->
        <!-- ICON MENU -->
        <!-- ===================== -->
        <div class="icon-menu py-4">

            <div class="row text-center g-0">

                <div class="col-3"
                		onclick="location.href='${pageContext.request.contextPath}/my/grade'">
                    <div class="mb-1">
                        <i class="bi bi-award fs-4"></i>
                    </div>
                    <div class="small text-muted">
                        내 등급<br>
                        <span class="text-dark fw-bold">브론즈</span>
                    </div>
                </div>

                <div class="col-3"
                		onclick="location.href='${pageContext.request.contextPath}/my/mileage'">
                    <div class="mb-1">
                        <i class="bi bi-cash-coin fs-4"></i>
                    </div>
                    <div class="small text-muted">
                        마일리지<br>
                        <span class="text-dark fw-bold">3,500</span>
                    </div>
                </div>

                <div class="col-3"
                		onclick="location.href='${pageContext.request.contextPath}/my/coupon'">
                    <div class="mb-1">
                        <i class="bi bi-ticket-perforated fs-4"></i>
                    </div>
                    <div class="small text-muted">
                        쿠폰<br>
                        <span class="text-dark fw-bold">0 장</span>
                    </div>
                </div>

                <div class="col-3"
                     onclick="location.href='${pageContext.request.contextPath}/my/wishlist'">

                    <div class="mb-1">
                        <i class="bi bi-heart fs-4"></i>
                    </div>

                    <div class="small text-muted">
                        찜한 공간<br>
                        <span class="text-dark fw-bold">0</span>
                    </div>

                </div>

            </div>
        </div>


        <!-- ===================== -->
        <!-- MENU LIST -->
        <!-- ===================== -->
        <div class="flex-grow-1 overflow-auto">

            <ul class="menu-list list-unstyled m-0">

                <li onclick="location.href='${pageContext.request.contextPath}/'">
                    공대생 홈
                </li>

                <li onclick="location.href='${pageContext.request.contextPath}/notice'">
                    공지사항
                </li>

                <li onclick="location.href='${pageContext.request.contextPath}/event'">
                    이벤트
                </li>

                <li onclick="location.href='${pageContext.request.contextPath}/faq'">
                    자주 묻는 질문
                </li>

                <li onclick="location.href='${pageContext.request.contextPath}/reservation/list'">
                    예약리스트
                </li>

            </ul>

        </div>


        <!-- ===================== -->
        <!-- BOTTOM BUTTON -->
        <!-- ===================== -->
        <div class="bottom-fixed bottom-fixed-host text-center mt-auto">

            <a href="${pageContext.request.contextPath}/host/main/prelogin">
                호스트 센터로 이동
                <i class="bi bi-arrow-right-circle ms-1"></i>
            </a>

        </div>


    </div>

</div>