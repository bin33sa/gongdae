<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>후기 작성</title>

<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp" />
<jsp:include page="/WEB-INF/views/guest/layout/header.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/guest/page/reviewWrite.css">

</head>

<body>

	<main class="review-main">

		<div class="review-wrapper">

			<div class="review-card">

				<!-- 상단 -->
				<div class="review-header">
					<h2>후기 작성</h2>
					<p>이용 경험을 솔직하게 남겨주세요</p>
				</div>

				<!-- 공간 정보 -->
				<div class="review-space">
					<img src="${pageContext.request.contextPath}/dist/images/bg1.png">

					<div class="space-meta">
						<h3>강남 스튜디오</h3>
						<p class="space-date">2026.03.10 이용</p>
						<span class="space-badge">예약 완료</span>
					</div>
				</div>


				<!-- 별점 -->
				<div class="review-block">

					<div class="review-label-row">
						<label class="review-label">공간 만족도</label> <span
							class="rating-text">별점을 선택해주세요</span>
					</div>

					<div class="rating-box">



						<div class="star-rating">

							<input type="radio" name="rating" id="s5" value="5"><label
								for="s5"></label> <input type="radio" name="rating" id="s4"
								value="4"><label for="s4"></label> <input type="radio"
								name="rating" id="s3" value="3"><label for="s3"></label>
							<input type="radio" name="rating" id="s2" value="2"><label
								for="s2"></label> <input type="radio" name="rating" id="s1"
								value="1"><label for="s1"></label>

						</div>





					</div>

				</div>


				<!-- 후기 -->
				<div class="review-block">
					<label>후기 내용</label>

					<textarea name="content" id="content"
						placeholder="좋았던 점과 아쉬웠던 점을 함께 적어주면 더 좋아요 :)"></textarea>

					<div class="text-count" id="textCount">0 / 500</div>
				</div>

				<!-- 업로드 -->
				<div class="review-block">
					<label>사진 업로드 (선택)</label> <input type="file" multiple>
				</div>

				<!-- 버튼 -->
				<button class="review-submit">후기 등록</button>

			</div>

		</div>

	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp" />

	<!-- JS -->
	<script>

const textarea = document.getElementById('content');
const count = document.getElementById('textCount');

textarea.addEventListener('input', () => {
  const len = textarea.value.length;
  count.innerText = len + " / 500";
});


const ratingText = ["", "별로예요", "아쉬워요", "보통이에요", "만족해요", "최고예요"];

document.querySelectorAll('input[name="rating"]').forEach(radio => {
  radio.addEventListener('change', e => {
    document.querySelector('.rating-text').innerText = ratingText[e.target.value];
  });
});

</script>

</body>
</html>