<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 공간 등록 - 공대생 호스트 센터</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #f4f6f9; font-family: 'Pretendard', sans-serif; }
        :root {
            --host-primary: #E53935; /* 호스트 전용 붉은색 */
            --host-hover: #c62828;
        }

        .form-container { max-width: 900px; margin: 40px auto; padding: 0 20px; }
        .page-title { font-size: 1.5rem; font-weight: bold; color: #333; margin-bottom: 24px; }
        
        /* 섹션 카드 스타일 */
        .section-card {
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: none;
            margin-bottom: 24px;
        }
        .section-title {
            font-size: 1.1rem;
            font-weight: bold;
            border-bottom: 2px solid #eee;
            padding-bottom: 12px;
            margin-bottom: 20px;
            color: #222;
        }
        
        /* 폼 요소 스타일 */
        .form-label { font-weight: 500; font-size: 0.95rem; color: #444; }
        .form-control, .form-select { border-radius: 8px; padding: 10px 15px; }
        .form-control:focus, .form-select:focus {
            border-color: var(--host-primary);
            box-shadow: 0 0 0 0.2rem rgba(229, 57, 53, 0.25);
        }
        .required::after { content: ' *'; color: var(--host-primary); }

        /* 하단 고정 버튼 영역 */
        .bottom-bar {
            background-color: #fff;
            padding: 15px 0;
            border-top: 1px solid #ddd;
            position: sticky;
            bottom: 0;
            z-index: 100;
            box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
        }
        .btn-submit {
            background-color: var(--host-primary);
            color: #fff;
            font-weight: bold;
            padding: 12px 40px;
            border-radius: 8px;
            border: none;
        }
        .btn-submit:hover { background-color: var(--host-hover); color: #fff; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/host/layout/header.jsp"/>

    <main class="form-container">
        <h2 class="page-title"><i class="bi bi-shop"></i> 새 공간 등록 (디자인 확인용)</h2>

        <form action="#" method="post" enctype="multipart/form-data">
            
            <div class="section-card">
                <h3 class="section-title">1. 공간 기본 정보</h3>
                
                <div class="mb-3">
                    <label for="spaceName" class="form-label required">공간명</label>
                    <input type="text" class="form-control" id="spaceName" name="spaceName" placeholder="예) 홍대 루프탑 감성 파티룸" required>
                </div>

                <div class="mb-3">
                    <label for="category" class="form-label required">공간 유형 (카테고리)</label>
                    <select class="form-select" id="category" name="category" required>
                        <option value="" selected disabled>카테고리를 선택해주세요</option>
                        <option value="PARTY">파티룸</option>
                        <option value="STUDY">스터디룸</option>
                        <option value="PRACTICE">연습실</option>
                        <option value="STUDIO">촬영스튜디오</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="oneLineIntro" class="form-label required">한줄 소개</label>
                    <input type="text" class="form-control" id="oneLineIntro" name="oneLineIntro" placeholder="공간의 매력을 한 줄로 어필해보세요." required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label required">상세 설명</label>
                    <textarea class="form-control" id="description" name="description" rows="6" placeholder="공간에 대한 자세한 설명을 적어주세요." required></textarea>
                </div>
            </div>

            <div class="section-card">
                <h3 class="section-title">2. 이용 및 요금 정보</h3>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="maxCapacity" class="form-label required">최대 수용 인원 (명)</label>
                        <input type="number" class="form-control" id="maxCapacity" name="maxCapacity" min="1" placeholder="예) 6" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="pricePerHour" class="form-label required">시간당 요금 (원)</label>
                        <input type="number" class="form-control" id="pricePerHour" name="pricePerHour" step="1000" min="0" placeholder="예) 15000" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label required">공간 위치 (주소)</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="address" name="address" placeholder="주소를 입력해주세요" required readonly>
                        <button class="btn btn-outline-secondary" type="button" id="btnSearchAddress">주소 검색</button>
                    </div>
                </div>
            </div>

            <div class="section-card">
                <h3 class="section-title">3. 공간 사진 등록</h3>
                <p class="text-muted small">공간의 매력을 잘 보여줄 수 있는 밝고 선명한 사진을 올려주세요. (최대 5장)</p>
                
                <div class="mb-3">
                    <label for="spaceImages" class="form-label required">대표 및 추가 이미지</label>
                    <input class="form-control" type="file" id="spaceImages" name="spaceImages" accept="image/*" multiple required>
                </div>
            </div>

            <div class="bottom-bar text-center mt-4">
                <button type="button" class="btn btn-light me-2 px-4 border" onclick="history.back()">취소</button>
                <button type="button" class="btn btn-submit" onclick="alert('디자인 테스트 화면입니다!')">등록 완료하기</button>
            </div>

        </form>
    </main>

</body>
</html>