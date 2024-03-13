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
<link
	rel="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/syLibrary/include/user.css">
<link rel="stylesheet"
	href="/syLibrary/include/assets/bootstrap.min.css" />
<link rel="stylesheet" href="/syLibrary/include/assets/lineicons.css" />
<link rel="stylesheet"
	href="/syLibrary/include/assets/materialdesignicons.min.css" />
<script>
	//이미지 화면출력
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('url').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('url').src = "";
		}
	}

	// 비밀번호 일치 확인
	function pwCheck() {
		if ($("#pw1").val() == $("#pw2").val()) {
			$("#pwConfirm").text('비밀번호 일치').css('color', 'blue');
		} else {
			$("#pwConfirm").text('비밀번호 불일치').css('color', 'red');
		}
	}

	// 전화번호 형식 체크
	function oninputPhone(mTel) {
		mTel.value = mTel.value.replace(/[^0-9]/g, '').replace(
				/(^02.{0}|^01.{1}|[0-9]{3})([0-9]{4})([0-9]{4})/g, "$1-$2-$3");
	}

	// 주소검색 팝업
	function goPopup() {
		var pop = window.open("/syLibrary/user/member/jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");
	}

	// 주소검색 콜백
	function jusoCallBack(zipNo, roadFullAddr, roadAddrPart1, roadAddrPart2,
			mDetailAddress) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.edit.mZipNo.value = zipNo; //상세 주소
		document.edit.mAddress.value = roadAddrPart1 + roadAddrPart2; //도로명 주소
		document.edit.mDetailAddress.value = mDetailAddress; //상세 주소
	}

	// 회원정보 수정
	function updateInfo() {
		pwCheck();
		swal({
			text : "회원정보를 수정하시겠습니까?",
			buttons : [ "취소", "확인" ],
		}).then(function(isConfirmed) {
			if ($("#pw1").val() == $("#pw2").val()) {
				document.edit.submit();
			} else {
				swal('', '비밀번호가 일치하지 않습니다.', 'warning');
			}
		});
	}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<h3 class="text-bold">
			<img src="../resources/images/edit.png" width="35px" height="35px">
			회원정보 수정
		</h3>
		<hr>
		<div class="container">
			<form name="edit" method="post" enctype="multipart/form-data"
				action="/syLibrary/member_servlet/edit_memberInfo.do">
				<div class="row">
					<div class="col-3"
						style="background-color: #ededed; border-radius: 20px;">
						<div style="text-align: -webkit-center;">
							<div class="profile-image" style="margin-top: 50px;">
								<img id="url" src="../resources/images/member/${dto.m_img}">
								<div class="update-image">
									<input type="file" name="profile" name="mImg"
										onchange="readURL(this);"> <label for=""><i
										class="lni lni-cloud-upload"></i></label>
								</div>
							</div>
							<br>
							<div style="margin-top: 20px;">
								<h4 class="text-bold text-dark mb-10">${sessionScope.mName}</h4>
								<p class="text-sm text-gray">일반회원</p>
							</div>
						</div>
					</div>
					<div class="col-9"
						style="background-color: white; border-radius: 20px; padding: 30px 50px 30px 50px;">
						<div class="input-style-2">
							<label>아이디</label> <input type="text" value="${dto.m_id}"
								readonly>
						</div>
						<div class="input-style-1">
							<label>비밀번호</label> <input type="password"
								value="${dto.m_passwd}" id="pw1" autocomplete="off"
								name="mPasswd" oninput="pwCheck()">
						</div>
						<div class="input-style-1">
							<label>비밀번호 확인</label> <input type="password" id="pw2"
								autocomplete="off" oninput="pwCheck()">
							<p class="text-sm text-gray" id="pwConfirm">비밀번호를 입력해주세요</p>
						</div>

						<div class="input-style-2">
							<label>생년월일</label> <input type="text" name="mBirthDate"
								value="${dto.m_birth_date}" readonly>
						</div>

						<div class="input-style-2">
							<label>가입일</label> <input type="text" name="mYear"
								value="${dto.m_year}" readonly>
						</div>

						<div class="input-style-1">
							<label>전화번호</label> <input type="tel" name="mTel"
								oninput="oninputPhone(mTel)" maxlength="13" value="${dto.m_tel}">
						</div>

						<div class="input-style-1">
							<label>이메일</label> <input type="text" name="mEmail"
								value="${dto.m_email}">
						</div>

						<div class="input-style-1">
							<label>우편번호 <input type="button" id="main-btn"
								onclick="goPopup();" value="주소 검색"
								style="width: auto; height: 20px; margin-left: 10px; text-align: center; line-height: 2px;">
							</label> <input type="text" id=zipNo name="mZipNo"
								value="${dto.m_zip_no}">
						</div>

						<div class="input-style-1">
							<label>주소</label> <input type="text" id=mAddress name="mAddress"
								value="${dto.m_address}">
						</div>

						<div class="input-style-1">
							<label>상세 주소</label> <input type="text" id="mDetailAddress"
								name="mDetailAddress" value="${dto.m_detail_address}">
						</div>

						<div style="text-align: center;">
							<input type="hidden" value="${dto.m_id}" name="mId"> <input
								type="button" value="정보 수정" id="main-btn" onclick="updateInfo()">
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>