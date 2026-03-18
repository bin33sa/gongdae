<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>

/* =====================================================
FOOTER
===================================================== */

.footer-gray{
  background:#0f172a;
  color:#cbd5f1;
  margin-top:0;
}

.footer-logo{
  font-size:26px;
  font-weight:800;
  color:#ffffff;
  margin-bottom:12px;
}

.footer-desc{
  font-size:14px;
  line-height:1.6;
  color:#94a3b8;
  max-width:280px;
}

.footer-social{
  margin-top:14px;
  display:flex;
  gap:12px;
}

.footer-social a{
  width:38px;
  height:38px;
  border-radius:50%;
  display:flex;
  align-items:center;
  justify-content:center;
  background:#1e293b;
  color:#cbd5f1;
  font-size:16px;
  transition:.2s;
}

.footer-social a:hover{
  background:#2563eb;
  color:#fff;
}

.footer-menu h4,
.footer-contact h4{
  font-size:15px;
  font-weight:700;
  margin-bottom:14px;
  color:#ffffff;
}

.footer-menu ul{
  padding:0;
  margin:0;
  list-style:none;
}

.footer-menu li{
  margin-bottom:8px;
}

.footer-menu a{
  text-decoration:none;
  font-size:14px;
  color:#94a3b8;
  transition:.2s;
}

.footer-menu a:hover{
  color:#ffffff;
}

.footer-contact p{
  font-size:14px;
  color:#94a3b8;
  margin-bottom:6px;
}

.footer-bottom{
  border-top:1px solid #1e293b;
  padding:16px 0;
  text-align:center;
  font-size:13px;
  color:#94a3b8;
}

.footer-bottom strong{
  color:#ffffff;
}
</style>

<div id="footer" class="footer footer-gray">

	<div class="container footer-main">

		<div class="row">

			<!-- 브랜드 -->
			<div class="col-lg-4 footer-brand">

				<h3 class="footer-logo">공대생</h3>

				<p class="footer-desc">
				다양한 공간을 쉽고 빠르게 예약할 수 있는
				공간 대여 플랫폼입니다.
				</p>

				<div class="footer-social">
					<a href="#"><i class="bi bi-twitter-x"></i></a>
					<a href="#"><i class="bi bi-facebook"></i></a>
					<a href="#"><i class="bi bi-instagram"></i></a>
					<a href="#"><i class="bi bi-linkedin"></i></a>
				</div>

			</div>

			<!-- 링크 -->
			<div class="col-lg-2 footer-menu">

				<h4>서비스</h4>

				<ul>
					<li><a href="#">공간 찾기</a></li>
					<li><a href="#">이벤트</a></li>
					<li><a href="#">공지사항</a></li>
				</ul>

			</div>

			<!-- 고객지원 -->
			<div class="col-lg-3 footer-menu">

				<h4>고객지원</h4>

				<ul>
					<li><a href="#">이용약관</a></li>
					<li><a href="#">개인정보처리방침</a></li>
					<li><a href="#">청소년보호정책</a></li>
				</ul>

			</div>

			<!-- 연락처 -->
			<div class="col-lg-3 footer-contact">

				<h4>Contact</h4>

				<p>서울 마포구 월드컵북로 21</p>
				<p>Phone : +82 1234 5648</p>
				<p>Email : info@example.com</p>

			</div>

		</div>

	</div>


	<div class="footer-bottom">

		<div class="container">

			<p>
			<a href="${pageContext.request.contextPath}/admin/login">©</a>
			  2026 <strong>GongDaeSaeng</strong> All rights reserved
			</p>

		</div>

	</div>

</div>

<!-- Scroll Top -->
<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Preloader -->
<div id="preloader"></div>
<div id="loadingLayout"></div>