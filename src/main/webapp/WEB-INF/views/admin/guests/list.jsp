<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - 게스트 관리</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">게스트 회원 관리</h3>
                    <p class="mb-0 text-muted">일반 유저 목록을 조회하고 관리합니다.</p>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-info me-2" onclick="givePointsBulk()">
                        <i class="bi bi-coin me-1"></i>포인트 일괄지급
                    </button>
                    <button id="btn-excel-guest" class="btn btn-purple"><i class="bi bi-download me-2"></i>엑셀 다운로드</button>
                </div>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <form name="searchForm" class="d-flex gap-2" action="${pageContext.request.contextPath}/admin/guests/list" method="get">
                        <input type="hidden" name="page" value="1">
                        <select name="schType" class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                            <option value="login_id" ${schType == 'login_id' ? 'selected' : ''}>아이디</option>
                            <option value="name" ${schType == 'name' ? 'selected' : ''}>이름</option>
                            <option value="email" ${schType == 'email' ? 'selected' : ''}>이메일</option>
                            <option value="member_id" ${schType == 'member_id' ? 'selected' : ''}>회원번호</option>
                        </select>
                        <div class="input-group" style="width: 250px;">
                            <input type="text" name="kwd" value="${kwd}" class="form-control bg-transparent text-main border-secondary">
                            <button class="btn btn-outline-secondary" type="submit" onclick="searchList()"><i class="bi bi-search"></i></button>
                        </div>
                    </form>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>명</div>
                </div>

                <div class="table-responsive">
                    <table id="guest-table" class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th text-center" style="width: 40px;">
                                    <input type="checkbox" id="chkAll" class="form-check-input bg-transparent border-secondary">
                                </th>
                                <th class="admin-th">회원번호</th>
                                <th class="admin-th">아이디</th>
                                <th class="admin-th">이름</th>
                                <th class="admin-th">이메일</th>
                                <th class="admin-th">연락처</th>
                                <th class="admin-th text-center">가입일</th>
                                <th class="admin-th text-center">등급</th>
                                <th class="admin-th text-center">포인트</th>
                                <th class="admin-th text-center">상태</th>
                                <th class="admin-th text-end">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="admin-td text-center">
                                        <input type="checkbox" name="mids" value="${dto.member_id}" class="form-check-input bg-transparent border-secondary">
                                    </td>
                                    <td class="admin-td txt-muted">#${dto.member_id}</td>
                                    <td class="admin-td fw-bold">${dto.login_id}</td>
                                    <td class="admin-td">${dto.name}</td>
                                    <td class="admin-td text-muted">${dto.email}</td>
                                    <td class="admin-td text-muted">${dto.phone}</td>
                                    <td class="admin-td text-center text-muted small-txt">${dto.created_at.toString().substring(0, 10)}</td>
                                    <td class="admin-td text-center">
                                        <c:choose>
                                            <c:when test="${dto.grade == 'GOLD'}"><span class="grade-badge grade-gold">GOLD</span></c:when>
                                            <c:when test="${dto.grade == 'SILVER'}"><span class="grade-badge grade-silver">SILVER</span></c:when>
                                            <c:otherwise><span class="grade-badge grade-bronze">BRONZE</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td text-center fw-bold text-info"><fmt:formatNumber value="${dto.point}" pattern="#,###"/> P</td>
                                    <td class="admin-td text-center">
                                        ${dto.enabled == 1 ? '<span class="status-normal">정상</span>' : '<span class="status-banned">정지</span>'}
                                    </td>
                                    <td class="admin-td text-end">
                                        <button class="btn btn-sm btn-outline-secondary" onclick="viewProfile('${dto.member_id}')">상세</button>
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

function viewProfile(memberId) {
    const f = document.searchForm;
    const page = f.page.value || "1";
    const url = "${pageContext.request.contextPath}/admin/guests/profile?member_id=" + memberId + "&page=" + page;
    location.href = url;
}

document.getElementById("chkAll").addEventListener("change", function() {
    const chks = document.querySelectorAll('input[name="mids"]');
    chks.forEach(chk => chk.checked = this.checked);
});

function givePointsBulk() {
    const chks = document.querySelectorAll('input[name="mids"]:checked');
    if(chks.length === 0) {
        alert("포인트를 지급할 게스트를 선택해주세요.");
        return;
    }
    
    const point = prompt("선택한 인원에게 일괄 지급할 포인트를 입력하세요.\n(차감 시 숫자 앞에 - 입력)");
    if(!point || isNaN(point)) return;

    const memberIds = Array.from(chks).map(chk => chk.value);
    const params = new URLSearchParams();
    
    memberIds.forEach(id => params.append('memberIds[]', id));
    params.append('point', point);

    fetch('${pageContext.request.contextPath}/admin/guests/updatePoint', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(response => {
        if(response.ok) {
            alert("포인트가 성공적으로 지급되었습니다.");
            location.reload();
        } else {
            alert("포인트 지급 실패");
        }
    });
}

document.getElementById('btn-excel-guest').addEventListener('click', function() {
    const table = document.getElementById('guest-table');
    const cloneTable = table.cloneNode(true);

    const thsFirst = cloneTable.querySelectorAll('th:first-child');
    thsFirst.forEach(th => th.remove());
    const tdsFirst = cloneTable.querySelectorAll('td:first-child');
    tdsFirst.forEach(td => td.remove());

    const thsLast = cloneTable.querySelectorAll('th:last-child');
    thsLast.forEach(th => th.remove());
    const tdsLast = cloneTable.querySelectorAll('td:last-child');
    tdsLast.forEach(td => td.remove());

    const wb = XLSX.utils.table_to_book(cloneTable, {sheet: "게스트목록"});
    
    const today = new Date();
    const dateString = today.getFullYear() + ('0' + (today.getMonth() + 1)).slice(-2) + ('0' + today.getDate()).slice(-2);
    const fileName = '게스트_전체_목록_' + dateString + '.xlsx';
    
    XLSX.writeFile(wb, fileName);
});
</script>
</body>
</html>