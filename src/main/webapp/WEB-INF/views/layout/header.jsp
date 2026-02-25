<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="container-fluid py-2 px-5 wow fadeIn header-top" data-wow-delay="0.1s">
	<div class="container">
		<div class="row align-items-center">
			<div class="col d-none d-md-flex contact-info">
				<i class="bi bi-telephone-inbound-fill"></i>&nbsp;<span>+82-1234-5678</span>
			</div>
			
			<div class="col">
				<div class="d-flex justify-content-end header-top-links">
					<sec:authorize access="isAnonymous()">
						<a href="javascript:dialogLogin();" title="로그인" title="로그인"><i class="bi bi-lock"></i></a>
						<a href="${pageContext.request.contextPath}/" title="회원가입"><i class="bi bi-person-plus"></i></a>
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

<div id="header" class="header d-flex align-items-center sticky-top">
	<div class="container position-relative d-flex align-items-center justify-content-between">
		<a href="<c:url value='/' />" class="logo d-flex align-items-center me-auto me-xl-0">
			<span class="sitename">SPRING</span><span class="dot">.</span>
		</a>
		
		<nav id="navmenu" class="navmenu">
			<ul>
				<li><a href="${pageContext.request.contextPath}/">홈</a></li>
				<li><a href="#">소개</a></li>
				<li class="dropdown">
					<a href="#"><span>강좌</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/">프로그래밍</a></li>
						<li><a href="${pageContext.request.contextPath}/">데이터베이스</a></li>
						<li><a href="${pageContext.request.contextPath}/">웹 프로그래밍</a></li>
						<li><a href="${pageContext.request.contextPath}/">데이터분석 및 AI</a></li>
						<li><a href="${pageContext.request.contextPath}/">클라우드 및 기타</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a href="${pageContext.request.contextPath}/">질문과 답변</a></li>
					</ul>
				</li>
				<li><a href="#">블로그</a></li>
				<li class="dropdown">
					<a href="#"><span>서비스</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/">맛집정보</a></li>
						<li><a href="${pageContext.request.contextPath}/">레시피</a></li>
						<li><a href="${pageContext.request.contextPath}/">관광정보</a></li>
						<li><a href="${pageContext.request.contextPath}/">날씨</a></li>
						<li><a href="${pageContext.request.contextPath}/">지역별날씨</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#"><span>커뮤니티</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/">방명록</a></li>
						<li><a href="${pageContext.request.contextPath}/">자유 게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/">답변형 게시판</a></li>
						<li><a href="${pageContext.request.contextPath}/">포토 갤러리</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a href="${pageContext.request.contextPath}/">채팅</a></li>
					</ul>	
				</li>
				<li class="dropdown">
					<a href="#"><span>고객센터</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
					<ul>
						<li><a href="${pageContext.request.contextPath}/">자주하는질문</a></li>
						<li><a href="${pageContext.request.contextPath}/">공지사항</a></li>
						<li><a href="${pageContext.request.contextPath}/">1:1문의</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a href="${pageContext.request.contextPath}/">이벤트</a></li>
					</ul>	
				</li>
			</ul>
			<i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
		</nav>
		
		<div class="d-flex align-items-center header-right">
			<div class="header-account-links">
				<a href="#" title="알림"><i class="bi bi-bell"></i></a>
			</div>
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
		</div>
	</div>
</div>

<div class="modal fade" id="loginModal" tabindex="-1"
		data-bs-backdrop="static" data-bs-keyboard="false" 
		aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginViewerModalLabel">Login</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="p-3">
					<form name="modalLoginForm" action="" method="post" class="row g-3">
						<div class="mt-0">
							<p class="form-control-plaintext">계정으로 로그인 하세요</p>
						</div>
						<div class="mt-0">
							<input type="text" name="login_id" class="form-control" placeholder="아이디">
						</div>
						<div>
							<input type="password" name="password" class="form-control" autocomplete="off" 
								placeholder="패스워드">
						</div>
						<div>
							<div class="form-check">
								<input class="form-check-input rememberMe" type="checkbox" id="rememberMeModal">
								<label class="form-check-label" for="rememberMeModal"> 아이디 저장</label>
							</div>
						</div>
						<div>
							<button type="button" class="btn btn-primary w-100" onclick="sendModalLogin();">Login</button>
						</div>
						<div class="d-flex justify-content-between">
								<button type="button" class="btn-light flex-fill me-2" title="Kakao"><i class="bi bi-chat-fill kakao-icon"></i></button>
								<button type="button" class="btn-light flex-fill me-2" title="NAVER"><span class="naver-icon">N</span></button>
								<button type="button" class="btn-light flex-fill" title="Google"><i class="bi bi-google google-icon"></i></button>
						</div>
						<div>
							<p class="form-control-plaintext text-center">
								<a href="${pageContext.request.contextPath}/" class="text-primary text-decoration-none me-2">패스워드를 잊으셨나요 ?</a>
							</p>
						</div>
					</form>
					<hr class="mt-3">
					<div>
						<p class="form-control-plaintext mb-0">
							아직 회원이 아니세요 ?
							<a href="${pageContext.request.contextPath}/" class="text-primary text-decoration-none">회원가입</a>
						</p>
					</div>
				</div>
        
			</div>
		</div>
	</div>
</div>		

<!-- Login Modal -->
<script type="text/javascript">
	function dialogLogin() {
		document.querySelector('form[name="modalLoginForm"] input[name="password"]').value = '';
		    
		const loginModalEl = document.getElementById('loginModal');
		const loginModal = bootstrap.Modal.getOrCreateInstance(loginModalEl);
		loginModal.show();			
			
		document.querySelector('form[name="modalLoginForm"] input[name="login_id"]').focus();
	}

	function sendModalLogin() {
		const f = document.modalLoginForm;
	    
		if(! f.login_id.value.trim()) {
			f.login_id.focus();
			return;
		}
	
		if(! f.password.value.trim()) {
			f.password.focus();
			return;
		}
	
		f.action = '${pageContext.request.contextPath}/member/login';
		f.submit();
	}
</script>
