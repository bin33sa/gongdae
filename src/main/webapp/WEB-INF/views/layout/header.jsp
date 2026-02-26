<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<div id="header" class="header d-flex align-items-center sticky-top">
	<div class="container position-relative d-flex align-items-center justify-content-between">
		<a class="btn btn-primary" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample">
		  	<i class="bi bi-list"></i>
		</a>
	
		<a href="<c:url value='/' />" class="logo d-flex align-items-center me-auto me-xl-0">
			<span class="sitename">SPRING</span><span class="dot">.</span>
		</a>
		
		
		<i class="mobile-nav-toggle d-xl-none bi bi-list" style="display:none"></i>
		
		<div> <input placeholder="검색어 입력"> </div>
		
		
		<div class="d-flex align-items-center header-right">
			
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
			
			<div class="col">
				<div class="d-flex justify-content-end header-top-links">
					<sec:authorize access="isAnonymous()">
						<a href="${pageContext.request.contextPath}/member/login" title="로그인" title="로그인">로그인</a>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<a href="${pageContext.request.contextPath}/member/logout" title="로그아웃"><i class="bi bi-unlock"></i></a>
						<sec:authorize access="hasAnyRole('ADMIN','EMP')">
							<a href="${pageContext.request.contextPath}/admin" title="관리자"><i class="bi bi-gear"></i></a>
						</sec:authorize>
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

</script>
