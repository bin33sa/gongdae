<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/util-async.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/util.js"></script>
    <title>공대생 Admin - 게스트 상세 정보</title>
</head>
<body class="admin-page">

<sec:authentication property="principal.member" var="adminMember" />

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content flex-grow-1 p-4" style="width: 0;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-2">게스트 상세 정보</h3>
                    <p class="mb-0 text-muted">회원의 상세 정보를 확인하고 등급 및 상태를 관리합니다.</p>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/guests/list?page=${page}';">
                        <i class="bi bi-list me-1"></i> 목록으로
                    </button>
                </div>
            </div>

            <div class="row">
                <div class="col-xxl-9 col-xl-10 col-lg-12">
                    <div class="dashboard-box mb-4 shadow-sm border border-secondary border-opacity-25 rounded p-4">
                        <h5 class="fw-bold text-main mb-4"><i class="bi bi-person-lines-fill me-2"></i> 기본 정보</h5>
                        <div class="table-responsive">
                            <table class="table text-main mb-0">
                                <tr>
                                    <th class="admin-th" style="width: 15%;">회원번호</th>
                                    <td class="admin-td text-muted" style="width: 35%;">#${dto.member_id}</td>
                                    <th class="admin-th" style="width: 15%;">회원 등급</th>
                                    <td class="admin-td" style="width: 35%;">
                                        <c:choose>
                                            <c:when test="${dto.grade == 'GOLD'}"><span class="badge bg-warning text-dark fw-bold">GOLD</span></c:when>
                                            <c:when test="${dto.grade == 'SILVER'}"><span class="badge bg-secondary fw-bold">SILVER</span></c:when>
                                            <c:otherwise><span class="badge fw-bold" style="background-color: #cd7f32;">BRONZE</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="admin-th">이름</th>
                                    <td class="admin-td fw-bold">${dto.name}</td>
                                    <th class="admin-th">닉네임</th>
                                    <td class="admin-td text-info fw-bold">${empty dto.nickname ? '-' : dto.nickname}</td>
                                </tr>
                                <tr>
                                    <th class="admin-th">로그인 아이디</th>
                                    <td class="admin-td">${dto.login_id}</td>
                                    <th class="admin-th">이메일</th>
                                    <td class="admin-td">${empty dto.email ? '-' : dto.email}</td>
                                </tr>
                                <tr>
                                    <th class="admin-th">전화번호</th>
                                    <td class="admin-td">${empty dto.phone ? '-' : dto.phone}</td>
                                    <th class="admin-th">생년월일</th>
                                    <td class="admin-td">${empty dto.birth ? '-' : dto.birth} <span class="small-txt text-muted ms-2">(만 ${dto.age}세)</span></td>
                                </tr>
                                <tr>
                                    <th class="admin-th">포인트</th>
                                    <td class="admin-td fw-bold"><fmt:formatNumber value="${dto.point}" pattern="#,###"/> P</td>
                                    <th class="admin-th">가입일</th>
                                    <td class="admin-td">${dto.created_at}</td>
                                </tr>
                                <tr>
                                    <th class="admin-th">계정상태</th>
                                    <td class="admin-td">
                                        <c:choose>
                                            <c:when test="${dto.enabled == 1}"><span class="badge bg-success bg-opacity-10 text-success border border-success px-2 py-1">정상</span></c:when>
                                            <c:otherwise><span class="badge bg-danger bg-opacity-10 text-danger border border-danger px-2 py-1">정지 잠금</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <th class="admin-th">최근수정일</th>
                                    <td class="admin-td text-muted">${dto.update_at}</td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="mt-5 pt-4 d-flex justify-content-end gap-3 border-top border-secondary border-opacity-25">
                        <button type="button" class="btn btn-dark px-4 py-2 border border-secondary" onclick="statusDetailesMember();">
                            <i class="bi bi-shield-exclamation me-2 text-danger"></i>상태변경
                        </button>
                        <c:if test="${dto.userLevel < 50 || adminMember.userLevel > 90}">
                            <button type="button" class="btn btn-primary px-4 py-2" style="background-color: #5b62f4; border-color: #5b62f4;" onclick="updateMember();">
                                <i class="bi bi-award-fill me-2"></i>등급변경
                            </button>
                        </c:if>
                    </div>
                </div>
            </div> 
       </main>
    </div>
</div>

<div class="modal fade" id="memberUpdateDialogModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content bg-dark text-white border-secondary shadow-lg">
            <div class="modal-header border-secondary">
                <h5 class="modal-title fw-bold"><i class="bi bi-award me-2"></i>등급 변경</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form name="memberUpdateForm" id="memberUpdateForm">
                    <input type="hidden" name="member_id" value="${dto.member_id}">
                    <div class="mb-4">
                        <label class="form-label small-txt text-muted mb-2">변경할 등급 선택</label>
                        <select name="grade" class="form-select bg-dark text-white border-secondary">
                            <option value="BRONZE" ${dto.grade == 'BRONZE' ? 'selected' : ''}>BRONZE</option>
                            <option value="SILVER" ${dto.grade == 'SILVER' ? 'selected' : ''}>SILVER</option>
                            <option value="GOLD" ${dto.grade == 'GOLD' ? 'selected' : ''}>GOLD</option>
                        </select>
                    </div>
                    <button type="button" class="btn btn-primary w-100 fw-bold py-2" onclick="updateMemberOk();">변경 적용하기</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="statusModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white border-secondary shadow-lg">
            <div class="modal-header border-secondary">
                <h5 class="modal-title fw-bold"><i class="bi bi-shield-lock me-2"></i>계정 상태 관리</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form name="memberStatusForm" id="memberStatusForm">
                    <input type="hidden" name="member_id" value="${dto.member_id}">
                    <input type="hidden" name="register_id" value="${adminMember.member_id}">
                    
                    <div class="mb-3">
                        <label class="form-label small-txt text-muted">대상 회원</label>
                        <input type="text" class="form-control bg-transparent text-white border-secondary" value="${dto.name} (${dto.login_id})" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small-txt text-muted">상태 코드 지정</label>
                        <select name="status_code" id="statusCode" class="form-select bg-dark text-white border-secondary" onchange="selectStatusChange(this)">
                            <option value="">:: 상태 선택 ::</option>
                            <c:if test="${dto.enabled==0}"><option value="0">잠금 해제 (정상화)</option></c:if>
                            <option value="1">이용 정지 (일반)</option>
                            <option value="2">불법적인 방법으로 로그인</option>
                            <option value="3">불건전 게시물 등록</option>
                            <option value="4">다른 유저 비방</option>
                            <option value="5">타계정 도용</option>
                            <option value="6">약관 위반</option>
                            <option value="7">1년이상 로그인하지 않음</option>
                            <option value="8">기타</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label small-txt text-muted">사유 (메모)</label>
                        <input type="text" name="memo" id="memo" class="form-control bg-dark text-white border-secondary" placeholder="변경 사유를 입력하세요">
                    </div>
                    <button type="button" class="btn btn-danger w-100 fw-bold py-2" onclick="updateStatusOk();">상태 적용하기</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script type="text/javascript">
function forceCloseModal() {
    const modals = document.querySelectorAll('.modal.show');
    modals.forEach(modalEl => {
        const instance = bootstrap.Modal.getInstance(modalEl);
        if (instance) {
            instance.hide();
        }
    });
    
    const backdrops = document.querySelectorAll('.modal-backdrop');
    backdrops.forEach(b => b.remove());
    
    document.body.classList.remove('modal-open');
    document.body.style.overflow = '';
    document.body.style.paddingRight = '';
}

function updateMember() {
    new bootstrap.Modal(document.getElementById('memberUpdateDialogModal')).show();
}

function statusDetailesMember() {
    new bootstrap.Modal(document.getElementById('statusModal')).show();
}

function selectStatusChange(el) {
    const memoInput = document.getElementById("memo");
    if(el.value !== "8" && el.value !== "") {
        memoInput.value = el.options[el.selectedIndex].text;
    } else {
        memoInput.value = "";
        memoInput.focus();
    }
}

async function updateMemberOk() {
    if(!confirm("등급을 변경하시겠습니까?")) return;
    const url = "${pageContext.request.contextPath}/admin/guests/updateGuest";
    const query = new URLSearchParams(new FormData(document.memberUpdateForm)).toString();
    try {
        await fetchRequest(url, "PUT", query, "form", "text");
        forceCloseModal(); 
        alert("✅ 정보가 수정되었습니다.");
        location.reload();
    } catch (e) { 
        console.error(e); 
    }
}

async function updateStatusOk() {
    const f = document.memberStatusForm;
    if(!f.status_code.value) { alert("상태를 선택하세요."); f.status_code.focus(); return; }
    if(!f.memo.value.trim()) { alert("사유를 입력하세요."); f.memo.focus(); return; }
    if(!confirm("상태를 변경하시겠습니까?")) return;
    
    const url = "${pageContext.request.contextPath}/admin/guests/GuestStatus";
    const query = new URLSearchParams(new FormData(f)).toString();
    try {
        await fetchRequest(url, "POST", query, "form", "text");
        forceCloseModal();
        alert("✅ 상태 변경 완료.");
        location.reload();
    } catch (e) { 
        console.error("통신 오류:", e);
    }
}
</script>
</body>
</html>