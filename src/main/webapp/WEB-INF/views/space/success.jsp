<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>공대생 - 공간 대여 생각날 때</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
</head>
<body>

<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>

<main>

<div class="payment-container">

	<div class="row justify-content-center" data-aos="fade-up" data-aos-delay="200">
		<div class="col-md-5">
			<div class="bg-white box-shadow mt-5 mb-5 p-5">
				<h3 class="text-center pt-3">결재 성공</h3>
				<hr class="mt-4">
				
				<div class="my-5">
					<div class="text-center">
						<p class="text-center" id="orderId"></p>
						<p class="text-center" id="space"></p>
						<p class="text-center" id="date"></p>
						<p class="text-center" id="amount"></p>
					</div>
				</div>
                   
				<div>
					<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/';">
						메인화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>
			</div>
		</div>
	</div>

</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

<script type="text/javascript">
	//쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
	// 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
	const urlParams = new URLSearchParams(window.location.search);
	const res_no = urlParams.get("res_no");
	const paymentKey = urlParams.get("paymentKey");
	const orderId = urlParams.get("orderId");
	const amount = urlParams.get("amount");
	
	async function confirm() {
	  	const requestData = {
			res_no: res_no,
	    	paymentKey: paymentKey,
	    	orderId: orderId,
	    	amount: amount,
	  	};
	
	  	const response = await fetch("/payment/confirm", {
	    	method: "POST",
	    	headers: {
	      		"Content-Type": "application/json",
	    	},
	    	body: JSON.stringify(requestData),
	  	});
	
	  	const json = await response.json();
	
	  	if (!response.ok) {
	  		throw { message: json.message, code: json.code };
	  	}
	  	
	  	return json;
	
	};
	
	confirm()
		.then(function(data) {

		})
		.catch((err) => {
			window.location.href = `/payment/fail?message=${err.message}&code=${err.code}`;
		});
	
	
	const orderIdElement = document.getElementById("orderId");
	const spaceElement = document.getElementById("space");
	const dateElement = document.getElementById("date");
	const amountElement = document.getElementById("amount");
	
	orderIdElement.textContent = "예약번호: " + orderId;
	spaceElement.textContent = "장소: ${space.name}, ${spaceUnit.title}";
	dateElement.textContent = "날짜/시간: ${reservInfo.res_date} / ${reservInfo.start_time}:00 ~ ${reservInfo.end_time}:00";
	amountElement.textContent = "결제 금액: " + amount;
</script>

</body>
</html>