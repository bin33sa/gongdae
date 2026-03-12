<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.5.0/dist/echarts.min.js"></script>
    <title>공대생 Admin - Dashboard</title>
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
                <button class="btn btn-purple">보고서 생성</button>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">누적 페이지뷰</div>
                        <div class="stat-value">50.8K <span class="trend-badge">28.4% ↑</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">월간 방문자</div>
                        <div class="stat-value">23.6K <span class="trend-badge">12.6% ↑</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">총 가입자</div>
                        <div class="stat-value">756 <span class="trend-badge">3.1% ↑</span></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-box">
                        <div class="stat-label">총 예약 건수</div>
                        <div class="stat-value">2.3K <span class="trend-badge">11.3% ↑</span></div>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4 align-items-stretch">
                <div class="col-lg-8">
                    <div class="dashboard-box h-100 d-flex flex-column" style="min-height: 550px;">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold text-main m-0">월간 매출 현황</h5>
                            <div class="text-muted small">
                                <i class="bi bi-circle-fill me-1" style="color: #3B82F6;"></i> 매출 
                                <i class="bi bi-circle-fill ms-2 me-1" style="color: #8B5CF6;"></i> 지출
                            </div>
                        </div>
                        <div class="display-5 fw-bold mb-4 text-main">$240.8K</div>
                        <div id="mainRevenueChart" class="flex-grow-1 w-100" style="min-height: 300px;"></div>
                    </div>
                </div>
                
                <div class="col-lg-4 d-flex flex-column gap-4">
                    <div class="dashboard-box flex-grow-1 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold text-main m-0">일간 접속자 수</h5>
                            <i class="bi bi-bar-chart text-muted fs-5"></i>
                        </div>
                        <div class="fs-2 fw-bold mb-1 text-main">10.2K <span class="trend-badge ms-2 fs-6">12.5% ↑</span></div>
                        <div id="dailyVisitorChart" class="flex-grow-1 w-100" style="min-height: 150px;"></div>
                    </div>
                    
                    <div class="dashboard-box flex-grow-1 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold text-main m-0">예약 결제 건수</h5>
                            <i class="bi bi-activity text-muted fs-5"></i>
                        </div>
                        <div class="fs-2 fw-bold mb-1 text-main">400 <span class="trend-badge ms-2 fs-6" style="background-color: rgba(59, 130, 246, 0.15); color: #3B82F6;">16.8% ↑</span></div>
                        <div id="reservationTrendChart" class="flex-grow-1 w-100" style="min-height: 150px;"></div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-12">
                    <div class="dashboard-box">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold text-main m-0">최근 예약 내역</h5>
                            <button class="btn btn-sm" style="background-color: var(--border-color); color: var(--text-main);">전체보기</button>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-main mb-0 align-middle">
                                <thead>
                                    <tr class="text-muted">
                                        <th class="fw-normal border-bottom border-secondary pb-3">예약번호</th>
                                        <th class="fw-normal border-bottom border-secondary pb-3">예약자</th>
                                        <th class="fw-normal border-bottom border-secondary pb-3">공간명</th>
                                        <th class="fw-normal border-bottom border-secondary pb-3">예약일시</th>
                                        <th class="fw-normal border-bottom border-secondary pb-3 text-end">상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="py-3 border-bottom border-secondary">#1532</td>
                                        <td class="py-3 border-bottom border-secondary">김민준</td>
                                        <td class="py-3 border-bottom border-secondary fw-semibold">홍대 파티룸 A</td>
                                        <td class="py-3 border-bottom border-secondary text-muted small">2026-03-06 14:30</td>
                                        <td class="py-3 border-bottom border-secondary text-end"><span class="text-success small fw-bold" style="color: #34E085 !important;">결제완료</span></td>
                                    </tr>
                                    <tr>
                                        <td class="py-3 border-bottom border-secondary">#1531</td>
                                        <td class="py-3 border-bottom border-secondary">이지은</td>
                                        <td class="py-3 border-bottom border-secondary fw-semibold">강남 스터디룸 B</td>
                                        <td class="py-3 border-bottom border-secondary text-muted small">2026-03-06 11:15</td>
                                        <td class="py-3 border-bottom border-secondary text-end"><span class="text-success small fw-bold" style="color: #34E085 !important;">결제완료</span></td>
                                    </tr>
                                    <tr>
                                        <td class="py-3 border-bottom-0">#1530</td>
                                        <td class="py-3 border-bottom-0">박서준</td>
                                        <td class="py-3 border-bottom-0 fw-semibold">성수 루프탑 C</td>
                                        <td class="py-3 border-bottom-0 text-muted small">2026-03-05 20:00</td>
                                        <td class="py-3 border-bottom-0 text-end"><span class="text-muted small fw-bold">예약대기</span></td>
                                    </tr>
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
                axisLabel: { color: '#9CA3AF', formatter: '{value}k' }
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
                    data: [120, 180, 150, 220, 280, 250, 310, 290, 350, 420, 380, 450]
                },
                {
                    name: '지출', type: 'line', smooth: true, showSymbol: false,
                    lineStyle: { width: 3, color: '#8B5CF6' },
                    areaStyle: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: 'rgba(139, 92, 246, 0.5)' },
                            { offset: 1, color: 'rgba(139, 92, 246, 0.0)' }
                        ])
                    },
                    data: [80, 100, 90, 130, 160, 140, 180, 170, 200, 240, 210, 260]
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
                data: [1200, 2000, 1500, 2800, 1900, 3300, 2900],
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
            grid: { left: '0%', right: '0%', bottom: '0%', top: '10%', containLabel: false },
            xAxis: { 
                type: 'category', 
                data: ['09:00', '11:00', '13:00', '15:00', '17:00', '19:00', '21:00'],
                show: false 
            },
            yAxis: { type: 'value', show: false },
            series: [{
                data: [15, 22, 18, 35, 28, 45, 40],
                type: 'line',
                smooth: true,
                showSymbol: false,
                lineStyle: { width: 4, color: '#3B82F6' }
            }]
        };
        lineChart.setOption(lineOption);

        window.addEventListener('resize', function() {
            mainChart.resize();
            barChart.resize();
            lineChart.resize();
        });
    });
</script>

</body>
</html>