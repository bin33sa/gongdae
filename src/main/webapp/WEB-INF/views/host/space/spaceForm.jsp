<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

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
            box-shadow: 0 0 0