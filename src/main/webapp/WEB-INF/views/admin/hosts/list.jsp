<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - 호스트 관리</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">호스트 파트너 관리</h3>
                    <p class="mb-0 text-muted">파티룸 공간을 제공하는 사업자(호스트) 승인 및 목록을 관리합니다.</p>
                </div>
                <button id="btn-excel-host" class="btn-purple"><i class="bi bi-download me-2"></i>엑셀 다운로드</button>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <form name="searchForm" action="${pageContext.request.contextPath}/admin/hosts/list" method="get" class="d-flex gap-2">
                        <select name="enabled" class="form-select" style="width: 140px;" onchange="this.form.submit();">
                            <option value="" ${enabled == '' ? 'selected' : ''}>전체 상태</option>
                            <option value="0" ${enabled == '0' ? 'selected' : ''} style="color: #F59E0B;">잠금 (정지)</option>
                            <option value="1" ${enabled == '1' ? 'selected' : ''}>정상 (활성)</option>
                        </select>
                        <select name="schType" class="form-select" style="width: 130px;">
                            <option value="login_id" ${schType == 'login_id' ? 'selected' : ''}>아이디</option>
                            <option value="nickname" ${schType == 'nickname' ? 'selected' : ''}>상호명</option>
                            <option value="name" ${schType == 'name' ? 'selected' : ''}>대표자명</option>
                        </select>
                        <div class="input-group" style="width: 250px;">
                            <input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
                            <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
                        </div>
                    </form>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>명의 호스트</div>
                </div>

                <div class="table-responsive">
                    <table id="host-table" class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th">파트너번호</th>
                                <th class="admin-th">아이디</th>
                                <th class="admin-th">상호명 (법인명)</th>
                                <th class="admin-th">대표자</th>
                                <th class="admin-th">연락처</th>
                                <th class="admin-th text-center">상태</th>
                                <th class="admin-th text-end">상세</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td class="admin-td text-muted">#H-${dto.member_id}</td>
                                    <td class="admin-td">${dto.login_id}</td>
                                    <td class="admin-td">
                                        <c:choose>
                                            <c:when test="${not empty dto.nickname}"><span class="fw-bold">${dto.nickname}</span></c:when>
                                            <c:otherwise><span class="fw-bold">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td">${dto.name}</td>
                                    <td class="admin-td">${dto.phone}</td>
                                    <td class="admin-td text-center">
                                        <c:choose>
                                            <c:when test="${dto.enabled == 1}"><span class="status-normal">정상</span></c:when>
                                            <c:otherwise><span class="status-banned">잠금 (정지)</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td text-end">
                                        <button class="btn btn-sm btn-outline-secondary" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/hosts/profile?member_id=${dto.member_id}&page=${page}';">상세</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="7" class="admin-td text-center py-5">
                                        <i class="bi bi-info-circle me-2"></i>등록된 호스트 파트너가 없습니다.
                                    </td>
                                </tr>
                            </c:if>
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
document.getElementById('btn-excel-host').addEventListener('click', function() {
    const table = document.getElementById('host-table');
    const wb = XLSX.utils.table_to_book(table, {sheet: "호스트목록"});
    XLSX.writeFile(wb, "공대생_호스트_파트너_목록.xlsx");
});
</script>
</body>
</html>