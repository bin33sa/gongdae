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
			<span class="sitename">공대생</span><span class="dot">.</span>
		</a>
		
		
		<i class="mobile-nav-toggle d-xl-none bi bi-list" style="display:none"></i>
		
		
	</div>
</div>

<jsp:include page="/WEB-INF/views/layout/left.jsp"/>

<script type="text/javascript">

</script>
