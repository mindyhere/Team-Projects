<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalConfirm(icon, title, msg, url){
	Swal.fire({
		title: title,
		html: msg,
		icon: icon,
		showCancelButton: true,
		reverseButtons: true,
		cancelButtonColor: "#C6C7C8",
		confirmButtonText: "YES",
		cancelButtonText: "NO"
		}).then((result) => {
		if (result.isConfirmed) {
			location.href=url;
		}
	});
}

function swalAlert(icon, title, msg){
	Swal.fire({
		icon: icon,
		title: title,
		text: msg,
		confirmButtonText: "OK"
	});
}

function loginCheck(){
	let m_id = "${sessionScope.mId}" != null? "${sessionScope.mId}" : "";
	let a_id = "${sessionScope.a_id}" != null? "${sessionScope.a_id}" : "";
	if (m_id != ""){
		let icon="question";
		let title="잠깐!"
		let msg="본 계정은 통합관리시스템 이용권한이 없습니다.<br>로그아웃 할까요?";
		let url="/syLibrary/login_servlet/logout.do"
		swalConfirm(icon, title, msg, url);
	}else if(a_id != ""){
		location.href="/syLibrary/admin/admin_main.jsp";
	}else {
		location.href="/syLibrary/admin/admin_login.jsp";
	}
}	
</script>
<style>
footer{
z-index:-999;
padding:1rem;
}

/* alert 커스텀 */
.swal2-confirm {
	background-color: #FEC5BB !important;
	border: 1px solid #FEC5BB !important;
	box-shadow: none !important;
	outline:none !important;
	height: 44px;
}
.swal2-deny {
	background-color: #C6C7C8 !important;
	border: 1px solid #C6C7C8 !important;
	box-shadow: none !important;
	outline:none !important;
	height: 44px;
}
</style>
<footer class="d-flex" style="text-align:center;">
<div class="container-fluid">
	<nav class="navbar navbar-sm">
	  <div class="d-flex justify-content" >
		<ul class="nav">	
			<li class="nav-item"><a href="#" class="nav-link px-2 text-muted disabled">© 2024 S LIBRARY.</a></li>
		</ul>
	  </div>
	  <div class="d-flex justify-content-end" >
		<ul class="nav">	
			<!-- 관리자페이지로 이동 -->
			<li class="nav-item"><a href="#" class="nav-link px-2 text-muted" onclick="loginCheck()">통합관리시스템</a></li>
		</ul>
	  </div>
	</nav>
</div>
</footer>
