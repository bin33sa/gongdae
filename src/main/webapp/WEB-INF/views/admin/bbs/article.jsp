<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 게시글 상세</title>
</head>
<body class="admin-page">

<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="content-box col-lg-10 mx-auto">
                
                <div class="article-header">
                    <div class="article-title-row">
                        <span class="article-badge">
                            ${type == 'NOTICE' ? '공지사항' : (type == 'EVENT' ? '이벤트' : 'FAQ')}
                        </span>
                        <div class="txt-muted small-txt">
                            조회수 <span class="text-info fw-bold ms-1">${dto.viewCount}</span>
                        </div>
                    </div>
                    
                    <h2 class="fw-bold mb-3">${dto.title}</h2>
                    
                    <div class="article-meta">
                        <div class="me-4"><i class="bi bi-person-circle me-1"></i> ${dto.adminName} (${dto.adminLoginId})</div>
                        <div><i class="bi bi-clock me-1"></i> ${dto.createdAt}</div>
                        
                        <c:if test="${type == 'EVENT' && not empty dto.startDate}">
                            <div class="ms-4 text-warning">
                                <i class="bi bi-calendar-event me-1"></i> 
                                ${dto.startDate.toString().substring(0,10)} ~ ${dto.endDate.toString().substring(0,10)}
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="article-content mb-5">
                    ${dto.content}
                </div>

                <c:if test="${not empty dto.saveFilename}">
                    <div class="attachment-box">
                        <i class="bi bi-paperclip fs-4 text-info me-3"></i>
                        <div>
                            <div class="txt-muted small-txt mb-1">첨부파일</div>
                            <a href="${pageContext.request.contextPath}/admin/bbs/${pathType}/download?boardNo=${dto.boardNo}" class="fw-bold text-decoration-none text-main">
                                ${dto.originalFilename}
                            </a>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary btn-rounded ms-auto px-3" onclick="location.href='${pageContext.request.contextPath}/admin/bbs/${pathType}/download?boardNo=${dto.boardNo}'">
                            다운로드
                        </button>
                    </div>
                </c:if>

                <div class="prev-next-wrap mt-5 border-top pt-4 mb-4">
                    <table class="table mb-0">
                        <tbody>
                            <c:if test="${not empty prevDto}">
                                <tr>
                                    <th class="text-muted" style="width: 100px;">이전글 <i class="bi bi-chevron-up ms-1"></i></th>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/bbs/${pathType}/article/${prevDto.boardNo}?${query}" class="text-decoration-none text-main hover-accent">
                                            ${prevDto.title}
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty nextDto}">
                                <tr>
                                    <th class="text-muted" style="width: 100px;">다음글 <i class="bi bi-chevron-down ms-1"></i></th>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/bbs/${pathType}/article/${nextDto.boardNo}?${query}" class="text-decoration-none text-main hover-accent">
                                            ${nextDto.title}
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="article-footer">
                    <button type="button" class="btn btn-outline-secondary btn-rounded px-5 py-2" onclick="location.href='${pageContext.request.contextPath}/admin/bbs/${pathType}/list?${query}';">목록</button>
                    
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-primary btn-rounded px-4 py-2" onclick="updateBoard();">수정</button>
                        <form name="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/bbs/${pathType}/delete">
                            <input type="hidden" name="boardNo" value="${dto.boardNo}">
                            <input type="hidden" name="page" value="${page}">
                            <input type="hidden" name="schType" value="${schType}">
                            <input type="hidden" name="kwd" value="${kwd}">
                            <button type="button" class="btn btn-outline-danger btn-rounded px-4 py-2" onclick="deleteBoard();">삭제</button>
                        </form>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script type="text/javascript">
    function updateBoard() {
        const url = '${pageContext.request.contextPath}/admin/bbs/${pathType}/update/${dto.boardNo}?${query}';
        location.href = url;
    }

    function deleteBoard() {
        if(confirm("게시글을 정말 삭제하시겠습니까? \n삭제된 데이터는 복구할 수 없습니다.")) {
            document.deleteForm.submit();
        }
    }
</script>

</body>
</html>