<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="offcanvasExampleLabel">Offcanvas</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
  	<!-- 로그인 상태일때 표시할 섹션 -->
  	<sec:authorize access="isAuthenticated()">
		<div class="header-avatar">
			<sec:authentication property="principal.member.avatar" var="avatar"/>
			<c:choose>
				<c:when test="${not empty avatar}">
					<img src="${pageContext.request.contextPath}/uploads/member/${avatar}" 
						onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/dist/images/avatar.png';"
						class="avatar-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="avatar-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				</c:otherwise>
			</c:choose>
			<ul class="dropdown-menu">
				<li><a href="${pageContext.request.contextPath}/" class="dropdown-item">사진첩</a></li>
				<li><a href="${pageContext.request.contextPath}/" class="dropdown-item">일정관리</a></li>
				<li><a href="${pageContext.request.contextPath}/" class="dropdown-item">쪽지함</a></li>
				<li><a href="${pageContext.request.contextPath}/" class="dropdown-item">메일</a></li>
				<li><hr class="dropdown-divider"></li>
				<li><a href="${pageContext.request.contextPath}/" class="dropdown-item">정보수정</a></li>
			</ul>
		</div>
	</sec:authorize>
  	
  	<!-- 비로그인시 표시할 섹션 -->
  	<sec:authorize access="isAnonymous()">
		<a href="${pageContext.request.contextPath}/member/login" title="로그인" title="로그인">로그인</a>
	</sec:authorize>
	
	
	<sec:authorize access="isAuthenticated()">
		<a href="${pageContext.request.contextPath}/member/logout" title="로그아웃"><i class="bi bi-unlock"></i></a>
		<sec:authorize access="hasAnyRole('ADMIN','EMP')">
			<a href="${pageContext.request.contextPath}/admin" title="관리자"><i class="bi bi-gear"></i></a>
		</sec:authorize>
	</sec:authorize>

		<ul>
			<li><span>회원 등급 표시</span></li>
			<li><a href="${pageContext.request.contextPath}/admin/login">관리자 로그인</a></li>
			<li><a href="${pageContext.request.contextPath}/member/edit">회원 정보 수정</a></li>
			<li><a href="${pageContext.request.contextPath}">관리자 문의(미구현)</a></li>
			<li><a href="${pageContext.request.contextPath}">예약 리스트</a></li>
			<li><a href="${pageContext.request.contextPath}">이용 후기 작성</a></li>
			<li><a href="${pageContext.request.contextPath}">공지사항</a></li>
			<li><a href="${pageContext.request.contextPath}">찜 리스트</a></li>
			<li><a href="${pageContext.request.contextPath}/host/prelogin">호스트 전환</a></li>
		</ul>
		
   
   
  </div>
</div>
