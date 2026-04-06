<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>매장 관리 - 공대생 호스트 센터</title>
    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/store.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">
    <div class="mb-4">
        <h3 class="fw-bold">매장 관리</h3>
        <p class="text-muted">등록된 공간을 관리하고 수정하세요.</p>
    </div>

    <div class="row g-4">
        <c:if test="${empty list}">
            <div class="col-12 text-center p-5 text-muted border rounded bg-light mt-4">
                <i class="bi bi-shop fs-1 d-block mb-3"></i>
                <h5>등록된 매장이 없습니다.</h5>
                <p>새로운 공간을 등록하고 호스팅을 시작해보세요!</p>
                <a href="<c:url value='/host/space/write'/>" class="btn btn-primary mt-2">공간 등록하기</a>
            </div>
        </c:if>

        <c:forEach var="dto" items="${list}">
            <div class="col-md-4">
                <div class="store-card">
                    <c:choose>
                        <c:when test="${not empty dto.fileUrl}">
                            <img src="${pageContext.request.contextPath}/uploads/space/${dto.fileUrl}" class="store-img" style="object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/400x200?text=No+Image" class="store-img">
                        </c:otherwise>
                    </c:choose>

                    <div class="store-body">
                        <h5 class="store-title">${dto.spaceName}</h5>
                        <p class="store-desc text-truncate">
                            ${not empty dto.spaceIntro ? dto.spaceIntro : '등록된 공간 소개글이 없습니다.'}
                        </p>

                        <div class="store-info">
                            <span><i class="bi bi-geo-alt"></i> ${dto.region}</span>
                            <span><i class="bi bi-people"></i> 최대 ${dto.maxCapacity}명</span>
                        </div>

                        <div class="store-actions mt-3 d-flex gap-2">
                            <button type="button" class="btn btn-sm btn-edit" 
                                    onclick="location.href='<c:url value="/host/space/update?spaceNo=${dto.spaceNo}"/>'">수정</button>
                            
                            <form id="premiumForm_${dto.spaceNo}" action="<c:url value='/host/premium/toggle'/>" method="post" class="m-0">
                                <input type="hidden" name="spaceNo" value="${dto.spaceNo}">
                                <input type="hidden" name="currentPremium" value="${empty dto.isPremium ? 'N' : dto.isPremium}">
                                
                                <c:choose>
                                    <c:when test="${dto.isPremium == 'Y'}">
                                        <button type="button" class="btn btn-sm btn-success fw-bold" 
                                                onclick="togglePremium('revoke', 'premiumForm_${dto.spaceNo}')">
                                            <i class="bi bi-star-fill text-warning"></i> 프리미엄 적용중
                                        </button>
                                    </c:when>
                                    <c:when test="${dto.isPremium == 'P'}">
                                        <button type="button" class="btn btn-sm btn-secondary fw-bold" 
                                                onclick="togglePremium('cancel_req', 'premiumForm_${dto.spaceNo}')">
                                            <i class="bi bi-hourglass-split"></i> 승인 대기중
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn btn-sm btn-outline-warning text-dark fw-bold" 
                                                onclick="togglePremium('apply', 'premiumForm_${dto.spaceNo}')">
                                            <i class="bi bi-star"></i> 프리미엄 신청
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </form>

                            <form id="deleteForm_${dto.spaceNo}" action="<c:url value='/host/space/delete'/>" method="post" class="m-0 ms-auto">
                                <input type="hidden" name="spaceNo" value="${dto.spaceNo}">
                                <button type="button" class="btn btn-sm btn-delete" onclick="confirmDelete('deleteForm_${dto.spaceNo}')">삭제</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div> 
    
    <div class="d-flex justify-content-center mt-5">
        ${paging}
    </div>

    <form name="searchForm" action="<c:url value='/host/menu/store'/>" method="get">
        <input type="hidden" name="page" value="1">
    </form>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>
<jsp:include page="/WEB-INF/views/host/layout/chatWidget.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function searchStore(page) {
        const form = document.searchForm;
        form.page.value = page;
        form.submit();
    }

    function togglePremium(actionType, formId) {
        let titleText = '';
        let bodyHtml = '';
        let btnText = '';
        let btnColor = '';

        if (actionType === 'apply') {
            titleText = '프리미엄 신청';
            bodyHtml = '이 공간을 프리미엄으로 신청하시겠습니까?<br><span style="font-size:0.9em; color:#666;">(관리자 심사 완료 후 적용됩니다)</span>';
            btnText = '신청하기';
            btnColor = '#f59e0b';
        } else if (actionType === 'cancel_req') {
            titleText = '심사 취소';
            bodyHtml = '진행 중인 프리미엄 심사를 취소하시겠습니까?';
            btnText = '취소하기';
            btnColor = '#6c757d';
        } else if (actionType === 'revoke') {
            titleText = '프리미엄 해지';
            bodyHtml = '프리미엄 적용을 해지하시겠습니까?<br><span style="font-size:0.9em; color:#E53935;">(일반 수수료율로 즉시 복귀됩니다)</span>';
            btnText = '해지하기';
            btnColor = '#dc3545';
        }

        Swal.fire({
            title: titleText,
            html: bodyHtml,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: btnColor,
            cancelButtonColor: '#e0e0e0',
            confirmButtonText: btnText,
            cancelButtonText: '<span style="color:#333;">닫기</span>',
            customClass: { popup: 'rounded-4 shadow-sm' }
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(formId).submit();
            }
        });
    }

    function confirmDelete(formId) {
        Swal.fire({
            title: '매장 삭제',
            html: '정말 이 공간을 삭제하시겠습니까?<br><span style="font-size:0.9em; color:#E53935;">이 작업은 되돌릴 수 없습니다.</span>',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E53935',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '네, 삭제합니다',
            cancelButtonText: '취소',
            customClass: { popup: 'rounded-4 shadow-sm' }
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(formId).submit();
            }
        });
    }

    <c:if test="${not empty message}">
        const msg = "${message}";
        const isError = msg.includes("실패") || msg.includes("오류");

        Swal.fire({
            icon: isError ? 'error' : 'success',
            title: isError ? '처리 실패' : '처리 완료',
            text: msg,
            confirmButtonColor: '#E53935',
            customClass: { popup: 'rounded-4 shadow-sm' }
        });
    </c:if>
</script>

</body>
</html>