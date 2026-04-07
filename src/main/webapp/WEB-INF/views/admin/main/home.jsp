<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <title>공대생 Admin - Dashboard</title>
    <style>
        .status-reserved { color: #34E085 !important; }
        .status-cancelled { color: #EF4444 !important; }
        .status-completed { color: #3B82F6 !important; }
        .status-pending { color: #F59E0B !important; }
        .status-default { color: #6C757D !important; }
    </style>
</head>
<body class="admin-page">

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>

    <div class="admin-body">
        
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <div>
                    <h3 class="fw-bold mb-2">Welcome back, <sec:authentication property="principal.member.name"/></h3>
                    <p class="mb-0 text-muted">서비스의 주요 지표와 최근 현황을 실시간으로 확인하세요.</p>
                </div>
                <button id="btn-export-excel" class="btn btn-success">
                    <i class="bi bi-file-earmark-excel me-1"></i> 보고서 다운로드
                </button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">누적 페이지뷰</div>
                        <div class="stat-value"><fmt:formatNumber value="${dto.totalPageViews}" pattern="#,###"/> <span class="trend-badge">조회수</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">월간 신규 가입</div>
                        <div class="stat-value"><fmt:formatNumber value="${dto.monthlyVisitors}" pattern="#,###"/> <span class="trend-badge">이번 달</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">총 가입자 (게스트+호스트)</div>
                        <div class="stat-value"><fmt:formatNumber value="${dto.totalMembers}" pattern="#,###"/> <span class="trend-badge">전체</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">총 누적 예약 건수</div>
                        <div class="stat-value"><fmt:formatNumber value="${dto.totalReservations}" pattern="#,###"/> <span class="trend-badge">누적</span></div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4 align-items-stretch">
                <div class="col-lg-8">
                    <div class="dashboard-box h-100 d-flex flex-column" style="min-height: 550px;">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold text-main m-0">올해 월간 매출/지출 현황</h5>
                            <div class="text-muted small-txt">
                                <i class="bi bi-circle-fill me-1" style="color: #3B82F6;"></i> 매출 
                                <i class="bi bi-circle-fill ms-2 me-1" style="color: #8B5CF6;"></i> 환불(지출)
                            </div>
                        </div>
                        <div class="display-6 fw-bold mb-4 text-main fs-5">데이터 기반 실시간 집계</div>
                        <div id="mainRevenueChart" class="flex-grow-1 w-100" style="min-height: 300px;"></div>
                    </div>
                </div>
                
                <div class="col-lg-4 d-flex flex-column gap-4">
                    <div class="dashboard-box flex-grow-1 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold text-main m-0">최근 7일 요일별 예약 추이</h5>
                            <i class="bi bi-bar-chart text-muted fs-5"></i>
                        </div>
                        <div class="fs-2 fw-bold mb-1 text-main"><span class="trend-badge fs-6" style="margin-left: 0;">주간 통계</span></div>
                        <div id="dailyVisitorChart" class="flex-grow-1 w-100" style="min-height: 150px;"></div>
                    </div>
                    
                    <div class="dashboard-box flex-grow-1 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold text-main m-0">시간대별 접속자 수</h5>
                            <i class="bi bi-activity text-muted fs-5"></i>
                        </div>
                        <div class="fs-2 fw-bold mb-1 text-main"><span class="trend-badge fs-6" style="background-color: rgba(59, 130, 246, 0.15); color: #3B82F6; margin-left: 0;">최근 로그인 기준</span></div>
                        <div id="reservationTrendChart" class="flex-grow-1 w-100" style="min-height: 150px;"></div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-12">
                    <div class="dashboard-box">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold text-main m-0">최근 예약 내역 (최근 5건)</h5>
                            <button class="btn btn-sm" style="background-color: var(--border-color); color: var(--text-main);" onclick="location.href='${pageContext.request.contextPath}/admin/sales/list'">전체보기</button>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-main mb-0 align-middle">
                                <thead>
                                    <tr>
                                        <th class="admin-th">예약번호</th>
                                        <th class="admin-th">예약자</th>
                                        <th class="admin-th">공간명</th>
                                        <th class="admin-th">예약일시</th>
                                        <th class="admin-th txt-right">상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty dto.recentReservations}">
                                            <c:forEach var="res" items="${dto.recentReservations}">
                                                <tr>
                                                    <td class="admin-td">${res.resNo}</td>
                                                    <td class="admin-td">${res.guestName}</td>
                                                    <td class="admin-td fw-bold">${res.spaceName}</td>
                                                    <td class="admin-td txt-muted small-txt">${res.resDate}</td>
                                                    <td class="admin-td txt-right">
                                                        <span class="small-txt fw-bold ${res.statusColor}">
                                                            ${res.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="admin-td text-center text-muted py-4">최근 예약 내역이 없습니다.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        
        var mainChart = echarts.init(document.getElementById('mainRevenueChart'));
        var mainOption = {
            tooltip: { trigger: 'axis', backgroundColor: '#1F2937', borderColor: '#374151', textStyle: { color: '#F9FAFB' } },
            grid: { left: '0%', right: '2%', bottom: '0%', top: '10%', containLabel: true },
            xAxis: { 
                type: 'category', 
                boundaryGap: false, 
                data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                axisLine: { show: false },
                axisTick: { show: false },
                axisLabel: { color: '#9CA3AF' }
            },
            yAxis: { 
                type: 'value',
                splitLine: { lineStyle: { color: '#374151', type: 'dashed' } },
                axisLabel: { color: '#9CA3AF', formatter: '{value}' } 
            },
            series: [
                {
                    name: '매출', type: 'line', smooth: true, showSymbol: false,
                    lineStyle: { width: 3, color: '#3B82F6' },
                    areaStyle: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: 'rgba(59, 130, 246, 0.5)' },
                            { offset: 1, color: 'rgba(59, 130, 246, 0.0)' }
                        ])
                    },
                    data: ${dto.monthlyRevenue} 
                },
                {
                    name: '환불(지출)', type: 'line', smooth: true, showSymbol: false,
                    lineStyle: { width: 3, color: '#8B5CF6' },
                    areaStyle: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: 'rgba(139, 92, 246, 0.5)' },
                            { offset: 1, color: 'rgba(139, 92, 246, 0.0)' }
                        ])
                    },
                    data: ${dto.monthlyExpense} 
                }
            ]
        };
        mainChart.setOption(mainOption);

        var barChart = echarts.init(document.getElementById('dailyVisitorChart'));
        var barOption = {
            tooltip: { trigger: 'axis', backgroundColor: '#1F2937', borderColor: '#374151', textStyle: { color: '#F9FAFB' } },
            grid: { left: '0%', right: '0%', bottom: '0%', top: '10%', containLabel: false },
            xAxis: { 
                type: 'category', 
                data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                show: false 
            },
            yAxis: { type: 'value', show: false },
            series: [{
                data: ${dto.weeklyVisitors}, 
                type: 'bar',
                showBackground: true,
                backgroundStyle: { color: 'rgba(255, 255, 255, 0.05)', borderRadius: 4 },
                itemStyle: { color: '#F59E0B', borderRadius: 4 },
                barWidth: '40%'
            }]
        };
        barChart.setOption(barOption);

        var lineChart = echarts.init(document.getElementById('reservationTrendChart'));
        var lineOption = {
            tooltip: { trigger: 'axis', backgroundColor: '#1F2937', borderColor: '#374151', textStyle: { color: '#F9FAFB' } },
            grid: { left: '2%', right: '5%', bottom: '5%', top: '10%', containLabel: true },
            xAxis: { 
                type: 'category', 
                data: ['0시','1시','2시','3시','4시','5시','6시','7시','8시','9시','10시','11시','12시','13시','14시','15시','16시','17시','18시','19시','20시','21시','22시','23시'],
                show: true,
                axisLabel: { color: '#9CA3AF', fontSize: 10 },
                axisLine: { show: false },
                axisTick: { show: false }
            },
            yAxis: { type: 'value', show: false }, 
            series: [{
                data: ${dto.hourlyVisitors}, 
                type: 'line',
                smooth: true,
                showSymbol: false,
                lineStyle: { width: 4, color: '#3B82F6' },
                areaStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        { offset: 0, color: 'rgba(59, 130, 246, 0.3)' },
                        { offset: 1, color: 'rgba(59, 130, 246, 0.0)' }
                    ])
                }
            }]
        };
        lineChart.setOption(lineOption);

        window.addEventListener('resize', function() {
            mainChart.resize();
            barChart.resize();
            lineChart.resize();
        });

        document.getElementById('btn-export-excel').addEventListener('click', function() {
            
            var wb = XLSX.utils.book_new();

            var summaryData = [
                ['통계 항목', '수치'],
                ['누적 페이지뷰', '${dto.totalPageViews} 회'],
                ['월간 신규 가입', '${dto.monthlyVisitors} 명'],
                ['총 가입자 수', '${dto.totalMembers} 명'],
                ['총 예약 건수', '${dto.totalReservations} 건']
            ];
            var ws1 = XLSX.utils.aoa_to_sheet(summaryData);
            XLSX.utils.book_append_sheet(wb, ws1, "요약 통계");

            var monthlyRev = ${dto.monthlyRevenue};
            var monthlyExp = ${dto.monthlyExpense};
            var monthlyData = [['월', '매출액(원)', '지출액(원)']]; 
            
            for(var i=0; i<12; i++) {
                monthlyData.push([(i+1) + '월', monthlyRev[i], monthlyExp[i]]);
            }
            var ws2 = XLSX.utils.aoa_to_sheet(monthlyData);
            XLSX.utils.book_append_sheet(wb, ws2, "월간 매출 현황");

            var tableElement = document.querySelector('.table'); 
            var ws3 = XLSX.utils.table_to_sheet(tableElement);
            XLSX.utils.book_append_sheet(wb, ws3, "최근 예약 내역");

            var today = new Date();
            var dateString = today.getFullYear() + ('0' + (today.getMonth() + 1)).slice(-2) + ('0' + today.getDate()).slice(-2);
            var fileName = '공대생_대시보드_보고서_' + dateString + '.xlsx';
            
            XLSX.writeFile(wb, fileName);
        });

    });
</script>

</body>
</html>