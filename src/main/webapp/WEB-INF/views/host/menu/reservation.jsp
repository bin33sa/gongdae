<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예약 내역 - 공대생 호스트 센터</title>

    <jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
<jsp:include page="/WEB-INF/views/host/layout/chatWidget.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/host/menu/reservation.css">
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>
</header>

<main class="container mt-5 mb-5">

    <div class="mb-4">
        <h3 class="fw-bold">예약 내역</h3>
        <p class="text-muted">전체 예약 현황을 확인하고 관리하세요.</p>
    </div>

    <div class="reservation-filter-box mb-4">
        <div class="row g-3 align-items-end">

            <div class="col-md-3">
                <label class="form-label small">기간</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-md-3">
                <label class="form-label small">~</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-md-3">
                <label class="form-label small">상태</label>
                <select class="form-select">
                    <option value="">전체</option>
                    <option value="PENDING">결제 대기</option>
                    <option value="RESERVED">예약 확정</option>
                    <option value="COMPLETED">이용 완료</option>
                    <option value="CANCELLED">취소</option>
                </select>
            </div>

            <div class="col-md-3">
                <button type="button" class="btn btn-search w-100">조회하기</button>
            </div>

        </div>
    </div>

    <div class="reservation-table-box">

        <div class="table-header mb-3">
            <h5 class="fw-bold m-0">예약 리스트</h5>
        </div>

        <table class="table reservation-table text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>예약번호</th>
                    <th>예약일</th>
                    <th>매장명 / 룸</th>
                    <th>예약자(인원)</th>
                    <th>이용시간</th>
                    <th>금액</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty list}">
                        <tr>
                            <td colspan="7" class="py-5 text-muted">조건에 맞는 예약 내역이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="dto" items="${list}">
                            <tr>
                                <td class="fw-bold text-secondary">#R${dto.resNo}</td>
                                
                                <td>${dto.resDate}</td>
                                
                                <td class="text-start">
                                    <div class="fw-bold text-dark">${dto.spaceName}</div>
                                    <div class="small text-muted">${dto.unitTitle}</div>
                                </td>
                                
                                <td>
                                    ${dto.guestName} <span class="small text-muted">(${dto.peopleCount}명)</span>
                                </td>
                                
                                <td>${dto.startTime}:00 ~ ${dto.endTime}:00</td>
                                
                                <td class="fw-bold">
                                    ₩ <fmt:formatNumber value="${dto.totalPrice}" pattern="#,###"/>
                                </td>
                                
                                <td>
                                    <c:choose>
                                        <c:when test="${dto.status == 'PENDING'}">
                                            <span class="badge bg-warning text-dark">결제 대기</span>
                                        </c:when>
                                        <c:when test="${dto.status == 'RESERVED'}">
                                            <span class="badge badge-active">예약 확정</span>
                                        </c:when>
                                        <c:when test="${dto.status == 'COMPLETED'}">
                                            <span class="badge badge-done">이용 완료</span>
                                        </c:when>
                                        <c:when test="${dto.status == 'CANCELLED'}">
                                            <span class="badge badge-cancel">취소</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        
        <div class="d-flex justify-content-center mt-4">
            ${paging}
        </div>

    </div> 
    
</main>



<footer>
    <jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>