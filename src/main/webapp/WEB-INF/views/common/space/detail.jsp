<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>

<style type="text/css">
body {
	font-family: 'Pretendard', -apple-system, sans-serif; 
	background-color: #fff; 
	color: #333; 
}

/* 내비게이션 바 (임시) */
.mock-header {
    border-bottom: 1px solid #eee;
    padding: 15px 0;
    margin-bottom: 30px;
}

/* 이미지 갤러리 그리드 */
.gallery-container {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    grid-template-rows: 250px 250px;
    gap: 10px;
    border-radius: 16px;
    overflow: hidden;
    margin-bottom: 40px;
}
.gallery-item { width: 100%; height: 100%; object-fit: cover; cursor: pointer; transition: opacity 0.2s;}
.gallery-item:hover { opacity: 0.9; filter: brightness(0.9);}
.item-main { grid-row: 1 / 3; } 

/* 섹션 공통 스타일 */
.detail-section {
    padding: 40px 0;
    border-bottom: 1px solid #ebebeb;
}
.section-title { font-size: 1.3rem; font-weight: bold; margin-bottom: 20px; }

/* 세부 룸(Unit) 카드 */
.unit-card {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 15px;
    transition: all 0.2s;
}
.unit-card:hover { border-color: var(--primary-color); box-shadow: 0 4px 12px rgba(229, 57, 53, 0.08); }

/* 우측 플로팅 예약 위젯 */
.sticky-booking-widget {
    position: sticky;
    top: 100px; 
    border: 1px solid #e0e0e0;
    border-radius: 16px;
    padding: 24px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.08);
    background-color: #fff;
}

/* 커스텀 버튼 */
.btn-qna {
    background-color: #f8f9fa;
    border: 1px solid #ddd;
    color: #333;
    font-weight: 500;
}
.btn-qna:hover { background-color: #e9ecef; }

.btn-primary-custom {
    background-color: var(--accent-color);
    border: none;
    color: white;
    padding: 14px;
    font-size: 1.1rem;
    font-weight: bold;
    border-radius: 8px;
    transition: background-color 0.2s;
}
.btn-primary-custom:hover { background-color: var(--accent-hover-color); color: white; }
</style>

</head>
<body>


<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>


<main class="container mb-5">
    
    <div class="mb-4">
        <span class="badge bg-dark mb-2 px-2 py-1 fw-normal">스터디룸</span>
        <h2 class="fw-bold" style="font-size: 2rem;">온트랙클래스 강남점</h2>
        <div class="text-muted mt-2 fs-6">
            <i class="bi bi-geo-alt-fill me-1 text-danger"></i> 서울 강남구 강남대로 34번길 11, 202동 202호
        </div>
    </div>

    <div class="gallery-container">
        <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=1000&auto=format&fit=crop" class="gallery-item item-main" alt="메인">
        <img src="https://images.unsplash.com/photo-1556761175-4b46a572b786?q=80&w=500&auto=format&fit=crop" class="gallery-item" alt="서브1">
        <img src="https://images.unsplash.com/photo-1527192491265-7e15c55b1ed2?q=80&w=500&auto=format&fit=crop" class="gallery-item" alt="서브2">
        <img src="https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=500&auto=format&fit=crop" class="gallery-item" alt="서브3">
        <img src="https://images.unsplash.com/photo-1600508774634-4e11d34730e2?q=80&w=500&auto=format&fit=crop" class="gallery-item" alt="서브4">
    </div>

    <div class="row">
        <div class="col-lg-8 pe-lg-5">
            
            <div class="d-flex align-items-center justify-content-between pb-4 border-bottom mt-2">
                <div>
                    <h4 class="fw-bold mb-1">호스트 : 일석준 님</h4>
                    <span class="text-muted">응답률 100% · 신속한 답변을 자랑하는 우수 호스트입니다.</span>
                </div>
                <img src="https://ui-avatars.com/api/?name=석준&background=E53935&color=fff" class="rounded-circle" style="width: 56px; height: 56px;" alt="호스트">
            </div>

            <div class="detail-section">
                <h4 class="section-title">공간 소개</h4>
                <p style="line-height: 1.8; color: #444; font-size: 1.05rem;">
                    강남역 도보 3분 거리에 위치한 최고급 스터디룸 및 프리미엄 회의 공간입니다.<br><br>
                    대형 모니터와 화이트보드가 모든 룸에 기본 세팅되어 있으며, 
                    스타트업 미팅, 스터디 모임, 독서 모임 등에 최적화된 쾌적한 환경을 제공합니다. 
                    향긋한 커피 머신과 다과도 무료로 이용해 보세요!
                </p>
            </div>

            <div class="detail-section">
                <h4 class="section-title">제공되는 편의시설</h4>
                <div class="d-flex flex-wrap gap-2 mt-3">
                    <div class="badge border text-dark py-2 px-3 fw-normal fs-6" style="background-color: #fcfcfc;"><i class="bi bi-wifi fs-5 me-2 text-primary"></i>기가 와이파이</div>
                    <div class="badge border text-dark py-2 px-3 fw-normal fs-6" style="background-color: #fcfcfc;"><i class="bi bi-projector fs-5 me-2 text-primary"></i>빔 프로젝터</div>
                    <div class="badge border text-dark py-2 px-3 fw-normal fs-6" style="background-color: #fcfcfc;"><i class="bi bi-easel fs-5 me-2 text-primary"></i>대형 화이트보드</div>
                    <div class="badge border text-dark py-2 px-3 fw-normal fs-6" style="background-color: #fcfcfc;"><i class="bi bi-p-circle fs-5 me-2 text-primary"></i>무료 주차 (1대)</div>
                    <div class="badge border text-dark py-2 px-3 fw-normal fs-6" style="background-color: #fcfcfc;"><i class="bi bi-cup-hot fs-5 me-2 text-primary"></i>커피/다과</div>
                </div>
            </div>

            <div class="detail-section border-bottom-0 pb-0">
                <h4 class="section-title">예약 가능한 룸</h4>
                
                <div class="unit-card d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-2">A룸 (대형 회의실)</h5>
                        <div class="text-muted small mb-2"><i class="bi bi-person-fill me-1"></i>최대 8인 <span class="mx-2">|</span> 최소 2시간</div>
                        <span class="fw-bold text-danger fs-5">15,000원</span> / 시간
                    </div>
                    <button class="btn btn-outline-dark px-4 py-2">선택</button>
                </div>

                <div class="unit-card d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-2">B룸 (포커스 룸)</h5>
                        <div class="text-muted small mb-2"><i class="bi bi-person-fill me-1"></i>최대 4인 <span class="mx-2">|</span> 최소 1시간</div>
                        <span class="fw-bold text-danger fs-5">8,000원</span> / 시간
                    </div>
                    <button class="btn btn-outline-dark px-4 py-2">선택</button>
                </div>
            </div>

            <div class="detail-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="section-title m-0">Q&A 문의</h4>
                    <button class="btn btn-qna px-3" data-bs-toggle="modal" data-bs-target="#qnaModal">
                        <i class="bi bi-pencil-square me-1"></i>문의 남기기
                    </button>
                </div>
                
                <div class="p-4 rounded mb-3" style="background-color: #f8f9fa;">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="fw-bold fs-5"><i class="bi bi-q-circle-fill text-danger me-2"></i>빔 프로젝터 HDMI 선 있나요?</span>
                        <span class="badge bg-success rounded-pill align-self-center py-2 px-3 fw-normal">답변완료</span>
                    </div>
                    <div class="text-muted small mb-3 ms-4 ps-1">김공대 님 | 2026.03.12</div>
                    <div class="ms-4 ps-3 border-start border-3 border-danger mt-2">
                        <div class="fw-bold mb-1"><i class="bi bi-c-circle-fill text-primary me-1"></i> 호스트 답변</div>
                        <p class="mb-0 text-dark">네, 2m 케이블이 상시 구비되어 있습니다! 편하게 사용하세요.</p>
                    </div>
                </div>
            </div>

        </div>

        <div class="col-lg-4">
            <div class="sticky-booking-widget">
                <h3 class="fw-bold mb-4">15,000원 <span class="fs-6 fw-normal text-muted">/ 시간</span></h3>
                
                <div class="border rounded p-3 mb-4 border-2">
                    <div class="mb-3 border-bottom pb-3">
                        <label class="fw-bold small mb-1 text-muted">이용 날짜</label>
                        <input type="date" class="form-control border-0 p-0 fs-5 fw-bold" value="2026-03-14" style="outline: none;">
                    </div>
                    <div>
                        <label class="fw-bold small mb-1 text-muted">이용 인원</label>
                        <select class="form-select border-0 p-0 fs-5 fw-bold" style="outline: none; cursor:pointer;">
                            <option value="1">1명</option>
                            <option value="2">2명</option>
                            <option value="3" selected>3명</option>
                            <option value="4">4명</option>
                        </select>
                    </div>
                </div>

                <button type="button" class="btn btn-primary-custom w-100 py-3">
                    예약 진행하기
                </button>
                <div class="text-center text-muted small mt-3">
                    결제는 다음 단계에서 진행됩니다.
                </div>
            </div>
        </div>

    </div>
</main>

<div class="modal fade" id="qnaModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header border-bottom-0 pb-0 mt-2 mx-2">
                <h5 class="modal-title fw-bold fs-4">호스트에게 문의하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body mx-2">
                <div class="mb-4">
                    <p class="text-muted small">
                        예약 관련 변동 사항이나 시설에 대해 궁금한 점을 남겨주시면,<br>호스트가 확인 후 답변해 드립니다!
                    </p>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold small">제목</label>
                    <input type="text" class="form-control p-3" placeholder="예: 주차 관련 문의드립니다.">
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold small">문의 내용</label>
                    <textarea class="form-control p-3" rows="5" placeholder="문의하실 내용을 상세히 적어주세요."></textarea>
                </div>
            </div>
            
            <div class="modal-footer border-top-0 pt-0 mb-2 mx-2">
                <button type="button" class="btn btn-light px-4 py-2 fw-bold" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger px-4 py-2 fw-bold" style="background-color: var(--primary-color);">문의 등록</button>
            </div>
        </div>
    </div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>