<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공대생 호스트 센터 - 공간을 공유하고 수익을 창출하세요</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        :root {
            --main-color: #1C6296; 
            --point-color: #F8D153; 
        }
        
        body { font-family: 'Pretendard', 'Noto Sans KR', sans-serif; background-color: #f8f9fa; }

        /* 1. 최상단 히어로 배너 영역 */
        .hero-section {
            background: linear-gradient(135deg, var(--main-color) 0%, #154c75 100%);
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .hero-title { font-size: 2.5rem; font-weight: bold; margin-bottom: 20px; line-height: 1.4; }
        .hero-subtitle { font-size: 1.2rem; margin-bottom: 40px; opacity: 0.9; }
        .btn-register {
            background-color: var(--point-color);
            color: #333;
            font-size: 1.2rem;
            font-weight: bold;
            padding: 15px 40px;
            border-radius: 50px;
            border: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(248, 209, 83, 0.4);
            color: #000;
        }

        /* 2. 호스트 혜택 소개 영역 */
        .benefit-section { padding: 80px 0; background-color: #fff; }
        .section-title { text-align: center; font-size: 2rem; font-weight: bold; margin-bottom: 50px; color: #333; }
        .benefit-card { text-align: center; padding: 20px; }
        .benefit-icon {
            font-size: 3rem;
            color: var(--main-color);
            margin-bottom: 20px;
        }
        .benefit-title { font-size: 1.25rem; font-weight: bold; margin-bottom: 15px; }
        .benefit-text { color: #666; line-height: 1.6; }

        /* 3. 이용 순서 안내 영역 */
        .step-section { padding: 80px 0; }
        .step-box {
            background-color: #fff;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            height: 100%;
        }
        .step-number {
            display: inline-block;
            width: 40px;
            height: 40px;
            line-height: 40px;
            background-color: var(--main-color);
            color: white;
            border-radius: 50%;
            font-weight: bold;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

    <section class="hero-section">
        <div class="container">
            <h1 class="hero-title">남는 공간이 있다면?<br>지금 바로 수익을 만들어보세요</h1>
            <p class="hero-subtitle">파티룸, 연습실, 스터디룸 등 어떤 공간이든 쉽게 등록하고 관리할 수 있습니다.</p>
            
            <sec:authorize access="isAnonymous()">
                <a href="${pageContext.request.contextPath}/host/prelogin" class="btn btn-register text-decoration-none">호스트 가입하고 공간 등록하기</a>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <a href="<c:url value='/host/space/register'/>" class="btn btn-register text-decoration-none">내 공간 등록하기</a>
            </sec:authorize>
        </div>
    </section>

    <section class="benefit-section">
        <div class="container">
            <h2 class="section-title">공대생 호스트가 되어야 하는 이유</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="benefit-card">
                        <i class="bi bi-people-fill benefit-icon"></i>
                        <h3 class="benefit-title">압도적인 게스트 수</h3>
                        <p class="benefit-text">수많은 대학생과 직장인들이 매일 새로운 공간을 찾고 있습니다. 비어있는 시간을 가득 채워보세요.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card">
                        <i class="bi bi-phone benefit-icon"></i>
                        <h3 class="benefit-title">간편한 예약 관리</h3>
                        <p class="benefit-text">모바일과 PC 어디서든 직관적인 대시보드를 통해 실시간 예약 현황을 손쉽게 관리할 수 있습니다.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-card">
                        <i class="bi bi-cash-coin benefit-icon"></i>
                        <h3 class="benefit-title">투명하고 빠른 정산</h3>
                        <p class="benefit-text">복잡한 절차 없이, 이용 완료된 내역에 대해 빠르고 투명하게 수익을 정산해 드립니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="step-section">
        <div class="container">
            <h2 class="section-title">공간 등록, 참 쉽습니다</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="step-box">
                        <div class="step-number">1</div>
                        <h4 class="fw-bold mb-3">호스트 가입</h4>
                        <p class="text-muted">간단한 정보 입력으로<br>호스트 회원이 되어주세요.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-box">
                        <div class="step-number">2</div>
                        <h4 class="fw-bold mb-3">공간 정보 등록</h4>
                        <p class="text-muted">사진, 이용 요금, 상세 설명을<br>매력적으로 작성해 주세요.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-box">
                        <div class="step-number">3</div>
                        <h4 class="fw-bold mb-3">예약 받기 시작</h4>
                        <p class="text-muted">관리자 승인 후 즉시 노출되며,<br>게스트의 예약을 받을 수 있습니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>