<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공간 등록 관리 - 공대생 호스트</title>
    
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    
    <style>
        :root {
            --host-primary: #E53935;
            --host-bg: #f4f6f9;
        }
        
        body { 
            background-color: var(--host-bg); 
            font-family: 'Pretendard', sans-serif; 
        }

        /* 공통 플랫 박스 (그림자 제거, 상단 적색 엣지) */
        .host-flat-box {
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-top: 4px solid var(--host-primary);
            border-radius: 6px;
            padding: 30px;
            height: 100%;
        }

        /* 좌측: 신청 현황 리스트 스타일 */
        .status-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .status-item {
            border: 1px solid #eee;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fafafa;
        }
        .status-item.active {
            background-color: #fffafa; /* 활성화된 항목은 옅은 붉은색 */
            border-color: var(--host-primary);
        }
        
        /* 뱃지 커스텀 */
        .badge-pending { background-color: #ffebee; color: #d32f2f; font-weight: normal; border: 1px solid #ffcdd2;}
        .badge-approved { background-color: #e8f5e9; color: #388e3c; font-weight: normal; border: 1px solid #c8e6c9;}
        .badge-rejected { background-color: #f5f5f5; color: #616161; font-weight: normal; border: 1px solid #e0e0e0;}

        /* 폼 입력 컨트롤 엣지 스타일 */
        .form-control, .form-select {
            border-radius: 4px;
            border: 1px solid #ccc;
            padding: 10px 15px;
        }
        .form-control:focus, .form-select:focus {
            border-color: var(--host-primary);
            box-shadow: none;
        }
        
        .form-label {
            font-weight: 600;
            color: #444;
            font-size: 0.95rem;
        }

        /* 등록 신청 버튼 */
        .btn-host-submit {
            background-color: var(--host-primary);
            color: white;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 4px;
            border: none;
            transition: background-color 0.2s;
        }
        .btn-host-submit:hover {
            background-color: #c62828;
            color: white;
        }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">
    
    <div class="mb-4">
        <h3 class="fw-bold" style="color: #333;">공간 등록 및 관리</h3>
        <p class="text-muted">새로운 공간을 등록하고, 검수 진행 상황을 확인할 수 있습니다.</p>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <form action="<c:url value='/host/space/write'/>" method="post" enctype="multipart/form-data">
                
                <div class="host-flat-box mb-4">
                    <h5 class="fw-bold mb-4 border-bottom pb-2" style="color: var(--host-primary);">1. 공간 기본 정보 및 정산</h5>
                    
                    <div class="row mb-3 g-3">
                        <div class="col-md-4">
    <label class="form-label">카테고리 <span class="text-danger">*</span></label>
    <select name="categoryNo" class="form-select" required>
        <option value="" selected disabled>선택</option>
        <c:forEach var="cat" items="${categoryList}">
            <option value="${cat.categoryNo}">${cat.name}</option>
        </c:forEach>
    </select>
</div>
                        <div class="col-md-8">
                            <label class="form-label">공간명 <span class="text-danger">*</span></label>
                            <input type="text" name="spaceName" class="form-control" placeholder="예) 하루클래스 강남점" required>
                        </div>
                    </div>

                    <div class="row mb-3 g-3">
                        <div class="col-md-6">
                            <label class="form-label">사업자 등록번호 <span class="text-danger">*</span></label>
                            <input type="text" name="bizRegNum" class="form-control" placeholder="000-00-00000" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">지역 분류 <span class="text-danger">*</span></label>
                            <input type="text" name="region" class="form-control" placeholder="예) 강남구" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">주소 <span class="text-danger">*</span></label>
                        <div class="d-flex gap-2 mb-2">
                            <input type="text" name="address" class="form-control" placeholder="도로명/지번 주소" required >
                            <button type="button" class="btn btn-outline-secondary" style="white-space: nowrap;">주소 검색</button>
                        </div>
                        <input type="text" name="detailAddr" class="form-control" placeholder="상세 주소 (예: 2층 201호)">
                    </div>

                    <div class="p-3 bg-light border rounded">
                        <h6 class="fw-bold mb-3"><i class="bi bi-wallet2 me-1"></i> 정산 계좌 정보</h6>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label small">은행명</label>
                                <input type="text" name="bankName" class="form-control" required placeholder="예) 신한은행">
                            </div>
                            <div class="col-md-5">
                                <label class="form-label small">계좌번호</label>
                                <input type="text" name="accountNo" class="form-control" required placeholder="'-' 제외 입력">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small">예금주</label>
                                <input type="text" name="accountHolder" class="form-control" required>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="host-flat-box mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
                        <h5 class="fw-bold m-0" style="color: var(--host-primary);">2. 세부 룸(Room) 정보</h5>
                        <button type="button" class="btn btn-sm btn-outline-host" onclick="addUnit()">
                            <i class="bi bi-plus-circle me-1"></i> 룸 추가하기
                        </button>
                    </div>
                    
                    <div id="unitContainer">
                        <div class="unit-box border rounded p-4 mb-3 position-relative" style="background-color: #fcfcfc;">
                            <h6 class="fw-bold mb-3" style="color: #333;">룸 #1</h6>
                            
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label small">룸 이름 <span class="text-danger">*</span></label>
                                    <input type="text" name="unitTitles" class="form-control" placeholder="예) A룸 (최대 4인)" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small">시간당 가격 <span class="text-danger">*</span></label>
                                    <input type="number" name="pricePerHours" class="form-control" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small">최대 인원 <span class="text-danger">*</span></label>
                                    <input type="number" name="maxCapacities" class="form-control" required>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label small">최소 이용시간 <span class="text-danger">*</span></label>
                                    <input type="number" name="minHours" class="form-control" placeholder="예) 2" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small">취소 기준(시간) <span class="text-danger">*</span></label>
                                    <input type="number" name="cancelLimitHrs" class="form-control" placeholder="예) 24" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label small">청소 보증금 <span class="text-danger">*</span></label>
                                    <input type="number" name="cleaningFees" class="form-control" placeholder="예) 5000" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small">룸 썸네일 이미지 <span class="text-danger">*</span></label>
                                <input type="file" name="unitThumbnailFiles" class="form-control" accept="image/*" required>
                            </div>

                            <div>
                                <label class="form-label small">룸 상세 설명</label>
                                <textarea name="descriptions" class="form-control" rows="3" placeholder="해당 룸의 특징이나 주의사항을 적어주세요."></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="host-flat-box mb-4">
                    <h5 class="fw-bold mb-4 border-bottom pb-2" style="color: var(--host-primary);">3. 공간 이미지 및 옵션</h5>
                    
                    <div class="mb-4">
                        <label class="form-label">공간 전체를 보여줄 추가 이미지 (다중 선택 가능)</label>
                        <input type="file" name="addFiles" class="form-control" multiple accept="image/*">
                        <div class="form-text">여러 장을 한 번에 드래그하여 선택할 수 있습니다.</div>
                    </div>
                    
                    <div>
                        <label class="form-label d-block mb-3">제공되는 편의시설 (다중 선택)</label>
                        <div class="d-flex flex-wrap gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="optionNos" value="1" id="opt1">
                                <label class="form-check-label" for="opt1"><i class="bi bi-wifi me-1"></i> WiFi</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="optionNos" value="2" id="opt2">
                                <label class="form-check-label" for="opt2"><i class="bi bi-projector me-1"></i> 프로젝터</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="optionNos" value="3" id="opt3">
                                <label class="form-check-label" for="opt3"><i class="bi bi-easel me-1"></i> 화이트보드</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="optionNos" value="4" id="opt4">
                                <label class="form-check-label" for="opt4"><i class="bi bi-p-circle me-1"></i> 주차가능</label>
                            </div>
                        </div>
                    </div>
                </div>

                <sec:csrfInput/>
                
                <div class="text-end">
                    <button type="submit" class="btn btn-lg btn-host-submit w-100 fs-5 py-3 shadow-sm">
                        <i class="bi bi-check-circle me-2"></i> 공간 등록 신청 완료
                    </button>
                </div>

            </form>
        </div>
</div>

</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>
<script>
    let unitCount = 1;

    function addUnit() {
        unitCount++;
        const container = document.getElementById('unitContainer');
        
       
        const html = `
            <div class="unit-box border rounded p-4 mb-3 position-relative mt-3" style="background-color: #fcfcfc;">
                <button type="button" class="btn btn-sm btn-outline-danger position-absolute" style="top: 15px; right: 15px;" onclick="this.parentElement.remove()">
                    <i class="bi bi-trash"></i> 삭제
                </button>
                
                <h6 class="fw-bold mb-3" style="color: #333;">룸 #\${unitCount}</h6>
                
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small">룸 이름 <span class="text-danger">*</span></label>
                        <input type="text" name="unitTitles" class="form-control" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small">시간당 가격 <span class="text-danger">*</span></label>
                        <input type="number" name="pricePerHours" class="form-control" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small">최대 인원 <span class="text-danger">*</span></label>
                        <input type="number" name="maxCapacities" class="form-control" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small">최소 이용시간 <span class="text-danger">*</span></label>
                        <input type="number" name="minHours" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small">취소 기준(시간) <span class="text-danger">*</span></label>
                        <input type="number" name="cancelLimitHrs" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small">청소 보증금 <span class="text-danger">*</span></label>
                        <input type="number" name="cleaningFees" class="form-control" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label small">룸 썸네일 이미지 <span class="text-danger">*</span></label>
                    <input type="file" name="unitThumbnailFiles" class="form-control" accept="image/*" required>
                </div>

                <div>
                    <label class="form-label small">룸 상세 설명</label>
                    <textarea name="descriptions" class="form-control" rows="3"></textarea>
                </div>
            </div>
        `;
        
        container.insertAdjacentHTML('beforeend', html);
    }
</script>


</body>
</html>