<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<link rel="stylesheet" href="/syLibrary/include/user.css">
<script>
	$(document).ready(function() {
		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');
			$('ul.tabs li').removeClass('current');
			$('.input-style-tab').removeClass('current');
			$('.input-style-tab').removeClass('required');
			$(this).addClass('current');
			$(this).addClass('required');
			$("#" + tab_id).addClass('current');
		})
	})

	// 전화번호 형식 체크
	function oninputPhone(mTel) {
		mTel.value = mTel.value.replace(/[^0-9]/g, '').replace(
				/(^02.{0}|^01.{1}|[0-9]{3})([0-9]{4})([0-9]{4})/g, "$1-$2-$3");
	}

	// 비밀번호 찾기 버튼 클릭
	function searchPwBtn() {
		let mEmail = $("#mEmail").val();
		let mTel = $("#mTel").val();
		let mId = $("#mId").val();
		let mName = $("#mName").val();
		let mBirthDate = $("#mBirthDate").val();
		if ($('#mId').val() == "") {
			swal('', '아이디를 입력해주세요.', 'warning');
			return false;
		}
		if ($('#mName').val() == "") {
			swal('', '이름을 입력해주세요.', 'warning');
			return false;
		}
		if ($('#mBirthDate').val() == "") {
			swal('', '생년월일을 입력해주세요.', 'warning');
			return false;
		}
		let params = {
			"mEmail" : mEmail,
			"mTel" : mTel,
			"mId" : mId,
			"mName" : mName,
			"mBirthDate" : mBirthDate
		};
		$.ajax({
			url : "/syLibrary/login_servlet/searchPwd.do",
			type : "post",
			data : params,
			success : function(searchPwResult) {
				let data = JSON.parse(searchPwResult);
				if (data.status == 1) {
					swal({
						title : '',
						text : '비밀번호는 "' + data.mPasswd + '" 입니다',
						icon : 'info',
						closeOnClickOutside : false
					}).then(function() {
						location.href = "/syLibrary/user/login/login.jsp";
					});
				} else if (data.status == 2) {
					swal('', '입력하신 정보에 해당하는 계정이 없습니다.', 'warning');
				}
			},
			error : function() {
				swal('에러 발생', '관리자에게 문의바랍니다.', 'error');
			}
		});
	}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container min-vh-100">
		<h3 class="text-bold">
			<img src="/syLibrary/resources/images/login.png" width="35px"
				height="35px"> 비밀번호 찾기
		</h3>
		<hr>
		<p class="text-sm text-gray">비밀번호를 찾으실 방법을 선택해주세요.</p>
		<div class="card-style mb-30">
			<form name="searchPwd" method="post"
				action="/syLibrary/login_servlet/searchPwd.do">
				<div class="tab-area">
					<ul class="tabs">
						<li class="tab-link current" data-tab="tab-1">이메일</li>
						<li class="tab-link" data-tab="tab-2">전화번호</li>
					</ul>
					<div id="tab-1" class="input-style-tab current">
						이메일 <input type="text" name="mEmail" id="mEmail"
							placeholder="이메일을 입력하세요">
					</div>
					<div id="tab-2" class="input-style-tab">
						전화번호 <input type="tel" name="mTel" id="mTel"
							oninput="oninputPhone(mTel)" placeholder="숫자만 입력하세요"
							maxlength="13">
					</div>
					<div class="input-style-1">
						<label>아이디</label> <input type="text" name="mId" id="mId"
							placeholder="아이디를 입력하세요" required>
					</div>
					<div class="input-style-1">
						<label>이름</label> <input type="text" name="mName" id="mName"
							placeholder="이름을 입력하세요" required>
					</div>
					<div class="input-style-1">
						<label>생년월일</label><input type="date" id="mBirthDate"
							name="mBirthDate" placeholder="생년월일" required>
					</div>
				</div>
				<div style="text-align: center;">
					<input type="button" value="비밀번호 찾기" id="main-btn"
						onclick="searchPwBtn()">
				</div>
			</form>
		</div>
	</div>
</body>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>