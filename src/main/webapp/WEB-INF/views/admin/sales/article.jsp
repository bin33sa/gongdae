<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 예약 상세 내역</title>
</head>
<body class="admin-page">

<div class="admin-layout d-flex flex-column min-vh-100">
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body d-flex flex-grow-1">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-2">예약 상세 내역</h3>
                    <p class="mb-0 text-muted">선택한 예약 및 결제 건의 세부 정보를 확인합니다.</p>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/sales/list?${query}';">
                        <i class="bi bi-list me-1"></i> 목록으로
                    </button>
                </div>
            </div>

            <div class="dashboard-box">
                <div class="article-header">
                    <div class="article-title-row">
                        <h4 class="fw-bold m-0 text-main">
                            ${dto.resNoStr} 
                            <span class="fs-6 ms-2 ${dto.statusColor}" style="vertical-align: middle;">[${dto.settlementStatus}]</span>
                        </h4>
                        <div class="article-meta">
                            <i class="bi bi-clock me-1"></i> 결제일시 : ${not empty dto.payDate ? dto.payDate : '결제 내역 없음'}
                        </div>
                    </div>
                </div>

                <div class="content-box mt-4">
                    <div class="row g-4">
                        <div class="col-md-6 border-end border-secondary">
                            <h5 class="fw-bold text-main pb-3 mb-0 border-bottom border-secondary">
                                <i class="bi bi-person-check me-2"></i>예약자 및 공간 정보
                            </h5>
                            
                            <table class="table text-main mb-0 align-middle">
                                <tbody>
                                    <tr>
                                        <th class="py-3 text-muted fw-normal border-bottom border-secondary" style="width: 120px;">예약자명</th>
                                        <td class="py-3 fw-bold border-bottom border-secondary">${dto.guestName}</td>
                                    </tr>
                                    <tr>
                                        <th class="py-3 text-muted fw-normal border-bottom border-secondary">이용 공간명</th>
                                        <td class="py-3 border-bottom border-secondary">${dto.spaceName}</td>
                                    </tr>
                                    <tr>
                                        <th class="py-3 text-muted fw-normal border-bottom border-secondary">상세 호실</th>
                                        <td class="py-3 border-bottom border-secondary">${not empty dto.unitName ? dto.unitName : '지정안됨'}</td>
                                    </tr>
                                    <tr>
                                        <th class="py-3 text-muted fw-normal border-0">이용 일시</th>
                                        <td class="py-3 text-info border-0">${dto.resDate}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="col-md-6 px-md-4">
                            <h5 class="fw-bold text-main pb-3 mb-0 border-bottom border-secondary">
                                <i class="bi bi-credit-card me-2"></i>결제 내역
                            </h5>
                            
                            <table class="table text-main mb-0 align-middle">
                                <tbody>
                                    <tr>
                                        <th class="py-3 text-muted fw-normal border-bottom border-secondary" style="width: 120px;">결제 상태</th>
                                        <td class="py-3 border-bottom border-secondary">
                                            <c:choose>
                                                <c:when test="${dto.payStatus == 'PAID'}">
                                                    <span class="status-normal">결제완료</span>
                                                </c:when>
                                                <c:when test="${dto.payStatus == 'CANCELLED'}">
                                                    <span class="status-banned">결제취소</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary bg-opacity-25 text-muted border border-secondary px-3 py-1" style="border-radius: 20px;">미결제</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="py-3 text-muted fw-normal border-bottom border-secondary">결제 수단</th>
                                        <td class="py-3 border-bottom border-secondary">신용카드 / 간편결제</td> </tr>
                                    <tr>
                                        <th class="py-4 text-muted fw-normal border-0">최종 결제 금액</th>
                                        <td class="py-4 fs-4 fw-bold text-main border-0">
                                            ₩<fmt:formatNumber value="${dto.amount}" pattern="#,###"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="article-footer mt-5">
                    <div>
                        <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/sales/list?${query}';">목록으로</button>
                    </div>
                    <div>
                        <c:if test="${dto.resStatus == 'RESERVED'}">
                            <button type="button" class="btn" style="background-color: rgba(239, 68, 68, 0.15); color: #F87171; border: 1px solid rgba(248, 113, 113, 0.3);">
                                강제 예약 취소
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<footer>
    <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</footer>

</body>
</html>