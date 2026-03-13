<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공대생 호스트 센터</title>
    
    <jsp:include page="/WEB-INF/views/host/layout/headerResources.jsp"/>
    
    <style>
        :root {
            --host-primary: #E53935;
            --host-bg-light: #fffafa; /* 아주 옅은 붉은빛이 도는 웜톤 배경 */
        }
        
        body { 
            background-color: #ffffff; 
            font-family: 'Pretendard', sans-serif; 
        }

        /* 1. 히어로 배너 섹션 (그림자 없이 깔끔한 배경색으로만 구분) */
        .hero-section {
            background-color: var(--host-bg-light);
            border-bottom: 1px solid #f0f0f0;
            padding: 100px 0 120px 0;
            text-align: center;
        }
        .hero-title {
            font-size: 2.8rem;
            font-weight: 800;
            color: #222;
            letter-spacing: -1px;
            margin-bottom: 20px;
        }
        .hero-subtitle {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 50px;
        }

        /* 버튼 스타일 (플랫 디자인) */
        .btn-host-solid {
            background-color: var(--host-primary);
            color: #fff !important;
            font-weight: bold;
            font-size: 1.1rem;
            padding: 15px 40px;
            border-radius: 6px;
            border: 1px solid var(--host-primary);
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-host-solid:hover {
            background-color: #c62828;
            border-color: #c62828;
        }
        
        .btn-host-outline {
            background-color: #fff;
            color: var(--host-primary) !important;
            font-weight: bold;
            font-size: 1.1rem;
            padding: 15px 40px;
            border-radius: 6px;
            border: 1px solid var(--host-primary);
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-host-outline:hover {
            background-color: #fff2f2;
        }

        /* 2. 공지사항 보드 섹션 */
        .notice-section {
            padding: 80px 0;
            background-color: #ffffff;
        }
        .notice-board {
            background-color: #ffffff;
            border: 1px solid #e9ecef;
            border-top: 3px solid var(--host-primary); /* 상단 적색 엣지 포인트 */
            border-radius: 4px;
            padding: 40px;
        }
        .notice-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #333;
            padding-bottom: 15px;
        }
        .notice-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .notice-list li {
            display: flex;
            justify-content: space-between;
            padding: 18px 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        .notice-list li a {
            text-decoration: none;
            color: #444;
            font-weight: 500;
            transition: color 0.2s;
        }
        .notice-list li a:hover {
            color: var(--host-primary);
        }
        .notice-date {
            color: #999;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main>
    <section class="hero-section" >
    
        <div class="container">
            <h1 class="hero-title">공대생과 함께<br>비어있는 공간의 가치를 높여보세요</h1>
            <p class="hero-subtitle">간단한 등록만으로 수많은 대학생과 게스트에게 공간을 홍보할 수 있습니다.</p>
            
            <div class="d-flex justify-content-center gap-3">
               <a href="${pageContext.request.contextPath}/dist/docs/proposal.pdf" target="_blank" class="btn-host-outline">
    				<i class="bi bi-file-earmark-text me-2"></i>입점 제안서 보기
				</a>
                
                <a href="<c:url value='/member/login'/>" class="btn-host-solid">
                    매장 등록 시작하기 <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </section>
<section class="process-section" style="padding: 80px 0; background-color: #ffffff;">
        <div class="container">
            <h3 class="fw-bold text-center mb-5" style="color: #333;">쉽고 빠른 호스트 시작하기</h3>
            
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="flat-box flex-column" style="height: 220px; padding: 30px;">
                        <div class="mb-3 d-inline-flex justify-content-center align-items-center" style="width: 48px; height: 48px; background-color: var(--host-primary); color: white; border-radius: 50%; font-size: 1.2rem; font-weight: bold;">1</div>
                        <h5 class="fw-bold">공간 등록</h5>
                        <p class="text-muted small mt-2">사진과 이용 안내를 입력하여<br>내 공간을 매력적으로 소개하세요.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="flat-box flex-column" style="height: 220px; padding: 30px;">
                        <div class="mb-3 d-inline-flex justify-content-center align-items-center" style="width: 48px; height: 48px; background-color: var(--host-primary); color: white; border-radius: 50%; font-size: 1.2rem; font-weight: bold;">2</div>
                        <h5 class="fw-bold">예약 및 결제</h5>
                        <p class="text-muted small mt-2">수많은 게스트가 공간을 예약하며<br>결제까지 안전하게 진행됩니다.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="flat-box flex-column" style="height: 220px; padding: 30px;">
                        <div class="mb-3 d-inline-flex justify-content-center align-items-center" style="width: 48px; height: 48px; background-color: var(--host-primary); color: white; border-radius: 50%; font-size: 1.2rem; font-weight: bold;">3</div>
                        <h5 class="fw-bold">빠른 정산</h5>
                        <p class="text-muted small mt-2">공간 이용이 완료되면<br>지정된 계좌로 안전하게 정산됩니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="notice-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    
                    <div class="notice-board">
                        <div class="notice-header">
                            <h4 class="fw-bold m-0" style="color: #333;">호스트 센터 새소식</h4>
                            <a href="#" class="text-muted text-decoration-none small">더보기 +</a>
                        </div>
                        
                        <ul class="notice-list">
                            <li>
                                <a href="#"><span class="badge bg-light text-danger border border-danger me-2">필독</span> 2026년 상반기 정산 시스템 업데이트 안내</a>
                                <span class="notice-date">2026.03.12</span>
                            </li>
                            <li>
                                <a href="#">봄 시즌 맞이 공간 할인 프로모션 참여 호스트 모집</a>
                                <span class="notice-date">2026.03.05</span>
                            </li>
                            <li>
                                <a href="#">새로운 공간 옵션(편의시설) 태그 15종이 추가되었습니다.</a>
                                <span class="notice-date">2026.02.28</span>
                            </li>
                            <li>
                                <a href="#">[안내] 호스트 고객센터 전화 상담 시간 변경 안내</a>
                                <span class="notice-date">2026.02.15</span>
                            </li>
                        </ul>
                    </div>
                    
                </div>
            </div>
        </div>
    </section>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/host/layout/footerResources.jsp"/>

</body>
</html>