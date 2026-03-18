<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/guest/layout/headerResources.jsp"/>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/guest/layout/header.jsp"/>
</header>

<main>
	
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 bg-white box-shadow my-4 p-5">
					<form name="memberForm" method="post" enctype="multipart/form-data">
						<div class="d-flex align-items-start align-items-sm-center gap-3 pb-4 border-bottom">
							<img src="${pageContext.request.contextPath}/dist/images/user.png" class="img-avatar d-block w-px-100 h-px-100 rounded">
							<div class="ms-3">
								<label for="selectFile" class="btn-accent me-2 mb-4" tabindex="0" title="사진 업로드">
									<span class="d-none d-sm-block">사진 업로드</span>
									<i class="bi bi-upload d-block d-sm-none"></i>
									<input type="file" name="selectFile" id="selectFile" hidden="" accept="image/png, image/jpg, image/jpeg">
								</label>
								<button type="button" class="btn-photo-init btn-default mb-4" title="초기화">
									<span class="d-none d-sm-block">초기화</span>
									<i class="bi bi-arrow-counterclockwise d-block d-sm-none"></i>
								</button>
								<div>Allowed JPG, GIF or PNG. Max size of 800K</div>
							</div>
						</div>
						
						<div class="row g-3 pt-4">
							<div class="col-md-12 wrap-loginId">
								<label for="login_id" class="form-label font-roboto">아이디</label>
								<div class="row g-3">
									<div class="col-md-6">
										<input class="form-control" type="text" id="login_id" name="login_id" value="${dto.login_id}"
											${mode=="update" ? "readonly ":""} autofocus>									
									</div>
									<div class="col-md-6">
										<c:if test="${mode=='signup'}">
											<button type="button" class="btn-default" onclick="userIdCheck();">아이디중복검사</button>
										</c:if>
									</div>
								</div>
								<c:if test="${mode=='signup'}">
									<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
								</c:if>
							</div>
	
							<div class="col-md-12">
								<div class="row g-3">
									<div class="col-md-6">
										<label for="password" class="form-label font-roboto">패스워드</label>
										<input class="form-control" type="password" id="password" name="password" autocomplete="off" >
										<small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자를 포함 합니다.</small>
									</div>
									<div class="col-md-6">
										<label for="password2" class="form-label font-roboto">패스워드확인</label>
										<input class="form-control" type="password" id="password2" name="password2" autocomplete="off">
										<small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
									</div>
								</div>
							</div>
							
							<div class="col-md-12 wrap-nickname">
								<label for="nickname" class="form-label font-roboto">닉네임</label>
								<div class="row g-3">
									<div class="col-md-6">
										<input class="form-control" type="text" id="nickname" name="nickname" value="${dto.nickname}"
											${mode=="update" ? "readonly ":""} autofocus>									
									</div>
									<div class="col-md-6">
										<c:if test="${mode=='signup'}">
											<button type="button" class="btn-default" onclick="nicknameCheck();">닉네임중복검사</button>
										</c:if>
									</div>
								</div>
								<c:if test="${mode=='signup'}">
									<small class="form-control-plaintext help-block">닉네임은 2~10자 이내이며, 한글, 영어, 숫자로만 이루어져야 합니다.</small>
								</c:if>
							</div>	
		
							<div class="col-md-6">
								<label for="fullName" class="form-label font-roboto">이름</label>
								<input class="form-control" type="text" id="fullName" name="name" value="${dto.name}"
									${mode=="update" ? "readonly ":""}>
							</div>
							<div class="col-md-6">
								<label for="birth" class="form-label font-roboto">생년월일</label>
								<input class="form-control" type="date" id="birth" name="birth" value="${dto.birth}"
									${mode=="update" ? "readonly ":""}>
							</div>
	
							<div class="col-md-6">
								<label for="email" class="form-label font-roboto">이메일</label>
								<input class="form-control" type="text" id="email" name="email" value="${dto.email}">
							</div>
							<div class="col-md-6">
								<label for="receive_email" class="form-label font-roboto">메일 수신</label>
								<div class="form-check pt-1">
									<input class="form-check-input" type="checkbox" name="receive_email" id="receive_email"
										value="1" ${empty dto || dto.receive_email == 1 ? "checked":""}>
									<label class="form-check-label" for="receive_email"> 동의</label>
								</div>
							</div>

							<div class="col-md-6">
								<label for="tel" class="form-label font-roboto">전화번호</label>
								<input class="form-control" type="text" id="tel" name="tel" value="${dto.tel}">
							</div>
							<div class="col-md-6">
								<label for="tel" class="form-label font-roboto">성별</label>
								
								<div class="btn-group w-100" role="group">
								    <input type="radio" class="btn-check" name="gender" id="male" value="M" autocomplete="off">
								    <label class="btn btn-outline-primary" for="male">남성</label>
								
								    <input type="radio" class="btn-check" name="gender" id="female" value="F" autocomplete="off">
								    <label class="btn btn-outline-primary" for="female">여성</label>

								    <input type="radio" class="btn-check" name="gender" id="none" value="X" autocomplete="off" checked>
								    <label class="btn btn-outline-primary" for="none">미선택</label>
								</div>
							</div>
							
							
							<div class="col-md-12">
								<label for="agree" class="form-label font-roboto">약관 동의</label>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" name="agree" id="agree"
											checked
											onchange="form.sendButton.disabled = !checked">
									<label for="agree" class="form-check-label">
										<a href="${pageContext.request.contextPath}/terms" class="text-primary border-link-right" target="_blank">이용약관</a>에 동의합니다.
									</label>
								</div>
							</div>
							
							<div class="col-md-12 text-center">
								<button type="button" name="sendButton" class="btn-accent btn-lg" onclick="memberOk();"> ${mode=="update"?"정보수정":"회원가입"} <i class="bi bi-check2"></i></button>
								<button type="button" class="btn-default btn-lg" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="update"?"수정취소":"가입취소"} <i class="bi bi-x"></i></button>
								<input type="hidden" name="loginIdValid" id="loginIdValid" value="false">
								<input type="hidden" name="nicknameValid" id="nicknameValid" value="false">
								<c:if test="${mode == 'update'}">
									<input type="hidden" name="profile_photo" value="${dto.profile_photo}">
								</c:if>
							</div>
						</div>
						
					</form>
				</div>
			</div>
			
		</div>
	</div>
</main>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', ev => {
	let img = '${dto.profile_photo}';

	const avatarEL = document.querySelector('.img-avatar');
	const inputEL = document.querySelector('form[name=memberForm] input[name=selectFile]');
	const btnEL = document.querySelector('form[name=memberForm] .btn-photo-init');
	
	let avatar;
	if( img ) {
		avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
		avatarEL.src = avatar;
	}
	
	const maxSize = 800 * 1024;
	inputEL.addEventListener('change', ev => {
		let file = ev.target.files[0];
		if(! file) {
			if( img ) {
				avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
			} else {
				avatar = '${pageContext.request.contextPath}/dist/images/user.png';
			}
			avatarEL.src = avatar;
			
			return;
		}
		
		if(file.size > maxSize || ! file.type.match('image.*')) {
			alert("프로필 사진은 800Kb 이하의 확장자가 JPG, GIF, PNG 인 사진만 가능합니다.");
			inputEL.focus();
			return;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			avatarEL.src = e.target.result;
		}
		reader.readAsDataURL(file);			
	});
	
	btnEL.addEventListener('click', ev => {
		if( img ) {
			if(! confirm('등록된 이미지를 삭제하시겠습니까 ? ')) {
				return false;
			}
			
			avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
			
			// 등록 이미지 삭제
			const url = '${pageContext.request.contextPath}/member/deleteProfile';
			const headers = {'Content-Type': 'application/x-www-form-urlencoded', 'AJAX': true};
			const params = 'profile_photo=' + img;
			
			const options = {
				method: 'delete',
				headers: headers,
				body: params,
			};
				
			fetch(url, options)
				.then(res => res.json())
				.then(data => {
					let state = data.state;

					if(state === 'true') {
						img = '';
						avatar = '${pageContext.request.contextPath}/dist/images/user.png';
						
						document.querySelector('form input[name=profile_photo').value = '';
					}
					
					inputEL.value = '';
					avatarEL.src = avatar;
				})
				.catch(err => console.log("error:", err));
		} else {
			avatar = '${pageContext.request.contextPath}/dist/images/user.png';
			inputEL.value = '';
			avatarEL.src = avatar;
		}
	
	});
});

function isValidDateString(dateString) {
	try {
		const date = new Date(dateString);
		const [year, month, day] = dateString.split("-").map(Number);
		
		return date instanceof Date && !isNaN(date) && date.getDate() === day;
	} catch(e) {
		return false;
	}
}

function memberOk() {
	const f = document.memberForm;
	let str, p;

	p = /^[a-z][a-z0-9_]{4,9}$/i;
	str = f.login_id.value;
	if( ! p.test(str) ) { 
		alert('아이디를 다시 입력 하세요. ');
		f.login_id.focus();
		return;
	}

	let mode = '${mode}';
	if( mode === 'signup' && f.loginIdValid.value === 'false' ) {
		str = '아이디 중복 검사가 실행되지 않았습니다.';
		document.querySelector('.wrap-loginId .help-block').textContent = str;
		f.login_id.focus();
		return;
	}
	
	p = /^[a-z0-9가-힣ㄱ-ㅎㅏ-ㅣ]{2,10}$/i;
	str = f.nickname.value;
	if( ! p.test(str) ) { 
		alert('닉네임을 다시 입력 하세요. ');
		f.nickname.focus();
		return;
	}
	
	if( mode === 'signup' && f.nicknameValid.value === 'false' ) {
		str = '닉네임 중복 검사가 실행되지 않았습니다.';
		document.querySelector('.wrap-nickname .help-block').textContent = str;
		f.nickname.focus();
		return;
	}


	p =/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
	str = f.password.value;
	if( ! p.test(str) ) { 
		alert('패스워드를 다시 입력 하세요. ');
		f.password.focus();
		return;
	}

	if( str !== f.password2.value ) {
        alert('패스워드가 일치하지 않습니다. ');
        f.password.focus();
        return;
	}
	
	p = /^[가-힣]{2,5}$/;
    str = f.name.value;
    if( ! p.test(str) ) {
        alert('이름을 다시 입력하세요. ');
        f.name.focus();
        return;
    }

    str = f.birth.value;
    if( ! isValidDateString(str) ) {
        alert('생년월일를 입력하세요. ');
        f.birth.focus();
        return;
    }
    
    p = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;    
    str = f.email.value;
    if( ! p.test(str) ) {
        alert('이메일을 입력하세요. ');
        f.email.focus();
        return;
    }
    
    p = /^(010)-?\d{4}-?\d{4}$/;    
    str = f.tel.value;
    if( ! p.test(str) ) {
        alert('전화번호를 입력하세요. ');
        f.tel.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/guest/signup';
    f.submit();
}

function userIdCheck() {
	// 아이디 중복 검사
	let login_id = document.getElementById('login_id').value;
	
	const loginIdInput = document.getElementById('login_id');
	const wrapLoginId = loginIdInput.closest('.wrap-loginId');
	const helpBlock = wrapLoginId.querySelector('.help-block');
	const loginIdValid = document.getElementById('loginIdValid');

	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(login_id)) { 
		let str = '아이디는 <span style="color:red; font-weight: bold;">5~10자</span> 이내이며,'
			+ '첫글자는 <span style="color:red; font-weight: bold;">영문자</span>로 시작해야 합니다.';
		helpBlock.innerHTML = str;		
		loginIdInput.focus();
		return;
	}
	
	const url = '${pageContext.request.contextPath}/member/userIdCheck';
	const params = 'login_id=' + login_id;
	
	const fn = function(data) {
		let passed = data.passed;

		if (passed === 'true') {
			let str = '<span style="color:blue; font-weight: bold;">' + login_id + '</span> 아이디는 사용가능 합니다.';
			helpBlock.innerHTML = str;
			loginIdValid.value = 'true';
		} else {
			let str = '<span style="color:red; font-weight: bold;">' + login_id + '</span> 아이디는 사용할수 없습니다.';
			helpBlock.innerHTML = str;
			loginIdInput.value = '';
			loginIdValid.value = 'false';
			loginIdInput.focus();
		}
	};
	
	const headers = {'Content-Type': 'application/x-www-form-urlencoded'};
	const options = {
			method: 'post',
			headers: headers,
			body: params,
	};
	
	fetch(url, options)
		.then(res => res.json())
		.then(data => fn(data))
		.catch(err => console.log("error:", err));
}

function nicknameCheck() {
	// 닉네임 중복 검사
	let nickname = document.getElementById('nickname').value;
	
	const nicknameInput = document.getElementById('nickname');
	const wrapNickname = nicknameInput.closest('.wrap-nickname');
	const helpBlock = wrapNickname.querySelector('.help-block');
	const nicknameValid = document.getElementById('nicknameValid');

	if(!/^[a-z0-9가-힣ㄱ-ㅎㅏ-ㅣ]{2,10}$/i.test(nickname)) { 
		let str = '닉네임은 <span style="color:red; font-weight: bold;">2~10자</span> 이내이며,'
			+ ' <span style="color:red; font-weight: bold;">한글, 영어, 숫자</span>로만 이루어져야 합니다.';
		helpBlock.innerHTML = str;		
		nicknameInput.focus();
		return;
	}
	
	const url = '${pageContext.request.contextPath}/guest/nicknameCheck';
	const params = 'nickname=' + nickname;
	
	const fn = function(data) {
		let passed = data.passed;

		if (passed === 'true') {
			let str = '<span style="color:blue; font-weight: bold;">' + nickname + '</span> 닉네임은 사용가능 합니다.';
			helpBlock.innerHTML = str;
			nicknameValid.value = 'true';
		} else {
			let str = '<span style="color:red; font-weight: bold;">' + nickname + '</span> 닉네임은 사용할수 없습니다.';
			helpBlock.innerHTML = str;
			nicknameInput.value = '';
			nicknameValid.value = 'false';
			nicknameInput.focus();
		}
	};
	
	const headers = {'Content-Type': 'application/x-www-form-urlencoded'};
	const options = {
			method: 'post',
			headers: headers,
			body: params,
	};
	
	fetch(url, options)
		.then(res => res.json())
		.then(data => fn(data))
		.catch(err => console.log("error:", err));
}


</script>



<footer>
	<jsp:include page="/WEB-INF/views/guest/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/guest/layout/footerResources.jsp"/>

</body>
</html>