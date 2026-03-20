<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 게시글 ${mode == 'update' ? '수정' : '작성'}</title>
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
</head>
<body class="admin-page">

<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="page-title-wrap">
                <div>
                    <h3 class="fw-bold mb-2">
                        <c:choose>
                            <c:when test="${type == 'NOTICE'}">공지사항 ${mode == 'update' ? '수정' : '작성'}</c:when>
                            <c:when test="${type == 'EVENT'}">이벤트 ${mode == 'update' ? '수정' : '작성'}</c:when>
                            <c:when test="${type == 'FAQ'}">FAQ ${mode == 'update' ? '수정' : '작성'}</c:when>
                            <c:otherwise>게시글 ${mode == 'update' ? '수정' : '작성'}</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="mb-0 txt-muted">게시글을 ${mode == 'update' ? '수정' : '작성하고 등록'}합니다.</p>
                </div>
            </div>

            <div class="content-box col-lg-10 mx-auto">
                <form name="boardForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/admin/bbs/${pathType}/${mode}">
                    <c:if test="${mode == 'update'}">
                        <input type="hidden" name="boardNo" value="${dto.boardNo}">
                        <input type="hidden" name="page" value="${page}">
                        <input type="hidden" name="schType" value="${schType}">
                        <input type="hidden" name="kwd" value="${kwd}">
                        <input type="hidden" name="saveFilename" value="${dto.saveFilename}">
                        <input type="hidden" name="originalFilename" value="${dto.originalFilename}">
                    </c:if>
                    
                    <div class="mb-4">
                        <label class="form-label txt-muted fw-bold">제목 <span class="required-mark">*</span></label>
                        <input type="text" name="title" class="admin-input form-control" placeholder="게시글 제목을 입력하세요" value="${dto.title}" required>
                    </div>

                    <c:if test="${type == 'EVENT'}">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label txt-muted fw-bold">이벤트 시작일</label>
                                <input type="date" name="startDate" class="admin-input form-control" value="${dto.startDate}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label txt-muted fw-bold">이벤트 종료일</label>
                                <input type="date" name="endDate" class="admin-input form-control" value="${dto.endDate}">
                            </div>
                        </div>
                    </c:if>

                    <div class="mb-4">
                        <label class="form-label txt-muted fw-bold">내용 <span class="required-mark">*</span></label>
                        <div id="editor" class="editor-container"></div>
                        <textarea name="content" id="hiddenContent" class="d-none">${dto.content}</textarea>
                    </div>

                    <div class="mb-4 mt-3">
                        <label class="form-label txt-muted fw-bold">
                            <c:choose>
                                <c:when test="${type == 'EVENT'}">
                                    목록 썸네일 이미지 <span class="required-mark">*</span>
                                    <small class="d-block text-primary fw-normal mt-1">※ 이벤트 목록에 보여질 대표 이미지를 등록해주세요.</small>
                                </c:when>
                                <c:otherwise>일반 첨부 파일</c:otherwise>
                            </c:choose>
                        </label>
                        <input type="file" name="selectFile" class="admin-input form-control" ${type == 'EVENT' ? 'accept="image/*"' : ''}>
                        
                        <c:if test="${mode == 'update' && not empty dto.saveFilename}">
                            <div class="mt-2 txt-muted small-txt d-flex align-items-center">
                                <i class="bi bi-paperclip me-1"></i> 현재 첨부된 파일: ${dto.originalFilename}
                                <button type="button" class="btn btn-sm btn-outline-danger ms-3 py-0 px-2" onclick="deleteFile();">삭제</button>
                            </div>
                        </c:if>
                    </div>

                    <div class="mb-5">
                        <label class="form-label txt-muted fw-bold">게시글 상태</label>
                        <div class="status-wrap">
                            <div>
                                <input type="radio" name="block" id="block0" value="0" class="d-none status-radio-normal" ${empty dto || dto.block == 0 ? 'checked' : ''}>
                                <label class="status-btn-normal" for="block0">정상 노출</label>
                            </div>
                            <div>
                                <input type="radio" name="block" id="block1" value="1" class="d-none status-radio-danger" ${dto.block == 1 ? 'checked' : ''}>
                                <label class="status-btn-danger" for="block1">숨김</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn btn-outline-secondary btn-rounded px-5 py-2" onclick="location.href='${pageContext.request.contextPath}/admin/bbs/${pathType}/list${not empty query ? '?' : ''}${query}';">목록으로</button>
                        <button type="button" class="btn btn-purple btn-rounded px-5 py-2" onclick="submitForm()">${mode == 'update' ? '수정하기' : '등록하기'}</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
<script type="text/javascript">
    var quill = new Quill('#editor', {
        theme: 'snow',
        placeholder: '게시글 내용을 입력하세요...',
        modules: {
            toolbar: {
                container: [
                    [{ 'header': [1, 2, 3, false] }],
                    ['bold', 'italic', 'underline', 'strike'],
                    [{ 'color': [] }, { 'background': [] }],
                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                    ['link', 'image'] 
                ],
                handlers: {
                    image: imageHandler
                }
            }
        }
    });

    if('${mode}' === 'update') {
        const existingContent = document.getElementById("hiddenContent").value;
        if(existingContent) {
            quill.clipboard.dangerouslyPasteHTML(existingContent);
        }
    }

    function imageHandler() {
        const input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');
        input.click();

        input.onchange = async () => {
            const file = input.files[0];
            const formData = new FormData();
            formData.append('upload', file);

            try {
                const response = await fetch('${pageContext.request.contextPath}/admin/bbs/${pathType}/imageUpload', {
                    method: 'POST',
                    body: formData
                });
                
                const result = await response.json();
                
                if(result.url) {
                    const range = quill.getSelection();
                    quill.insertEmbed(range.index, 'image', result.url);
                } else {
                    alert('이미지 업로드에 실패했습니다.');
                }
            } catch (error) {
                alert('이미지 업로드 중 오류가 발생했습니다.');
            }
        };
    }

    function deleteFile() {
        if(confirm("기존 첨부파일을 삭제하시겠습니까?")) {
            let url = '${pageContext.request.contextPath}/admin/bbs/${pathType}/deleteFile/${dto.boardNo}?${query}';
            location.href = url;
        }
    }

    function submitForm() {
        const f = document.boardForm;

        if(!f.title.value.trim()) {
            alert("제목을 입력하세요.");
            f.title.focus();
            return;
        }
        
        let content = quill.root.innerHTML;
        if(content === '<p><br></p>' || content === '') {
            alert("내용을 입력하세요.");
            quill.focus();
            return;
        }

        if ('${type}' === 'EVENT' && '${mode}' === 'write') {
            if (!f.selectFile.value) {
                alert("이벤트 썸네일 이미지를 반드시 첨부해 주세요.");
                f.selectFile.focus();
                return;
            }
        }

        if(f.startDate && !f.startDate.value) f.startDate.disabled = true;
        if(f.endDate && !f.endDate.value) f.endDate.disabled = true;

        document.getElementById("hiddenContent").value = content;
        f.submit();
    }
</script>
</body>
</html>