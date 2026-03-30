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
                    <p class="mb-0 text-muted">게스트(일반 회원)의 상세 정보를 확인하고 등급 및 상태를 관리합니다.</p>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/guests/list?page=${page}';">
                        <i class="bi bi-list me-1"></i> 목록으로
                    </button>
                </div>
            </div>

            <div class="dashboard-box mb-4">
                <h5 class="fw-bold text-main mb-4"><i class="bi bi-person-lines-fill me-2"></i> 기본 정보</h5>
                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <tr>
                            <th class="admin-th" style="width: 15%;">회원번호</th>
                            <td class="admin-td text-muted" style="width: 35%;">#${dto.member_id}</td>
                            <th class="admin-th" style="width: 15%;">아이디</th>
                            <td class="admin-td" style="width: 35%;">${dto.login_id}</td>
                        </tr>
                        <tr>
                            <th class="admin-th">닉네임</th>
                            <td class="admin-td fw-bold">${dto.nickname}</td>
                            <th class="admin-th">이름</th>
                            <td class="admin-td text-muted">${empty dto.name ? '<span class="text-muted" style="opacity:0.5; margin-left:10px;">-</span>' : dto.name}</td>
                        </tr>
                        <tr>
                            <th class="admin-th">이메일</th>
                            <td class="admin-td">${empty dto.email ? '<span class="text-muted" style="opacity:0.5; margin-left:20px;">-</span>' : dto.email}</td>
                            <th class="admin-th">연락처</th>
                            <td class="admin-td">${empty dto.phone ? '<span class="text-muted" style="opacity:0.5; margin-left:20px;">-</span>' : dto.phone}</td>
                        </tr>
                        <tr>
                            <th class="admin-th">가입일</th>
                            <td class="admin-td text-muted">${dto.created_at}</td>
                            <th class="admin-th">최근 접속일</th>
                            <td class="admin-td text-muted">${empty dto.last_login ? '접속 이력 없음' : dto.last_login}</td>
                        </tr>
                        <tr>
                            <th class="admin-th border-0">보유 포인트</th>
                            <td class="admin-td fw-bold border-0 text-info">
                                <fmt:formatNumber value="${dto.point}" pattern="#,###"/> P
                                <button type="button" class="btn btn-sm btn-outline-info ms-3 px-2 py-0" onclick="givePointIndividual(${dto.member_id})">
                                    <i class="bi bi-plus-slash-minus"></i> 지급/차감
                                </button>
                            </td>
                            <th class="admin-th border-0">계정 상태</th>
                            <td class="admin-td border-0">
                                <c:choose>
                                    <c:when test="${dto.enabled == 1}"><span class="status-normal">정상 이용</span></c:when>
                                    <c:otherwise><span class="status-banned">이용 정지</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="mt-4 pt-4 d-flex justify-content-end align-items-center border-top border-secondary border-opacity-25">
                    <button type="button" class="btn btn-dark px-4 py-2 border border-secondary" onclick="statusDetailesMember();">
                        <i class="bi bi-shield-exclamation me-2 text-danger"></i>상태 변경 (제재/해제)
                    </button>
                </div>
            </div>

            <div class="dashboard-box mt-4">
                <div class="d-flex justify-content-between align-items-center border-bottom border-secondary pb-3 mb-4">
                    <h5 class="fw-bold text-main mb-0"><i class="bi bi-shield-lock me-2"></i>계정 상태 관리</h5>
                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="updateStatusModal();">상태 변경</button>
                </div>
                
                <table class="table table-borderless text-main align-middle mb-4">
                    <tbody>
                        <tr>
                            <th class="py-2 text-muted fw-normal" style="width: 150px;">현재 상태</th>
                            <td class="py-2">
                                ${dto.enabled == 1 ? '<span class="status-normal">정상 활성화</span>' : '<span class="status-banned">계정 정지됨</span>'}
                            </td>
                        </tr>
                        <c:if test="${not empty memberStatus}">
                            <tr>
                                <th class="py-2 text-muted fw-normal">최근 변경일</th>
                                <td class="py-2">${memberStatus.reg_date}</td>
                            </tr>
                            <tr>
                                <th class="py-2 text-muted fw-normal border-0">변경 사유</th>
                                <td class="py-2 border-0">${memberStatus.memo} (처리자: ${memberStatus.registerName})</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <h6 class="fw-bold text-main mb-4 mt-5"><i class="bi bi-clock-history me-2"></i>계정 상태 변경 이력</h6>
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
                                    <c:set var="lastClass" value="${status.last ? 'border-0' : ''}" />
                                    <td class="admin-td text-center text-muted ${lastClass}">${vo.num}</td>
                                    <td class="admin-td text-center ${lastClass}">
                                        <c:choose>
                                            <c:when test="${vo.status_code == 0}"><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">정상화 (0)</span></c:when>
                                            <c:otherwise><span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 px-2 py-1">정지 (${vo.status_code})</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-td text-muted ${lastClass}">${vo.memo}</td>
                                    <td class="admin-td text-center ${lastClass}">${vo.registerName}</td>
                                    <td class="admin-td text-center text-muted small-txt ${lastClass}">${vo.reg_date}</td>
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
                        <label class="form-label small-txt text-muted">대상 게스트</label>
                        <input type="text" class="form-control bg-transparent text-white border-secondary" value="${dto.nickname} (${dto.login_id})" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small-txt text-muted">상태 코드 지정</label>
                        <select name="status_code" id="statusCode" class="form-select" style="background-color:rgba(0,0,0,0.2); border-color:#374151;" onchange="selectStatusChange(this)">
                            <option value="">:: 상태 선택 ::</option>
                            <c:if test="${dto.enabled==0}"><option value="0">잠금 해제 (정상화)</option></c:if>
                            <option value="1">이용 정지 (일반)</option>
                            <option value="2">허위 정보 기재</option>
                            <option value="3">불법적인 사이트 이용</option>
                            <option value="4">게시판 도배/욕설</option>
                            <option value="5">호스트 클레임 누적</option>
                            <option value="6">약관 위반</option>
                            <option value="8">기타</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label small-txt text-muted">사유 (메모)</label>
                        <input type="text" name="memo" id="memo" class="form-control" style="background-color:rgba(0,0,0,0.2); border-color:#374151;" placeholder="변경 사유를 입력하세요">
                    </div>
                    <button type="button" class="btn btn-danger w-100 fw-bold py-2 border-0" onclick="updateStatusOk();">상태 적용하기</button>
                </form>
            </div>
        </div>
    </div>
</div>

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

function statusDetailesMember() {
    new bootstrap.Modal(document.getElementById('statusModal')).show();
}

function updateStatusModal() {
    new bootstrap.Modal(document.getElementById('statusModal')).show();
}

function selectStatusChange(el) {
    const memoInput = document.getElementById("memo");
    if(el.value !== "8" && el.value !== "") {
        memoInput.value = el.options[el.selectedIndex].text;
    } else if (el.value === "0") {
        memoInput.value = "정상 활성화 처리";
    } else {
        memoInput.value = "";
        memoInput.focus();
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
        alert("✅ 상태 변경이 완료되었습니다.");
        location.reload();
    } catch (e) { console.error(e); }
}

function givePointIndividual(memberId) {
    const point = prompt("해당 회원에게 지급할 포인트를 입력하세요.\n(차감 시 숫자 앞에 - 입력)");
    if(!point || isNaN(point)) return;

    const params = new URLSearchParams();
    params.append('memberIds[]', memberId);
    params.append('point', point);

    fetch('${pageContext.request.contextPath}/admin/guests/updatePoint', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(response => {
        if(response.ok) {
            alert("포인트가 적용되었습니다.");
            location.reload();
        } else {
            alert("포인트 적용 실패");
        }
    });
}
</script>
</body>
</html>