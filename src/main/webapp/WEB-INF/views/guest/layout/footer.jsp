<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div id="footer" class="footer gray-background">
	<div class="container footer-top">
		<div class="row gy-4">
			<div class="col-lg-4 col-md-6 footer-about">
				<a href="${pageContext.request.contextPath}/" class="logo d-flex align-items-center">
					<span class="sitename">공대생</span>
				</a>
				<div class="footer-contact pt-3">
					<p>21, World Cup buk-ro</p>
					<p>Mapo-gu, Seoul, Republic of Korea</p>
					<p class="mt-3"><strong>Phone:</strong> <span>+82 1234 5648</span></p>
					<p><strong>Email:</strong> <span>info@example.com</span></p>
				</div>
				<div class="social-links d-flex mt-4">
					<a href="#"><i class="bi bi-twitter-x"></i></a>
					<a href="#"><i class="bi bi-facebook"></i></a>
					<a href="#"><i class="bi bi-instagram"></i></a>
					<a href="#"><i class="bi bi-linkedin"></i></a>
				</div>				
			</div>
			
			<div class="col-lg-2 col-md-3 footer-links">
				<h4>Useful Links</h4>
				<ul>
					<li><a href="#">Home</a></li>
					<li><a href="#">About</a></li>
					<li><a href="#">Blog</a></li>
					<li><a href="#">Weather</a></li>
					<li><a href="#">Map</a></li>
				</ul>			
			</div>

			<div class="col-lg-2 col-md-3 footer-links">
				<h4>Help &amp; Information</h4>
				<ul>
					<li><a href="#">Help</a></li>
					<li><a href="#">Customer Service</a></li>					
					<li><a href="#">이용약관</a></li>
					<li><a href="#">개인정보처리방침</a></li>
					<li><a href="#">청소년보호정책</a></li>
				</ul>
			</div>
			
			<div class="col-lg-4 col-md-12 footer-guide">
				<p>다양한 공간을 쉽고 빠르게 예약할 수 있는 공간 대여 플랫폼입니다.
          		스튜디오, 회의실, 파티룸 등 원하는 공간을 검색하고 예약해보세요.</p>
			</div>
		</div>
	</div>
	
	<div class="container copyright text-center mt-4">
		<p><a href="${pageContext.request.contextPath}/admin/login"> © </a><span>Copyright</span> <strong class="px-1 sitename">GongDaeSaeng</strong> <span>All Rights Reserved</span></p>
	</div>
</div>

<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<div id="preloader"></div>
<div id="loadingLayout"></div>