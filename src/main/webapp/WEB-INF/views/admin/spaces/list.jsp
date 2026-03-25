<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - 매장 전체 목록</title>
</head>
<body class="admin-page">
<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">매장 전체 관리</h3>
                    <p class="mb-0 text-muted">플랫폼에 등록된 전체 공간을 조회합니다.</p>
                </div>
                <button id="btn-export-excel" class="btn btn-purple"><i class="bi bi-download me-2"></i>엑셀 다운로드</button>
            </div>
            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <form name="searchForm" action="${pageContext.request.contextPath}/admin/spaces/list" method="get" class="d-flex gap-2">
                        <input type="hidden" name="page" value="1">
                        <select name="status" class="form-select bg-transparent text-main border-secondary" style="width: 140px;" onchange="searchList()">
                            <option value="" ${status == '' ? 'selected' : ''}>전체 상태</option>
                            <option value="ACTIVE" ${status == 'ACTIVE' ? 'selected' : ''}>정상 승인</option>
                            <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''} style="color: #F59E0B;">심사/대기</option>
                            <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''} style="color: #EF4444;">판매 정지</option>
                            <option value="DELETED" ${status == 'DELETED' ? 'selected' : ''} style="color: #6B7280;">삭제됨</option>
                        </select>
                        <select name="isPremium" class="form-select bg-transparent text-main border-secondary" style="width: 150px;" onchange="searchList()">
                            <option value="" ${isPremium == '' ? 'selected' : ''}>프리미엄 전체</option>
                            <option value="Y" ${isPremium == 'Y' ? 'selected' : ''} style="color: #F59E0B;">★ 프리미엄</option>
                            <option value="N" ${isPremium == 'N' ? 'selected' : ''}>일반 매장</option>
                        </select>
                        <select name="schType" class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                            <option value="spaceName" ${schType == 'spaceName' ? 'selected' : ''}>공간명</option>
                            <option value="hostId" ${schType == 'hostId' ? 'selected' : ''}>호스트 ID</option>
                        </select>
                        <div class="input-group" style="width: 250px;">
                            <input type="text" name="kwd" value="${kwd}" class="form-control bg-transparent text-main border-secondary">
                            <button class="btn btn-outline-secondary" type="submit" onclick="searchList()"><i class="bi bi-search"></i></button>
                        </div>
                    </form>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>개</div>
                </div>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th text-center">공간번호</th>
                                <th class="admin-th">분류</th>
                                <th class="admin-th">공간명</th>
                                <th class="admin-th">호스트</th>
                                <th class="admin-th text-center">등록일</th>
                                <th class="admin-th text-center">상태</th>
                                <th class="admin-th text-end">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="7" class="admin-td text-center py-5 text-muted">내역이 없습니다.</td>
                                </tr>
                            </c:if>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="admin-td text-center text-muted">#S-${dto.spaceNo}</td>
                                    <td class="admin-td"><span class="badge bg-secondary bg-opacity-25 text-muted">${dto.categoryName}</span></td>
                                    <td class="admin-td fw-bold text-truncate" style="max-width: 250px;">
                                        <c:choose>
                                            <c:when test="${dto.isPremium == 'Y'}">
                                                <i class="bi bi-star-fill text-warning me-1"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star text-muted me-1"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        ${dto.spaceName}
                                    </td>
                                    <td class="admin-td">${dto.hostName} <small class="text-muted">(${dto.hostLoginId})</small></td>
                                    <td class="admin-td text-center text-muted small-txt">${dto.createdAt}</td>
                                    <td class="admin-td text-center">
                                        <select class="form-select form-select-sm bg-transparent border-secondary text-center" 
                                                style="width: 110px; display: inline-block; color: ${dto.status == 'ACTIVE' ? '#34D399' : (dto.status == 'PENDING' ? '#F59E0B' : (dto.status == 'DELETED' ? '#6B7280' : '#F87171'))} !important;"
                                                onchange="changeSpaceStatus(${dto.spaceNo}, this.value)">
                                            <option value="PENDING" ${dto.status == 'PENDING' ? 'selected' : ''}>대기중</option>
                                            <option value="ACTIVE" ${dto.status == 'ACTIVE' ? 'selected' : ''}>정상</option>
                                            <option value="REJECTED" ${dto.status == 'REJECTED' ? 'selected' : ''}>정지</option>
                                            <option value="DELETED" ${dto.status == 'DELETED' ? 'selected' : ''}>삭제</option>
                                        </select>
                                    </td>
                                    <td class="admin-td text-end">
                                        <button class="btn btn-sm btn-outline-secondary" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/spaces/detail/${dto.spaceNo}?page=${page}&from=list';">상세</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center mt-4">
                    <nav aria-label="Page navigation">
                        <div class="admin-pagination">${paging}</div>
                    </nav>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
<script type="text/javascript">
function searchList() {
    const f = document.searchForm;
    f.page.value = "1";
    f.submit();
}
document.addEventListener('DOMContentLoaded', () => {
    const inputEL = document.querySelector('form[name=searchForm] input[name=kwd]');
    inputEL.addEventListener('keydown', ev => {
        if(ev.key === 'Enter') {
            ev.preventDefault();
            searchList();
        }
    });

    document.getElementById('btn-export-excel').addEventListener('click', function() {
        var table = document.querySelector('.table');
        var cloneTable = table.cloneNode(true);

        var ths = cloneTable.querySelectorAll('th:last-child');
        ths.forEach(th => th.remove());
        var tds = cloneTable.querySelectorAll('td:last-child');
        tds.forEach(td => td.remove());

        var selects = table.querySelectorAll('select');
        var clonedSelects = cloneTable.querySelectorAll('select');
        for(var i=0; i<selects.length; i++) {
            if(selects[i].closest('.table')) {
                var selectedText = selects[i].options[selects[i].selectedIndex].text;
                var textNode = document.createTextNode(selectedText);
                clonedSelects[i].parentNode.replaceChild(textNode, clonedSelects[i]);
            }
        }

        var wb = XLSX.utils.table_to_book(cloneTable, {sheet: "매장목록"});
        var today = new Date();
        var dateString = today.getFullYear() + ('0' + (today.getMonth() + 1)).slice(-2) + ('0' + today.getDate()).slice(-2);
        var fileName = '매장_전체_목록_' + dateString + '.xlsx';

        XLSX.writeFile(wb, fileName);
    });
});

function changeSpaceStatus(spaceNo, newStatus) {
    if(!confirm("상태를 변경하시겠습니까?")) {
        location.reload();
        return;
    }
    fetch('${pageContext.request.contextPath}/admin/spaces/updateStatus', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ spaceNo: spaceNo, status: newStatus })
    })
    .then(response => {
        if(response.ok) {
            location.reload();
        } else {
            alert("실패");
        }
    });
}
</script>
</body>
</html>