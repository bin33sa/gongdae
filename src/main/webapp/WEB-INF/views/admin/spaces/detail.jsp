<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <c:choose>
        <c:when test="${from == 'approval'}">
            <title>공대생 Admin - 결재 및 심사</title>
        </c:when>
        <c:when test="${from == 'premium'}">
            <title>공대생 Admin - 프리미엄 관리</title>
        </c:when>
        <c:otherwise>
            <title>공대생 Admin - 공간 상세 정보</title>
        </c:otherwise>
    </c:choose>
</head>
<body class="admin-page">
<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content flex-grow-1 p-4" style="width: 0;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-2">
                        <c:choose>
                            <c:when test="${from == 'approval'}">통합 결재 및 심사</c:when>
                            <c:when test="${from == 'premium'}">프리미엄 관리</c:when>
                            <c:otherwise>공간 상세 내역</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="mb-0 text-muted">
                        <c:choose>
                            <c:when test="${from == 'approval'}">공간 운영 또는 프리미엄 등록에 대한 결재를 진행해 주세요.</c:when>
                            <c:when test="${from == 'premium'}">결제 내역 및 공간 품질 확인 후 프리미엄을 통제합니다.</c:when>
                            <c:otherwise>공간의 전체적인 등록 현황 및 정보를 조회합니다.</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/spaces/${from}?page=${page}';">
                        <i class="bi bi-list me-1"></i> 목록으로
                    </button>
                </div>
            </div>
            
            <c:if test="${from == 'approval'}">
                <c:if test="${dto.status == 'PENDING'}">
                    <div class="d-flex justify-content-between align-items-center mb-4 p-4 rounded" style="background-color: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.3);">
                        <div>
                            <h5 class="fw-bold mb-1" style="color: #F59E0B;"><i class="bi bi-exclamation-triangle-fill me-2"></i>신규 등록 심사</h5>
                            <p class="mb-0 text-muted">정보를 꼼꼼히 확인 후 승인 또는 반려를 선택해 주세요.</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-danger px-4" onclick="executeStatus('REJECTED')">반려 처리</button>
                            <button class="btn btn-success px-4" onclick="executeStatus('ACTIVE')" style="background-color: #10B981; border-color: #10B981;">최종 승인</button>
                        </div>
                    </div>
                </c:if>
                <c:if test="${dto.status != 'PENDING'}">
                    <div class="d-flex justify-content-between align-items-center mb-4 p-4 rounded" style="background-color: rgba(59, 130, 246, 0.1); border: 1px solid rgba(59, 130, 246, 0.3);">
                        <div>
                            <h5 class="fw-bold mb-1" style="color: #3B82F6;"><i class="bi bi-star-fill me-2"></i>프리미엄 결재 대기</h5>
                            <p class="mb-0 text-muted">호스트의 프리미엄 등록 신청을 승인하거나 반려합니다.</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-secondary px-4" onclick="executePremium('cancelPremium')">반려 처리</button>
                            <button class="btn btn-primary px-4" onclick="executePremium('approvePremium')">프리미엄 승인</button>
                        </div>
                    </div>
                </c:if>
            </c:if>

            <c:if test="${from == 'premium'}">
                <div class="d-flex justify-content-between align-items-center mb-4 p-4 rounded" style="background-color: rgba(139, 92, 246, 0.1); border: 1px solid rgba(139, 92, 246, 0.3);">
                    <div>
                        <h5 class="fw-bold mb-1" style="color: #8B5CF6;"><i class="bi bi-gear-fill me-2"></i>프리미엄 컨트롤 패널</h5>
                        <p class="mb-0 text-muted">해당 공간에 대한 프리미엄 혜택을 강제로 승인하거나 박탈할 수 있습니다.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary px-4" onclick="executePremium('cancelPremium')">해제 / 박탈</button>
                        <button class="btn btn-primary px-4" style="background-color: #8B5CF6; border-color: #8B5CF6;" onclick="executePremium('approvePremium')">재승인</button>
                    </div>
                </div>
            </c:if>

            <div class="dashboard-box mb-4">
                <div class="d-flex justify-content-between align-items-center border-bottom border-secondary border-opacity-25 pb-3 mb-4">
                    <h5 class="fw-bold text-main m-0"><i class="bi bi-shop me-2 text-info"></i> ${dto.spaceName}</h5>
                    <div>
                        <c:choose>
                            <c:when test="${dto.status == 'ACTIVE'}"><span class="badge bg-success">정상 운영</span></c:when>
                            <c:when test="${dto.status == 'PENDING'}"><span class="badge bg-warning text-dark">심사 대기중</span></c:when>
                            <c:when test="${dto.status == 'DELETED'}"><span class="badge bg-secondary">삭제됨</span></c:when>
                            <c:otherwise><span class="badge bg-danger">판매 정지</span></c:otherwise>
                        </c:choose>
                        <c:if test="${dto.isPremium == 'Y'}">
                            <span class="badge bg-warning text-dark ms-2"><i class="bi bi-star-fill me-1"></i>프리미엄</span>
                        </c:if>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <tr>
                            <th class="admin-th" style="width: 15%;">공간 번호</th>
                            <td class="admin-td text-muted" style="width: 35%;">#S-${dto.spaceNo}</td>
                            <th class="admin-th" style="width: 15%;">분류</th>
                            <td class="admin-td" style="width: 35%;"><span class="badge bg-secondary bg-opacity-25 text-muted">${dto.categoryName}</span></td>
                        </tr>
                        <tr>
                            <th class="admin-th">호스트 정보</th>
                            <td class="admin-td fw-bold">${dto.hostName} <span class="text-muted fw-normal">(${dto.hostLoginId})</span></td>
                            <th class="admin-th">연락처</th>
                            <td class="admin-td text-muted">${dto.hostPhone} / ${dto.hostEmail}</td>
                        </tr>
                        <tr>
                            <th class="admin-th">사업자 번호</th>
                            <td class="admin-td text-warning fw-bold">${dto.bizRegNum}</td>
                            <th class="admin-th">정산 계좌</th>
                            <td class="admin-td text-info">${dto.bankName} ${dto.accountNo} (${dto.accountHolder})</td>
                        </tr>
                        <tr>
                            <th class="admin-th border-0">주소</th>
                            <td class="admin-td border-0 text-muted">[${dto.region}] ${dto.address} ${dto.detailAddr}</td>
                            <th class="admin-th border-0">등록일시</th>
                            <td class="admin-td border-0">${dto.createdAt}</td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row g-4 mb-4">
                <div class="col-lg-6">
                    <div class="dashboard-box h-100">
                        <h5 class="fw-bold text-main mb-4"><i class="bi bi-file-earmark-text me-2"></i> 정책</h5>
                        <ul class="list-group list-group-flush bg-transparent">
                            <li class="list-group-item bg-transparent text-main border-secondary border-opacity-25 d-flex justify-content-between px-0">
                                <span class="text-muted">최소 대여</span><strong>${dto.minHours} 시간</strong>
                            </li>
                            <li class="list-group-item bg-transparent text-main border-secondary border-opacity-25 d-flex justify-content-between px-0">
                                <span class="text-muted">취소 기준</span><strong>${dto.cancelLimitHr}시간 전</strong>
                            </li>
                            <li class="list-group-item bg-transparent text-main border-secondary border-opacity-25 border-bottom-0 d-flex justify-content-between px-0 pb-0">
                                <span class="text-muted">청소 보증금</span><strong class="text-info"><fmt:formatNumber value="${dto.cleaningFee}" pattern="#,###"/> 원</strong>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="dashboard-box h-100">
                        <h5 class="fw-bold text-main mb-4"><i class="bi bi-door-open me-2"></i> 세부 유닛</h5>
                        <div class="table-responsive" style="max-height: 200px; overflow-y: auto;">
                            <table class="table text-main mb-0 align-middle table-sm">
                                <thead>
                                    <tr>
                                        <th class="text-muted fw-normal pb-2 border-secondary">이름</th>
                                        <th class="text-muted fw-normal pb-2 border-secondary text-center">인원</th>
                                        <th class="text-muted fw-normal pb-2 border-secondary text-end">가격</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="unit" items="${unitList}">
                                        <tr>
                                            <td class="border-secondary border-opacity-25 py-2">${unit.unitTitle}</td>
                                            <td class="border-secondary border-opacity-25 py-2 text-center text-muted">최대 ${unit.unitCapacity}인</td>
                                            <td class="border-secondary border-opacity-25 py-2 text-end fw-bold"><fmt:formatNumber value="${unit.unitPrice}" pattern="#,###"/>원</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="dashboard-box">
                <h5 class="fw-bold text-main mb-4"><i class="bi bi-images me-2"></i> 이미지</h5>
                <div class="d-flex flex-wrap gap-3">
                    <c:forEach var="img" items="${imageList}">
                        <div class="border border-secondary border-opacity-50 rounded overflow-hidden" style="width: 200px; height: 150px; background: rgba(0,0,0,0.2);">
                            <img src="${pageContext.request.contextPath}/uploads/space/${img.imageUrl}" style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                    </c:forEach>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
<script>
function executeStatus(status) {
    if(!confirm("해당 처리를 진행하시겠습니까?")) return;
    fetch('${pageContext.request.contextPath}/admin/spaces/updateStatus', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ spaceNo: ${dto.spaceNo}, status: status })
    }).then(res => {
        if(res.ok) location.href = '${pageContext.request.contextPath}/admin/spaces/${from}';
        else alert('실패');
    });
}
function executePremium(action) {
    if(!confirm("해당 처리를 진행하시겠습니까?")) return;
    fetch('${pageContext.request.contextPath}/admin/spaces/' + action, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ spaceNo: ${dto.spaceNo} })
    }).then(res => {
        if(res.ok) location.href = '${pageContext.request.contextPath}/admin/spaces/${from}';
        else alert('실패');
    });
}
</script>
</body>
</html>