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
    gap: 10px;
    border-radius: 16px;
    overflow: hidden;
    margin-bottom: 40px;
}
.gallery-container.count-1 {
	grid-template-columns: 1fr;
    grid-template-rows: 500px;
}
.gallery-container.count-2 {
	grid-template-columns: 1fr 1fr;
    grid-template-rows: 500px;
}
.gallery-container.count-3 {
	grid-template-columns: 1fr 1fr;
    grid-template-rows: 250px 250px;
}
.gallery-container.count-3 .main {
	grid-row: span 2;
}
.gallery-container.count-4 {
	grid-template-columns: 1fr 1fr;
    grid-template-rows: 250px 250px;
}

.gallery-item { width: 100%; height: 100%; object-fit: cover; cursor: pointer; transition: opacity 0.2s;}
.gallery-item:hover { opacity: 0.9; filter: brightness(0.9);}
.gallery-itm:first-child { /*grid-row: 1 / 3;*/ } 


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

.active-card {
	border-color: var(--primary-color);
}

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
        <span class="badge bg-dark mb-2 px-2 py-1 fw-normal">${space.category}</span>
        <h2 class="fw-bold" style="font-size: 2rem;">${space.name}</h2>
        <div class="text-muted mt-2 fs-6">
            <i class="bi bi-geo-alt-fill me-1 text-danger"></i> ${space.address}, ${space.address2}
        </div>
    </div>

    <div class="gallery-container count-${spaceImageCount}">
    	<c:forEach var="img" items="${spaceImageList}" varStatus="status">
	        <img src="${pageContext.request.contextPath}/uploads/space/${img}" class="gallery-item ${status.first ? 'main' : ''}" alt="공간사진">
    	</c:forEach>
    
       
    </div>

    <div class="row">
        <div class="col-lg-8 pe-lg-5">
            
            <div class="d-flex align-items-center justify-content-between pb-4 border-bottom mt-2">
                <div>
                    <h4 class="fw-bold mb-1">호스트 : ${host.name} 님</h4>
                </div>
                <img src="${pageContext.request.contextPath}/uploads/host/${host.profile_photo}"
                	onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/dist/images/avatar.png';"
					class="rounded-circle" style="width: 56px; height: 56px;" alt="호스트">
            </div>

            <div class="detail-section">
                <h4 class="section-title">공간 소개</h4>
                <p style="line-height: 1.8; color: #444; font-size: 1.05rem;">
                    <c:out value="${space.space_intro}"/>
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

            <div class="detail-section border-bottom-0 pb-0" id="unitList">
                <h4 class="section-title">예약 가능한 룸</h4>
                <c:forEach var="spaceUnit" items="${spaceUnits}">
	                <div class="unit-card d-flex justify-content-between align-items-center" onclick="unitSelect(${spaceUnit.unitNo});">
	                    <div>
	                        <h5 class="fw-bold mb-2">${spaceUnit.title}</h5>
	                        <div class="text-muted small mb-2"><i class="bi bi-person-fill me-1"></i>최대 ${spaceUnit.maxCapacity}인 <span class="mx-2">|</span> 최소 ${spaceUnit.minHours}시간</div>
	                        <span class="fw-bold text-danger fs-5">
	                        	<fmt:formatNumber value="${spaceUnit.pricePerHour}" type="number" groupingUsed="true"/>원
                        	</span> / 시간
	                    </div>
	                </div>
                </c:forEach>
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
                
                <form name="reservationForm" action="" method="post">
                <div class="border rounded p-3 mb-4 border-2">
                    <div class="mb-3 border-bottom pb-3">
                        <label class="fw-bold small mb-1 text-muted">이용 날짜</label>
                        <input name="res_date" type="date" class="form-control border-0 p-0 fs-5 fw-bold" style="outline: none;">
                    </div>
                    <div class="mb-3 border-bottom pb-3">
                        <label class="fw-bold small mb-1 text-muted">이용 시간</label>
                        <div class="d-flex align-items-center gap-2">
    	                    <input name="start_time" type="number" class="form-control border-0 p-0 fs-5 fw-bold" min="1" max="24" value="1" style="outline: none;">
	                        <span>~</span>
	                        <input name="end_time" type="number" class="form-control border-0 p-0 fs-5 fw-bold" min="1" max="24" value="1" style="outline: none;">
                        </div>
                    </div>
                    <div>
                        <label class="fw-bold small mb-1 text-muted">이용 인원</label>
                        <select name="people_count" class="form-select border-0 p-0 fs-5 fw-bold" style="outline: none; cursor:pointer;">
                            <option value="1">1명</option>
                            <option value="2" selected>2명</option>
                            <option value="3">3명</option>
                            <option value="4">4명</option>
                        </select>
                    </div>
                </div>

                <button type="button" class="btn btn-primary-custom w-100 py-3" onclick="sendReservation();">
                    예약 진행하기
                </button>
                <input type="hidden" name="unit_no">
                <input type="hidden" name="space_no" value="${space.num}">
                </form>
                <c:choose>
	                <c:when test="${not empty message}">
	    	            <div class="text-center text-danger small mt-3">${message}</div>
   		        	</c:when>
					<c:otherwise>
	    	            <div class="text-center text-muted small mt-3">결제는 다음 단계에서 진행됩니다.</div>
					</c:otherwise>    
                </c:choose>
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
                <button type="button" class="btn btn-danger px-4 py-2 fw-bold" data-bs-dismiss="modal">문의 등록</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function sendReservation() {
	const f = document.reservationForm;
	
	if(! f.unit_no.value) {
		alert("대여할 공간을 선택해야합니다.");
		return;
	}
	
	if(! f.res_date.value) {
		alert("날짜를 선택해주세요");
		return;
	}
	
	if(f.start_time.value >= f.end_time.value) {
		alert("대여 시작 시간이 종료 시간보다 앞서야 합니다.");
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/payment/reservation';
	f.submit();

}

function unitSelect(unitNo) {
	document.reservationForm.unit_no.value = unitNo;
}


document.getElementById("unitList").addEventListener("click", function(e) {

	if(e.target.classList.contains("unit-card")) {
		this.querySelectorAll(".unit-card").forEach(card => {
			card.classList.remove("active-card");
		})
		
		e.target.classList.add("active-card");
	}
})


</script>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>