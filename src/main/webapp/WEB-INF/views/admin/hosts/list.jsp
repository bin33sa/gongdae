<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <title>공대생 Admin - 호스트 관리</title>
</head>
<body class="admin-page">

<div class="admin-layout">
    <header class="admin-header">
        <div class="admin-logo">공대생</div>
        <div class="admin-user-area">
            <span><strong><sec:authentication property="principal.member.name"/></strong> 관리자님</span>
            <a href="${pageContext.request.contextPath}/member/logout" class="admin-logout">
                <i class="bi bi-box-arrow-right"></i> 로그아웃
            </a>
        </div>
    </header>

    <div class="admin-body">
        
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">호스트 파트너 관리</h3>
                    <p class="mb-0 text-muted">파티룸 공간을 제공하는 사업자(호스트) 승인 및 목록을 관리합니다.</p>
                </div>
                <button class="btn btn-purple"><i class="bi bi-plus-lg me-2"></i>신규 호스트 수동등록</button>
            </div>

            <div class="dashboard-box">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex gap-2">
                        <select class="form-select bg-transparent text-main border-secondary" style="width: 140px;">
                            <option value="all">전체 상태</option>
                            <option value="pending" style="color: #F59E0B;">승인 대기</option>
                            <option value="approved">승인 완료</option>
                            <option value="rejected">반려됨</option>
                        </select>
                        <select class="form-select bg-transparent text-main border-secondary" style="width: 130px;">
                            <option value="company">상호명</option>
                            <option value="owner">대표자명</option>
                        </select>
                        <div class="input-group" style="width: 250px;">
                            <input type="text" class="form-control bg-transparent text-main border-secondary" placeholder="검색어 입력">
                            <button class="btn btn-outline-secondary" type="button"><i class="bi bi-search"></i></button>
                        </div>
                    </div>
                    <div class="text-muted small">총 <strong class="text-main">145</strong>명의 호스트</div>
                </div>

                <div class="table-responsive">
                    <table class="table text-main mb-0 align-middle">
                        <thead>
                            <tr class="text-muted">
                                <th class="fw-normal border-bottom border-secondary pb-3">파트너번호</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">상호명 (법인명)</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">대표자</th>
                                <th class="fw-normal border-bottom border-secondary pb-3">연락처</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-center">등록 매장</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-center">상태</th>
                                <th class="fw-normal border-bottom border-secondary pb-3 text-end">심사/관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="background-color: rgba(245, 158, 11, 0.05);">
                                <td class="py-3 border-bottom border-secondary text-muted">#H-0145</td>
                                <td class="py-3 border-bottom border-secondary fw-bold text-warning">성수 무드 다이닝</td>
                                <td class="py-3 border-bottom border-secondary">최유리</td>
                                <td class="py-3 border-bottom border-secondary">010-1234-5678</td>
                                <td class="py-3 border-bottom border-secondary text-center text-muted fw-bold">-</td>
                                <td class="py-3 border-bottom border-secondary text-center"><span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-2 py-1">승인 대기</span></td>
                                <td class="py-3 border-bottom border-secondary text-end">
                                    <button class="btn btn-sm btn-outline-warning">서류 심사</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom border-secondary text-muted">#H-0144</td>
                                <td class="py-3 border-bottom border-secondary fw-bold">홍대 파티마을(주)</td>
                                <td class="py-3 border-bottom border-secondary">김철수</td>
                                <td class="py-3 border-bottom border-secondary">02-332-1111</td>
                                <td class="py-3 border-bottom border-secondary text-center text-info fw-bold">3개</td>
                                <td class="py-3 border-bottom border-secondary text-center"><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">승인 완료</span></td>
                                <td class="py-3 border-bottom border-secondary text-end">
                                    <button class="btn btn-sm btn-outline-secondary">상세</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="py-3 border-bottom-0 text-muted">#H-0143</td>
                                <td class="py-3 border-bottom-0 fw-bold">강남 모임스페이스</td>
                                <td class="py-3 border-bottom-0">박지훈</td>
                                <td class="py-3 border-bottom-0">010-9999-8888</td>
                                <td class="py-3 border-bottom-0 text-center text-info fw-bold">1개</td>
                                <td class="py-3 border-bottom-0 text-center"><span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 px-2 py-1">승인 완료</span></td>
                                <td class="py-3 border-bottom-0 text-end">
                                    <button class="btn btn-sm btn-outline-secondary">상세</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-center mt-4 pt-3 border-top border-secondary border-opacity-25">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item disabled"><a class="page-link bg-transparent border-secondary text-muted" href="#">이전</a></li>
                        <li class="page-item active"><a class="page-link border-primary" style="background-color: var(--accent-main);" href="#">1</a></li>
                        <li class="page-item"><a class="page-link bg-transparent border-secondary text-muted" href="#">다음</a></li>
                    </ul>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</body>
</html>