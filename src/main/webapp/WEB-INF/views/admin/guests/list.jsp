<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 게스트 관리</title>
</head>
<body class="admin-page">

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">게스트 회원 관리</h3>
                    <p class="mb-0 text-muted">일반 유저 목록을 조회하고 관리합니다.</p>
                </div>
                <button class="btn btn-purple"><i class="bi bi-download me-2"></i>엑셀 다운로드</button>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex gap-2">
                        <form name="searchForm" action="${pageContext.request.contextPath}/admin/guests/list" method="get" class="d-flex gap-2">
                            
                            <input type="hidden" name="page" value="1">
                            
                            <select name="enabled" class="form-select bg-transparent text-main border-secondary" style="width: 130px;" onchange="searchList()">
                                <option value="" ${enabled == '' ? 'selected' : ''}>전체 상태</option>
                                <option value="1" ${enabled == '1' ? 'selected' : ''}>정상 이용</option>
                                <option value="0" ${enabled == '0' ? 'selected' : ''}>이용 정지</option>
                            </select>
                            
                            <select name="schType" class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                                <option value="login_id" ${schType == 'login_id' ? 'selected' : ''}>아이디</option>
                                <option value="member_id" ${schType == 'member_id' ? 'selected' : ''}>회원번호</option>
                            </select>

                            <div class="input-group" style="width: 250px;">
                                <input type="text" name="kwd" value="${kwd}" class="form-control bg-transparent text-main border-secondary" placeholder="검색어 입력">
                                <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
                            </div>
                        </form>
                    </div>
                    <div class="text-muted small">총 <strong class="text-main">${dataCount}</strong>명의 게스트</div>
                </div>

                <div class="table-responsive">
				    <table class="table text-main mb-0 align-middle">
				        <thead>
				            <tr class="text-muted">
				                <th class="fw-normal border-bottom border-secondary pb-3">회원번호</th>
				                <th class="fw-normal border-bottom border-secondary pb-3">닉네임</th>
				                <th class="fw-normal border-bottom border-secondary pb-3">아이디</th>
				                <th class="fw-normal border-bottom border-secondary pb-3 text-center">포인트</th>
				                <th class="fw-normal border-bottom border-secondary pb-3 text-center">등급</th> <th class="fw-normal border-bottom border-secondary pb-3 text-center">마지막 로그인</th>
				                <th class="fw-normal border-bottom border-secondary pb-3 text-center">가입일</th>
				                <th class="fw-normal border-bottom border-secondary pb-3 text-center">상태</th>
				                <th class="fw-normal border-bottom border-secondary pb-3" style="text-align: right; padding-right: 28px;">관리</th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:if test="${empty list}">
				                <tr>
				                    <td colspan="9" class="text-center py-5 text-muted">등록된 회원이 없습니다.</td> </tr>
				            </c:if>
				            <c:forEach var="dto" items="${list}">
				                <tr>
				                    <td class="py-3 border-bottom border-secondary text-muted">#${dto.member_id}</td>
				                    <td class="py-3 border-bottom border-secondary fw-bold text-info">${dto.nickname != null ? dto.nickname : '-'}</td>
				                    <td class="py-3 border-bottom border-secondary">${dto.login_id}</td>
				                    <td class="py-3 border-bottom border-secondary text-center fw-bold">
				                        <fmt:formatNumber value="${dto.point}" pattern="#,###"/> P
				                    </td>
				                    <td class="py-3 border-bottom border-secondary text-center">
									    <c:choose>
									        <c:when test="${dto.grade == 'GOLD'}">
									            <span class="grade-badge grade-gold">GOLD</span>
									        </c:when>
									        <c:when test="${dto.grade == 'SILVER'}">
									            <span class="grade-badge grade-silver">SILVER</span>
									        </c:when>
									        <c:when test="${dto.grade == 'BRONZE'}">
									            <span class="grade-badge grade-bronze">BRONZE</span>
									        </c:when>
									        <c:otherwise>
									            <span class="badge bg-light bg-opacity-10 text-main border border-secondary border-opacity-25 px-2 py-1">
									                ${dto.grade != null ? dto.grade : 'BRONZE'}
									            </span>
									        </c:otherwise>
									    </c:choose>
									</td>
				                    <td class="py-3 border-bottom border-secondary text-center small">${dto.last_login != null ? dto.last_login : '-'}</td>
				                    <td class="py-3 border-bottom border-secondary text-center text-muted small">${dto.created_at}</td>
				                    <td class="py-3 border-bottom border-secondary text-center">
				                        <c:choose>
				                            <c:when test="${dto.enabled == 1}">
				                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">정상</span>
				                            </c:when>
				                            <c:otherwise>
				                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">정지</span>
				                            </c:otherwise>
				                        </c:choose>
				                    </td>
				                    <td class="py-3 border-bottom border-secondary text-end">
				                        <button class="btn btn-sm btn-outline-secondary" onclick="viewProfile('${dto.member_id}')">상세</button>
				                    </td>
				                </tr>
				            </c:forEach>
				        </tbody>
				    </table>
				</div>
                
                <div class="d-flex justify-content-center mt-4 pt-3 border-top border-secondary border-opacity-25">
				    <nav aria-label="Page navigation">
				        <div class="admin-pagination">
				            ${paging}
				        </div>
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

function listGuest(page) {
    const f = document.searchForm;
    f.page.value = page; 
    f.submit();         
}
</script>
</body>
</html>