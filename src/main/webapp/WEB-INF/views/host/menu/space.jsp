<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공간 등록 관리 - 공대생 호스트</title>
    <jsp:include page="/WEB-INF/views/host/layout/chatWidget.jsp"/>
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/space.css">
    
    <style>
        :root { --host-primary: #E53935; --host-bg: #f4f6f9; }
        body { background-color: var(--host-bg); font-family: 'Pretendard', sans-serif; }
        .host-flat-box { background-color: #ffffff; border: 1px solid #dee2e6; border-top: 4px solid var(--host-primary); border-radius: 6px; padding: 30px; height: 100%; }
        .form-control, .form-select { border-radius: 4px; border: 1px solid #ccc; padding: 10px 15px; }
        .form-control:focus, .form-select:focus { border-color: var(--host-primary); box-shadow: none; }
        .form-label { font-weight: 600; color: #444; font-size: 0.95rem; }
        .btn-host-submit { background-color: var(--host-primary); color: white; font-weight: bold; padding: 12px 30px; border-radius: 4px; border: none; transition: background-color 0.2s; }
        .btn-host-submit:hover { background-color: #c62828; color: white; }
        .time-table td { padding: 4px; vertical-align: middle; }
    </style>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">
    
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <div>
            <h3 class="fw-bold" style="color: #333;">공간 ${mode == 'update' ? '수정' : '등록'} 및 관리</h3>
            <p class="text-muted mb-0">공간 정보를 ${mode == 'update' ? '수정' : '새롭게 등록'}할 수 있습니다.</p>
        </div>
        
        <c:if test="${mode == 'update'}">
            <form id="deleteSpaceForm" action="<c:url value='/host/space/delete'/>" method="post">
                <input type="hidden" name="spaceNo" value="${dto.spaceNo}">
                <button type="button" class="btn btn-outline-danger" onclick="confirmSpaceDelete()">
                    <i class="bi bi-trash3"></i> 공간 삭제
                </button>
            </form>
        </c:if>
    </div>

    <div class="row g-4">
        <div class="col-lg-12">
            <form id="updateSpaceForm" action="<c:url value='/host/space/${mode}'/>" method="post" enctype="multipart/form-data">
                
                <c:if test="${mode == 'update'}">
                    <input type="hidden" name="spaceNo" value="${dto.spaceNo}">
                </c:if>

                <div class="host-flat-box mb-4">
                    <h5 class="fw-bold mb-4 border-bottom pb-2" style="color: var(--host-primary);">1. 공간 기본 정보 및 정산</h5>
                    
                    <div class="row mb-3 g-3">
                        <div class="col-md-4">
                            <label class="form-label">카테고리 <span class="text-danger">*</span></label>
                            <select name="categoryNo" class="form-select" required>
                                <option value="" ${empty dto.categoryNo ? 'selected' : ''} disabled>선택</option>
                                <c:forEach var="cat" items="${categoryList}">
                                    <option value="${cat.categoryNo}" ${dto.categoryNo == cat.categoryNo ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">공간명 <span class="text-danger">*</span></label>
                            <input type="text" name="spaceName" class="form-control" value="${dto.spaceName}" required>
                        </div>
                    </div>

                    <div class="row mb-3 g-3">
                        <div class="col-md-6">
                            <label class="form-label">사업자 등록번호 <span class="text-danger">*</span></label>
                            <input type="text" name="bizRegNum" class="form-control" value="${dto.bizRegNum}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">지역 분류 <span class="text-danger">*</span></label>
                            <input type="text" name="region" class="form-control" value="${dto.region}" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">주소 <span class="text-danger">*</span></label>
                        <div class="d-flex gap-2 mb-2">
                            <input type="text" id="zipCode" name="zipCode" class="form-control" placeholder="우편번호" style="width: 150px;" readonly>
                            <button type="button" class="btn btn-outline-secondary" style="white-space: nowrap;" onclick="searchZipCode()">주소 검색</button>
                        </div>
                        <div class="mb-2">
                            <input type="text" name="address" id="address" class="form-control" value="${dto.address}" placeholder="기본 주소" readonly>
                        </div>
                        <div class="d-flex gap-2">
                            <input type="text" name="detailAddr" id="detailAddr" class="form-control" value="${dto.detailAddr}" placeholder="상세 주소를 입력해주세요">
                            <input type="text" id="extraAddress" name="extraAddress" class="form-control" placeholder="참고항목 (동, 건물명)" readonly style="width: 30%;">
                        </div>
                    </div>

                    <div class="p-3 bg-light border rounded">
                        <h6 class="fw-bold mb-3"><i class="bi bi-wallet2 me-1"></i> 정산 계좌 정보</h6>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label small">은행명</label>
                                <input type="text" name="bankName" class="form-control" value="${dto.bankName}" required>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label small">계좌번호</label>
                                <input type="text" name="accountNo" class="form-control" value="${dto.accountNo}" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label small">예금주</label>
                                <input type="text" name="accountHolder" class="form-control" value="${dto.accountHolder}" required>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="host-flat-box mb-4">
                    <h5 class="fw-bold mb-4 border-bottom pb-2" style="color: var(--host-primary);">2. 공간 상세 소개 및 안내</h5>
                    
                    <div class="mb-4">
                        <label class="form-label">공간 소개글 <span class="text-danger">*</span></label>
                        <div class="form-text mb-2">게스트의 마음을 사로잡을 수 있도록 공간의 매력을 자유롭게 작성해 주세요.</div>
                        <textarea name="spaceIntro" class="form-control" rows="8" required>${dto.spaceIntro}</textarea>
                    </div>

                    <div>
                        <label class="form-label">이용 안내 및 주의사항 <span class="text-danger">*</span></label>
                        <div class="form-text mb-2">주차, 소음, 분리수거 등 게스트가 꼭 지켜야 할 규칙을 적어주세요.</div>
                        <textarea name="spaceGuide" class="form-control" rows="5" required>${dto.spaceGuide}</textarea>
                    </div>
                </div>

                <div class="host-flat-box mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
                        <h5 class="fw-bold m-0" style="color: var(--host-primary);">3. 세부 룸(Room) 정보</h5>
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="addUnit()">
                            <i class="bi bi-plus-circle me-1"></i> 룸 추가하기
                        </button>
                    </div>
                    
                    <div id="unitContainer">
                        <c:choose>
                            <c:when test="${mode == 'update' && not empty listUnit}">
                                <c:forEach var="unit" items="${listUnit}" varStatus="st">
                                    <div class="unit-box border rounded p-4 mb-3 position-relative" style="background-color: #fcfcfc;">
                                        <c:if test="${st.index > 0}">
                                            <button type="button" class="btn btn-sm btn-outline-danger position-absolute" style="top: 15px; right: 15px;" onclick="removeUnit(this)"><i class="bi bi-trash"></i> 삭제</button>
                                        </c:if>
                                        
                                        <h6 class="fw-bold mb-3" style="color: #333;">룸 #${st.count}</h6>
                                        
                                        <div class="row g-3 mb-3">
                                            <div class="col-md-6">
                                                <label class="form-label small">룸 이름 <span class="text-danger">*</span></label>
                                                <input type="text" name="unitTitles" class="form-control" value="${unit.title}" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small">시간당 가격 <span class="text-danger">*</span></label>
                                                <input type="number" name="pricePerHours" class="form-control" value="${unit.pricePerHour}" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label small">최대 인원 <span class="text-danger">*</span></label>
                                                <input type="number" name="maxCapacities" class="form-control" value="${unit.maxCapacity}" required>
                                            </div>
                                        </div>

                                        <div class="mb-4 p-3 border rounded bg-white">
                                            <label class="form-label small text-primary fw-bold mb-2"><i class="bi bi-calendar-week me-1"></i>요일별 운영 시간 <span class="text-danger">*</span></label>
                                            <table class="table table-borderless table-sm time-table mb-0 text-center align-middle">
                                                <tbody>
                                                    <c:set var="daysStr" value="월,화,수,목,금,토,일"/>
                                                    <c:forEach var="d" items="${daysStr.split(',')}">
                                                        <tr>
                                                            <td style="width: 12%;"><span class="badge bg-light text-dark border w-100 py-2">${d}</span></td>
                                                            <td style="width: 24%;">
                                                                <div class="d-flex justify-content-center gap-3 m-0">
                                                                    <div class="form-check form-switch m-0">
                                                                        <input class="form-check-input closed-checkbox" type="checkbox" onchange="toggleClosed(this)">
                                                                        <label class="form-check-label small text-nowrap">휴무</label>
                                                                    </div>
                                                                    <div class="form-check form-switch m-0">
                                                                        <input class="form-check-input all-day-checkbox" type="checkbox" onchange="toggleAllDay(this)">
                                                                        <label class="form-check-label small text-nowrap">24시</label>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td style="width: 29%;"><input type="time" name="openTimes" class="form-control form-control-sm time-input" value="10:00" required></td>
                                                            <td style="width: 6%;">~</td>
                                                            <td style="width: 29%;"><input type="time" name="closeTimes" class="form-control form-control-sm time-input" value="23:00" required></td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="row g-3 mb-3">
                                            <div class="col-md-4">
                                                <label class="form-label small">최소 이용시간 <span class="text-danger">*</span></label>
                                                <input type="number" name="minHours" class="form-control" value="${unit.minHour}" required>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label small">취소 기준(시간) <span class="text-danger">*</span></label>
                                                <input type="number" name="cancelLimitHrs" class="form-control" value="${unit.cancelLimitHr}" required>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label small">청소 보증금 <span class="text-danger">*</span></label>
                                                <input type="number" name="cleaningFees" class="form-control" value="${unit.cleaningFee}" required>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label small">룸 썸네일 변경</label>
                                            <c:if test="${not empty unit.thumbnailUrl}">
                                                <div class="text-muted small mb-2"><i class="bi bi-card-image"></i> 현재 이미지: ${unit.thumbnailUrl}</div>
                                            </c:if>
                                            <input type="hidden" name="existThumbnailUrls" value="${unit.thumbnailUrl != null ? unit.thumbnailUrl : ''}">
                                            <input type="file" name="unitThumbnailFiles" class="form-control" accept="image/*">
                                        </div>

                                        <div>
                                            <label class="form-label small">룸 상세 설명</label>
                                            <textarea name="descriptions" class="form-control" rows="3">${unit.description}</textarea>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            
                            <c:otherwise>
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

                                    <div class="mb-4 p-3 border rounded bg-white">
                                        <label class="form-label small text-primary fw-bold mb-2"><i class="bi bi-calendar-week me-1"></i>요일별 운영 시간 <span class="text-danger">*</span></label>
                                        <table class="table table-borderless table-sm time-table mb-0 text-center align-middle">
                                            <tbody>
                                                <c:set var="daysStr" value="월,화,수,목,금,토,일"/>
                                                <c:forEach var="d" items="${daysStr.split(',')}">
                                                    <tr>
                                                        <td style="width: 12%;"><span class="badge bg-light text-dark border w-100 py-2">${d}</span></td>
                                                        <td style="width: 24%;">
                                                            <div class="d-flex justify-content-center gap-3 m-0">
                                                                <div class="form-check form-switch m-0">
                                                                    <input class="form-check-input closed-checkbox" type="checkbox" onchange="toggleClosed(this)">
                                                                    <label class="form-check-label small text-nowrap">휴무</label>
                                                                </div>
                                                                <div class="form-check form-switch m-0">
                                                                    <input class="form-check-input all-day-checkbox" type="checkbox" onchange="toggleAllDay(this)">
                                                                    <label class="form-check-label small text-nowrap">24시</label>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td style="width: 29%;"><input type="time" name="openTimes" class="form-control form-control-sm time-input" value="10:00" required></td>
                                                        <td style="width: 6%;">~</td>
                                                        <td style="width: 29%;"><input type="time" name="closeTimes" class="form-control form-control-sm time-input" value="23:00" required></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
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
                                        <input type="hidden" name="existThumbnailUrls" value="">
                                        <input type="file" name="unitThumbnailFiles" class="form-control" accept="image/*" required>
                                    </div>

                                    <div>
                                        <label class="form-label small">룸 상세 설명</label>
                                        <textarea name="descriptions" class="form-control" rows="3" placeholder="해당 룸의 특징이나 주의사항을 적어주세요."></textarea>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="host-flat-box mb-4">
                    <h5 class="fw-bold mb-4 border-bottom pb-2" style="color: var(--host-primary);">4. 공간 이미지 및 옵션</h5>
                    
                    <div class="mb-4">
                        <label class="form-label">공간 전체를 보여줄 추가 이미지 (다중 선택 가능)</label>
                        <input type="file" name="addFiles" class="form-control" multiple accept="image/*">
                        <div class="form-text">여러 장을 한 번에 드래그하여 선택할 수 있습니다.</div>
                    </div>
                    
                    <c:if test="${mode == 'update'}">
                        <div class="mb-4 p-3 bg-light rounded border">
                            <label class="form-label small fw-bold text-danger"><i class="bi bi-trash"></i> 등록된 이미지 (클릭 시 즉시 삭제됩니다)</label>
                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="vo" items="${listFile}">
                                    <div class="position-relative" style="cursor: pointer; transition: opacity 0.2s;" onclick="deleteSpaceImage('${vo.imageNo}', this)" onmouseover="this.style.opacity='0.7'" onmouseout="this.style.opacity='1'">
                                        <img src="${pageContext.request.contextPath}/dist/images/${vo.fileUrl}" class="rounded border shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                                        <div class="position-absolute top-0 end-0 bg-danger text-white rounded-circle d-flex justify-content-center align-items-center shadow" style="width: 24px; height: 24px; transform: translate(30%, -30%);">
                                            <i class="bi bi-x fw-bold"></i>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty listFile}">
                                    <span class="text-muted small">등록된 추가 이미지가 없습니다.</span>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    
                    <div>
                        <label class="form-label d-block mb-3">제공되는 편의시설 (다중 선택)</label>
                        <div class="d-flex flex-wrap gap-3">
                            <c:forEach var="opt" items="${optionList}">
                                <c:set var="isChecked" value="false" />
                                <c:if test="${mode == 'update' && not empty selectedOptions}">
                                    <c:forEach var="selOpt" items="${selectedOptions}">
                                        <c:if test="${selOpt == opt.optionNo}"><c:set var="isChecked" value="true" /></c:if>
                                     </c:forEach>
                                </c:if>
                                
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="optionNos" value="${opt.optionNo}" id="opt${opt.optionNo}" ${isChecked ? 'checked' : ''}>
                                    <label class="form-check-label" for="opt${opt.optionNo}">${opt.name}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-lg btn-host-submit w-100 fs-5 py-3 shadow-sm">
                        <i class="bi bi-check-circle me-2"></i> 공간 ${mode == 'update' ? '수정' : '등록'} 완료
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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    let unitCount = ${mode == 'update' ? listUnit.size() : 1};
    const daysArr = ['월', '화', '수', '목', '금', '토', '일'];

    function searchZipCode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("extraAddress").value = extraAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("detailAddr").focus();
            }
        }).open();
    }

    function addUnit() {
        unitCount++;
        const container = document.getElementById('unitContainer');
        
        let timeRowsHtml = '';
        daysArr.forEach(day => {
            timeRowsHtml += `
                <tr>
                    <td style="width: 12%;"><span class="badge bg-light text-dark border w-100 py-2">\${day}</span></td>
                    <td style="width: 24%;">
                        <div class="d-flex justify-content-center gap-3 m-0">
                            <div class="form-check form-switch m-0">
                                <input class="form-check-input closed-checkbox" type="checkbox" onchange="toggleClosed(this)">
                                <label class="form-check-label small text-nowrap">휴무</label>
                            </div>
                            <div class="form-check form-switch m-0">
                                <input class="form-check-input all-day-checkbox" type="checkbox" onchange="toggleAllDay(this)">
                                <label class="form-check-label small text-nowrap">24시</label>
                            </div>
                        </div>
                    </td>
                    <td style="width: 29%;"><input type="time" name="openTimes" class="form-control form-control-sm time-input" value="10:00" required></td>
                    <td style="width: 6%;">~</td>
                    <td style="width: 29%;"><input type="time" name="closeTimes" class="form-control form-control-sm time-input" value="23:00" required></td>
                </tr>
            `;
        });

        const html = `
            <div class="unit-box border rounded p-4 mb-3 position-relative mt-3" style="background-color: #fcfcfc;">
                <button type="button" class="btn btn-sm btn-outline-danger position-absolute" style="top: 15px; right: 15px;" onclick="removeUnit(this)">
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

                <div class="mb-4 p-3 border rounded bg-white">
                    <label class="form-label small text-primary fw-bold mb-2"><i class="bi bi-calendar-week me-1"></i>요일별 운영 시간 <span class="text-danger">*</span></label>
                    <table class="table table-borderless table-sm time-table mb-0 text-center align-middle">
                        <tbody>
                            \${timeRowsHtml}
                        </tbody>
                    </table>
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
                    <input type="hidden" name="existThumbnailUrls" value="">
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
    
    function removeUnit(btn) {
        Swal.fire({
            title: '룸 삭제',
            text: '이 룸을 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E53935',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
            customClass: { popup: 'rounded-4 shadow-sm' }
        }).then((result) => {
            if (result.isConfirmed) {
                btn.parentElement.remove();
            }
        });
    }

    // 휴무 버튼 토글 로직
    function toggleClosed(checkbox) {
        const row = checkbox.closest('tr');
        const timeInputs = row.querySelectorAll('.time-input');
        const allDayCheckbox = row.querySelector('.all-day-checkbox');
        
        if (checkbox.checked) {
            if(allDayCheckbox) allDayCheckbox.checked = false; 
            timeInputs[0].value = "00:00";
            timeInputs[1].value = "00:00";
            timeInputs[0].setAttribute('readonly', true);
            timeInputs[1].setAttribute('readonly', true);
            timeInputs[0].classList.add('bg-light');
            timeInputs[1].classList.add('bg-light');
        } else {
            timeInputs[0].value = "10:00";
            timeInputs[1].value = "23:00";
            timeInputs[0].removeAttribute('readonly');
            timeInputs[1].removeAttribute('readonly');
            timeInputs[0].classList.remove('bg-light');
            timeInputs[1].classList.remove('bg-light');
        }
    }

    // 24시 버튼 토글 로직
    function toggleAllDay(checkbox) {
        const row = checkbox.closest('tr');
        const timeInputs = row.querySelectorAll('.time-input');
        const closedCheckbox = row.querySelector('.closed-checkbox');
        
        if (checkbox.checked) {
            if(closedCheckbox) closedCheckbox.checked = false;
            timeInputs[0].value = "00:00";
            timeInputs[1].value = "23:59";
            timeInputs[0].setAttribute('readonly', true);
            timeInputs[1].setAttribute('readonly', true);
            timeInputs[0].classList.add('bg-light');
            timeInputs[1].classList.add('bg-light');
        } else {
            timeInputs[0].value = "10:00";
            timeInputs[1].value = "23:00";
            timeInputs[0].removeAttribute('readonly');
            timeInputs[1].removeAttribute('readonly');
            timeInputs[0].classList.remove('bg-light');
            timeInputs[1].classList.remove('bg-light');
        }
    }

    function confirmSpaceDelete() {
        Swal.fire({
            title: '공간 삭제',
            html: '정말 이 공간을 삭제하시겠습니까?<br><span style="font-size:0.9em; color:#E53935;">관련된 모든 룸과 이미지도 함께 삭제되며 복구할 수 없습니다.</span>',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E53935',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '네, 삭제합니다',
            cancelButtonText: '취소',
            customClass: { popup: 'rounded-4 shadow-sm' }
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('deleteSpaceForm').submit();
            }
        });
    }

    function deleteSpaceImage(imageNo, el) {
        Swal.fire({
            title: '이미지 삭제',
            html: '이 이미지를 삭제하시겠습니까?<br><span style="font-size:0.9em; color:#666;">(수정 완료 버튼을 눌러야 최종 반영됩니다)</span>',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
            customClass: { popup: 'rounded-4 shadow-sm' }
        }).then((result) => {
            if (result.isConfirmed) {
                const form = document.getElementById('updateSpaceForm');
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'deleteImageNos';
                hiddenInput.value = imageNo;
                
                form.appendChild(hiddenInput);
                el.style.display = 'none'; 
            }
        });
    }

    <c:if test="${not empty message}">
        Swal.fire({
            icon: 'info',
            title: '알림',
            text: '${message}',
            confirmButtonColor: '#E53935',
            customClass: { popup: 'rounded-4 shadow-sm' }
        });
    </c:if>
</script>

</body>
</html>