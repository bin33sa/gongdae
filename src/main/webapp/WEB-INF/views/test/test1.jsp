<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공지사항 목록</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
</head>
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
<body>

<div class="section">
    <div class="container">

        <!-- 제목 -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold">공지사항</h4>
        </div>

        <!-- 공지 테이블 -->
        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">

                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th style="width:10%">번호</th>
                            <th>제목</th>
                            <th style="width:15%">작성자</th>
                            <th style="width:15%">작성일</th>
                            <th style="width:10%">조회수</th>
                        </tr>
                    </thead>

                    <tbody>

                        <!-- 샘플 데이터 -->
                        <tr style="cursor:pointer">
                            <td>10</td>
                            <td>[공지] 서비스 점검 안내</td>
                            <td>관리자</td>
                            <td>2026-03-04</td>
                            <td>123</td>
                        </tr>

                        <tr style="cursor:pointer">
                            <td>9</td>
                            <td>신규 공간 등록 이벤트 안내</td>
                            <td>관리자</td>
                            <td>2026-03-02</td>
                            <td>84</td>
                        </tr>

                        <tr style="cursor:pointer">
                            <td>8</td>
                            <td>이용약관 변경 안내</td>
                            <td>관리자</td>
                            <td>2026-02-28</td>
                            <td>65</td>
                        </tr>

                    </tbody>
                </table>

            </div>
        </div>


        <!-- 페이징 -->
        <nav class="mt-4">
            <ul class="pagination justify-content-center">

                <li class="page-item disabled">
                    <a class="page-link">이전</a>
                </li>

                <li class="page-item active">
                    <a class="page-link">1</a>
                </li>

                <li class="page-item">
                    <a class="page-link">2</a>
                </li>

                <li class="page-item">
                    <a class="page-link">3</a>
                </li>

                <li class="page-item">
                    <a class="page-link">다음</a>
                </li>

            </ul>
        </nav>

    </div>
</div>

</body>
</html>