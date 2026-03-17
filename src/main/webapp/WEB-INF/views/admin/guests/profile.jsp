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
    <header class="admin-header">
        <div class="admin-logo">공대생</div>
        <div class="admin-user-area">
            <span><strong><sec:authentication property="principal.member.name"/></strong> 관리자님</span>
            <a href="${pageContext.request.contextPath}/member/logout" class="admin-logout">
                <i class="bi bi-box-arrow-right"></i> 로그아웃
            </a>
        </div>
    </header>

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

            <div class="dashboard-box mb-5">
                <h5 class="fw-bold text-main mb-4"><i class="bi bi-person-lines-fill me-2"></i> 기본 정보</h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <tr>
                            <th class="admin-th" style="width: 15%;">회원번호</th>
                            <td class="admin-td text-muted" style="width: 35%;">#${dto.member_id}</td>
                            <th class="admin-th" style="width: 15%;">회원 등급</th>
                            <td class="admin-td" style="width: 35%;">
                                <c:choose>
                                    <c:when test="${dto.grade == 'GOLD'}"><span class="grade-badge grade-gold">GOLD</span></c:when>
                                    <c:when test="${dto.grade == 'SILVER'}"><span class="grade-badge grade-silver">SILVER</span></c:when>
                                    <c:otherwise><span class="grade-badge grade-bronze">BRONZE</span></c:otherwise>
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
                            <th class="admin-th border-0">포인트</th>
                            <td class="admin-td fw-bold border-0"><fmt:formatNumber value="${dto.point}" pattern="#,###"/> P</td>
                            <th class="admin-th border-0">계정상태</th>
                            <td class="admin-td border-0">
                                <c:choose>
                                    <c:when test="${dto.enabled == 1}"><span class="status-normal">정상</span></c:when>
                                    <c:otherwise><span class="status-banned">정지 잠금</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="mt-4 pt-4 d-flex justify-content-end gap-3 border-top border-secondary border-opacity-25">
                    <button type="button" class="btn btn-dark px-4 py-2 border border-secondary" onclick="statusDetailesMember();">
                        <i class="bi bi-shield-exclamation me-2 text-danger"></i>상태변경
                    </button>
                    <c:if test="${dto.userLevel < 50 || adminMember.userLevel > 90}">
                        <button type="button" class="btn-purple" onclick="updateMember();">
                            <i class="bi bi-award-fill me-2"></i>등급변경
                        </button>
                    </c:if>
                </div>
            </div>

            <div class="dashboard-box">
                <h5 class="fw-bold text-main mb-4"><i class="bi bi-clock-history me-2"></i> 계정 상태 변경 이력</h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr>
                                <th class="admin-th text-center">번호</th>
                                <th class="admin-th text-center">상태 코드</th>
                                <th class="admin-th">변경 사유 (메모)</th>
                                <th class="admin-th text-center">처리 관리자</th>
                                <th class="admin-th text-center">처리 일시</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vo" items="${listStatus}" varStatus="status">
                                <tr>
                                    <c:set var="lastLine" value="${status.last ? 'border-0' : ''}" />
                                    <td class="admin-td text-center text-muted ${lastLine}">${vo.num}</td>
                                    <td class="admin-td text-center ${lastLine}">
                                        <c:choose>
                                            <c:when test="${vo.status_code == 0}"><span class="status-normal">정상화 (0)</span></c:when>
                                            <c:otherwise><span class="status-banned">정지 (${vo.status_code})</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td text-muted ${lastLine}">${vo.memo}</td>
                                    <td class="admin-td text-center ${lastLine}">${vo.registerName}</td>
                                    <td class="admin-td text-center text-muted small-txt ${lastLine}">${vo.reg_date}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listStatus}">
                                <tr>
                                    <td colspan="5" class="admin-td text-center py-5 border-0">
                                        <i class="bi bi-info-circle me-2"></i>상태 변경 이력이 없습니다.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
       </main>
    </div>
</div>

<div class="modal fade" id="memberUpdateDialogModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content bg-dark text-white border-secondary">
            <div class="modal-header border-secondary">
                <h5 class="modal-title fw-bold"><i class="bi bi-award me-2"></i>등급 변경</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form name="memberUpdateForm" id="memberUpdateForm">
                    <input type="hidden" name="member_id" value="${dto.member_id}">
                    <div class="mb-4">
                        <label class="form-label small-txt text-muted mb-2">변경할 등급 선택</label>
                        <select name="grade" class="form-select">
                            <option value="BRONZE" ${dto.grade == 'BRONZE' ? 'selected' : ''}>BRONZE</option>
                            <option value="SILVER" ${dto.grade == 'SILVER' ? 'selected' : ''}>SILVER</option>
                            <option value="GOLD" ${dto.grade == 'GOLD' ? 'selected' : ''}>GOLD</option>
                        </select>
                    </div>
                    <button type="button" class="btn-purple w-100" onclick="updateMemberOk();">변경 적용하기</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="statusModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white border-secondary">
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
                        <input type="text" class="form-control" value="${dto.name} (${dto.login_id})" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small-txt text-muted">상태 코드 지정</label>
                        <select name="status_code" id="statusCode" class="form-select" onchange="selectStatusChange(this)">
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
                        <input type="text" name="memo" id="memo" class="form-control" placeholder="변경 사유를 입력하세요">
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
        if (instance) instance.hide();
    });
    const backdrops = document.querySelectorAll('.modal-backdrop');
    backdrops.forEach(b => b.remove());
    document.body.classList.remove('modal-open');
    document.body.style.overflow = '';
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
        alert("✅ 등급이 변경되었습니다.");
        location.reload();
    } catch (e) { console.error(e); }
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
        alert("✅ 계정 상태가 변경되었습니다.");
        location.reload();
    } catch (e) { console.error("통신 오류:", e); }
}
</script>
</body>
</html>