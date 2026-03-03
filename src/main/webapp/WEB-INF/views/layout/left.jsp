<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
  	<div class="offcanvas-body p-0 d-flex flex-column h-100">

	    <!-- 🔶 상단 프로필 영역 -->
	    <div class="menu-header p-4">
			<div class="d-flex align-items-center">
	      		<!-- 비로그인시 표시할 섹션 -->
	  			<sec:authorize access="isAnonymous()">
	  				<div class="profile-img me-3">
	          			<img src="${pageContext.request.contextPath}/dist/images/avatar.png">
	       			</div>
	  				<div>
	        			<a href="${pageContext.request.contextPath}/member/login" title="로그인" class="fw-bold fs-5">로그인/회원가입</a>
	        		</div>
				</sec:authorize>
				<!-- 로그인 상태일때 표시할 섹션 -->
			  	<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.member" var="member"/>
					<div class="profile-img me-3">
						<c:choose>
							<c:when test="${not empty member.avatar}">
								<img src="${pageContext.request.contextPath}/uploads/member/${member.avatar}" 
									onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/dist/images/avatar.png';">
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/dist/images/avatar.png">
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<div class="fw-bold fs-5">${member.name}</div>
						<a href="${pageContext.request.contextPath}/member/edit" class="small">정보수정</a>/
						<a href="${pageContext.request.contextPath}/member/logout" class="small" title="로그아웃">로그아웃</a>
						
					</div>
				</sec:authorize>
				
	      	</div>
		</div>

    <!-- 🔘 아이콘 메뉴 -->
    <div class="icon-menu py-3">
      <div class="row text-center g-0">
        <div class="col-3">
          <div><i class="bi bi-megaphone fs-4"></i></div>
          <div class="small">이벤트</div>
        </div>
        <div class="col-3">
          <div><i class="bi bi-card-checklist fs-4"></i></div>
          <div class="small">예약<br>리스트</div>
        </div>
        <div class="col-3">
          <div><i class="bi bi-chat-dots fs-4"></i></div>
          <div class="small">이용후기<br>Q&A관리</div>
        </div>
        <div class="col-3">
          <div><i class="bi bi-heart fs-4"></i></div>
          <div class="small">찜한 공간</div>
        </div>
      </div>
    </div>

    <!-- 🟣 섹션 타이틀 -->
    <div class="section-title px-3 py-2">
      내 관심정보 설정
    </div>

    <!-- 📋 메뉴 리스트 (스크롤 영역) -->
    <div class="flex-grow-1 overflow-auto">
      <ul class="menu-list list-unstyled m-0">
        <li>관리자 문의(미구현)</li>
        <li>공지사항</li>
        <li>도시산책</li>
        <li>도움말</li>
        <li>1:1문의</li>
        <li>서비스 정보</li>
      </ul>

    </div>

    <!-- 🔵 하단 고정 버튼 -->
    <div class="bottom-fixed text-center">
      <a href="${pageContext.request.contextPath}/host/main/prelogin">호스트 전환</a>
    </div>

  </div>

  	
</div>
