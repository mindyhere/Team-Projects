<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3월에 만나요:)</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet" href="../include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../include/js/bootstrap.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto Sans Korean&display=swap"
	rel="stylesheet">
	
<c:if test="${param.message=='error'}">
	<script>
		$(function(){
			swal("관리자 아이디 또는 비밀번호가 일치하지 않습니다.");
		});
	</script>
</c:if>
<c:if test="${param.message=='logout'}">
	<script>
		alert("로그아웃 되었습니다.");
	</script>
</c:if>
<script>
$(function() {
	$("#btnlogin").click(function() {
		if ($("#a_id").val() == "") {
			alert("아이디를 입력하세요.");
			return false;
		} else ($("#a_passwd").val() == "") {
			alert("비밀번호를 입력하세요.");
			return false;
		}
	});
});
</script>
<style>

html, body {
	height: 100%;
}

* {
	font-family: "Noto Sans Korean", sans-serif;
	font-weight: 400;
	font-style: normal;
}
Header {  
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  
  height: 75px;
  padding: 1rem;
  color: white;
  background: #6699CC;
  font-weight: bold;
  font-size: 30px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.form-signin{
    max-width: 350px;
    position: absolute;
    width: 100%;
    padding-top: 10px;
    height: 200px;
    top: 400px; /* 전체 높이 위에서부터 절반 */
    left: 50%; /* 전체 넓이 왼쪽에서부터 절반 */
    transform: translate(-50%, -50%); /* 해당 요소의 높이, 넓이의 절반만큼 돌아가기 */
  	border: 1px solid white;
  	box-shadow: 0 2px 5px rgba(0,0,0,.25);
  }
table {
  border-spacing: 5px;
  border-collapse: separate;
  line-height: 120%;
}
  
</style>
</head> 
<body>
<header>
	<nav>
		<div class="container-fluid">
			<a class="navbar-brand" href="#">
				<svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
				  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783"/>
				</svg>
				<a>Manager</a>
			</a>
		</div>
	</nav>
		<div align="right" style="position: static;">
			<a class="navbar-brand" href="/syLibrary/main/index.jsp">
				<input type="button" value="이용자페이지" class="btn btn-outline-light">
			</a>
		</div>
</header>
<div id="body-wrapper">
	<div id="body-content">
<main id="login" class="form-signin">
		<h2 align="center">관리자 로그인</h2>
			<form method="post" name="form1" action="/syLibrary/admin_servlet/adlogin.do">
				<table align="center">
				<tr>
					<td align="center" width="110px">아이디</td>
					<td width="160px"><input type="text" id="a_id" name="a_id" class="form-control"></td>
				</tr>
				<tr>
					<td align="center" width="110px">비밀번호</td>
					<td width="160px"><input id="a_passwd" type="password" name="a_passwd" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<input type="submit" id="btnlogin" value="로그인" class="btn btn-dark">
					</td>
				</tr>
				</table>
			</form>
</main>
	</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>