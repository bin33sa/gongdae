<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 게시글 관리</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content flex-grow-1">
            <div class="page-title-wrap mb-4 d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="fw-bold mb-2">
                        <c:choose>
                            <c:when test="${type == 'NOTICE'}">공지사항 관리</c:when>
                            <c:when test="${type == 'EVENT'}">이벤트 관리</c:when>
                            <c:when test="${type == 'FAQ'}">FAQ 관리</c:when>
                            <c:otherwise>게시글 관리</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="mb-0 text-muted">등록된 게시글을 조회하고 관리합니다.</p>
                </div>
                <button class="btn btn-purple btn-rounded px-4 py-2" onclick="location.href='${pageContext.request.contextPath}/admin/bbs/${pathType}/write';">
                    <i class="bi bi-pencil-square me-2"></i>글쓰기
                </button>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex gap-2">
                        <form name="searchForm" class="d-flex gap-2 form-search">
                            <select name="schType" class="form-select admin-input" style="width: 130px;">
                                <option value="all" ${schType == 'all' ? 'selected' : ''}>제목+내용</option>
                                <option value="title" ${schType == 'title' ? 'selected' : ''}>제목</option>
                                <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
                                <option value="admin_id" ${schType == 'admin_id' ? 'selected' : ''}>작성자ID</option>
                            </select>

                            <div class="input-group" style="width: 250px;">
                                <input type="text" name="kwd" value="${kwd}" class="form-control admin-input" placeholder="검색어 입력">
                                <button class="btn btn-outline-secondary" type="button" onclick="searchList()"><i class="bi bi-search"></i></button>
                            </div>
                        </form>
                    </div>
                    <div class="text-muted small-txt">총 <strong class="text-main">${dataCount}</strong>건의 게시글</div>
                </div>

                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th txt-center" width="8%">번호</th>
                                <th class="admin-th text-start" width="*">제목</th>
                                <th class="admin-th txt-center" width="12%">작성자</th>
                                <th class="admin-th txt-center" width="15%">작성일</th>
                                <th class="admin-th txt-center" width="8%">조회수</th>
                                <th class="admin-th txt-center" width="8%">파일</th>
                                <th class="admin-th txt-center" width="8%">상태</th>
                                <th class="admin-th txt-center" width="10%">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="8" class="admin-td txt-center text-muted" style="padding: 3rem 0;">등록된 게시글이 없습니다.</td> 
                                </tr>
                            </c:if>
                            <c:forEach var="dto" items="${list}">
                                <tr class="board-row">
                                    <td class="admin-td text-muted txt-center">${dto.boardNo}</td>
                                    <td class="admin-td text-start fw-bold">
                                        <c:url var="url" value="/admin/bbs/${pathType}/article/${dto.boardNo}">
                                            <c:param name="page" value="${page}"/>
                                            <c:if test="${not empty kwd}">
                                                <c:param name="schType" value="${schType}"/>
                                                <c:param name="kwd" value="${kwd}"/>
                                            </c:if>									
                                        </c:url>
                                        <div class="text-wrap">
                                            <a href="${url}" class="text-main text-decoration-none hover-accent">
                                                <c:out value="${dto.title}"/>
                                            </a>
                                        </div>
                                    </td>
                                    <td class="admin-td txt-center">${dto.adminName}</td>
                                    <td class="admin-td txt-center text-muted small-txt">
                                        ${dto.createdAt.toString().substring(0, 10)}
                                    </td>
                                    <td class="admin-td txt-center fw-bold">${dto.viewCount}</td>
                                    <td class="admin-td txt-center">
                                        <c:if test="${not empty dto.saveFilename}">
                                            <a href="${pageContext.request.contextPath}/admin/bbs/${pathType}/download?boardNo=${dto.boardNo}" class="text-info"><i class="bi bi-paperclip fs-5"></i></a>
                                        </c:if>
                                    </td>
                                    <td class="admin-td txt-center">
                                        <c:choose>
                                            <c:when test="${dto.block == 1}">
                                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">숨김</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">정상</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td txt-center">
                                        <button type="button" class="btn btn-sm btn-outline-secondary btn-rounded px-3" onclick="location.href='${url}'">상세</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-center mt-4 pt-2">
                    <nav aria-label="Page navigation">
                        <div class="admin-pagination page-navigation">
                            ${dataCount == 0 ? "" : paging}
                        </div>
                    </nav>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
    const inputEL = document.querySelector('form[name=searchForm] input[name=kwd]');
    
    inputEL.addEventListener('keydown', ev => {
        if(ev.key === 'Enter') {
            ev.preventDefault();
            searchList();
        }
    });
});

function searchList() {
    const f = document.searchForm;
    const formData = new FormData(f);
    const params = new URLSearchParams(formData).toString();
    
    const url = '${pageContext.request.contextPath}/admin/bbs/${pathType}/list?' + params;
    location.href = url;
}
</script>
</body>
</html>