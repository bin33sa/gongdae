<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 결제 - 공대생 호스트 센터</title>
    
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        @import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/variable/pretendardvariable.css");
        
        :root {
            --primary-color: #E53935; /* 공대생 적색 포인트 */
            --bg-color: #f8f9fa;
        }
        
        body { 
            font-family: 'Pretendard Variable', Pretendard, -apple-system, sans-serif; 
            background-color: var(--bg-color); 
            color: #333; 
        }

        /* 폼 & 섹션 공통 스타일 */
        .checkout-section {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
            border: 1px solid #ebebeb;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
        }
        
        .section-title { 
            font-size: 1.25rem; 
            font-weight: 800; 
            margin-bottom: 24px;
            color: #111;
        }

        /* 입력 폼 스타일 */
        .form-control, .form-select {
            padding: 14px 16px;
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            font-size: 1rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(229, 57, 53, 0.15);
        }
        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            color: #555;
        }

        /* 우측 플로팅 요약 위젯 */
        .sticky-summary-widget {
            position: sticky;
            top: 30px; 
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
        }

        /* 커스텀 버튼 */
        .btn-primary-custom {
            background-color: var(--primary-color);
            border: none;
            color: white;
            padding: 16px;
            font-size: 1.1rem;
            font-weight: 800;
            border-radius: 12px;
            transition: all 0.2s;
        }
        .btn-primary-custom:hover { 
            background-color: #c62828; 
            color: white; 
            transform: translateY(-2px);
        }
        
        .btn-outline-custom {
            border: 1px solid #ddd;
            background-color: #fff;
            color: #333;
            font-weight: 600;
            border-radius: 8px;
        }
        .btn-outline-custom:hover {
            background-color: #f8f9fa;
            border-color: #ccc;
        }

        /* 요약 텍스트 정렬 */
        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            color: #555;
            font-size: 1rem;
        }
        
        /* 썸네일 이미지 */
        .space-thumbnail {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>

<main class="container my-5">
    
    <div class="mb-5">
        <h2 class="fw-bold" style="font-size: 2rem;">확인 및 결제</h2>
    </div>

    <div class="row">
        <div class="col-lg-8 pe-lg-4">
            
            <div class="checkout-section">
                <h4 class="section-title">예약 공간 정보</h4>
                
                <div class="d-flex align-items-center gap-3 mb-4 p-3 bg-light rounded-3 border">
                    <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=150&auto=format&fit=crop" class="space-thumbnail" alt="공간 이미지">
                    <div>
                        <div class="fw-bold fs-5 text-dark mb-1">홍대 파티룸 핫플레이스</div>
                        <div class="text-muted small"><i class="bi bi-door-open me-1"></i>A룸 (루프탑 포함)</div>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="p-3 border rounded-3 h-100">
                            <div class="text-muted small mb-2 fw-bold"><i class="bi bi-calendar-check me-2"></i>일정</div>
                            <div class="fw-bold text-dark fs-6 mb-1">2026. 03. 30 (월)</div>
                            <div class="text-secondary small">14:00 ~ 18:00 (총 4시간)</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 border rounded-3 h-100">
                            <div class="text-muted small mb-2 fw-bold"><i class="bi bi-people me-2"></i>인원</div>
                            <div class="fw-bold text-dark fs-6">총 4명</div>
                            <div class="text-secondary small mt-1">최대 8인 가능</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="checkout-section">
                <h4 class="section-title">예약자 정보</h4>
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label">예약자 이름</label>
                        <input type="text" class="form-control" value="김공대" readonly style="background-color: #fcfcfc;">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">연락처 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" value="010-1234-5678">
                    </div>
                    <div class="col-12">
                        <label class="form-label">호스트에게 남길 메모 <span class="text-muted fw-normal">(선택)</span></label>
                        <textarea class="form-control" rows="3" placeholder="예: 차량 1대 주차 등록 부탁드립니다."></textarea>
                    </div>
                </div>
            </div>

            <div class="checkout-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="section-title m-0">포인트 사용</h4>
                    <span class="text-muted small fw-bold">보유 포인트: <span class="text-dark">5,000</span> P</span>
                </div>
                
                <div class="input-group">
                    <input type="number" class="form-control font-monospace fs-5 text-end" value="0" min="0" placeholder="0">
                    <span class="input-group-text bg-white">P</span>
                    <button class="btn btn-outline-custom px-4" type="button">전액사용</button>
                </div>
            </div>

        </div>

        <div class="col-lg-4 mt-4 mt-lg-0">
            <div class="sticky-summary-widget">
                <h4 class="fw-bold mb-4 fs-5">결제 상세</h4>
                
                <div class="summary-row">
                    <span>공간 대여료</span>
                    <span class="fw-bold text-dark">60,000원</span>
                </div>
                
                <div class="summary-row text-danger">
                    <span>포인트 할인</span>
                    <span class="fw-bold">- 0원</span>
                </div>
                
                <hr class="my-4 border-secondary opacity-25">
                
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <span class="fw-bold text-dark fs-6">총 결제 금액</span>
                    <span class="fw-bold" style="font-size: 1.8rem; color: var(--primary-color);">
                        <fmt:formatNumber value="60000" pattern="#,###"/>원
                    </span>
                </div>

                <div class="bg-light p-3 rounded-3 mb-4 text-center">
                    <span class="text-muted small">결제 시 <span class="fw-bold text-dark">600P</span>가 적립됩니다.</span>
                </div>

                <button type="button" class="btn btn-primary-custom w-100 mb-2">
                    결제하기
                </button>
                <button type="button" class="btn btn-light w-100 fw-bold py-3 text-muted border" onclick="history.back();">
                    뒤로 가기
                </button>
            </div>
        </div>

    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>