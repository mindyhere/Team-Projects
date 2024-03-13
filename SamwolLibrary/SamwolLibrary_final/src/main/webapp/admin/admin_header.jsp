<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3월에 만나요:)</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"type="image/x-icon">
<link rel="icon" href="../resources/images/sist.png" type="image/x-icon">
<link rel="stylesheet" href="../include/css/bootstrap.css">
<script src="/syLibrary/include/js/bootstrap.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto Sans Korean&display=swap"
	rel="stylesheet">
<style>
* {
	font-family: "Noto Sans Korean", sans-serif;
	font-weight: 400;
	font-style: normal;
}
form { margin: 0; padding: 0; }
Header {  
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
.lo {
  font-family: "Noto Sans Korean", sans-serif;
  font-size: 20px;
  font-weight: bold;
}
::-webkit-scrollbar {
	display: none;
}
/* 화면 625px이하일때 설정 */
@media screen and (max-width: 625px) {
  
   .aa {
    display : none;
  }
  
   .lo {
    display : none;
  }
}
</style>
<script>

 function logout(){
    swal({
        text: "로그아웃 하시겠습니까?",
        buttons: ["취소", "확인"],
    }).then(function(isConfirmed) {
        if (isConfirmed) {
        	/* location.href = "/syLibrary/admin_servlet/adLogout.do"; */
        	location.href = "../admin/admin_login.jsp";
        } 
    });
}

/* $(function() {
	$("#logout").click(function() {
	    swal({
	        text: "로그아웃 하시겠습니까?",
	        buttons: ["취소", "확인"],
	    }).then(function(isConfirmed) {
	        if (isConfirmed) {
	        	location.href = "/syLibrary/admin_servlet/adLogout.do";
	        } 
	    });
	});
}); */

</script>
</head>
<body>
<header>
	<nav>
		<div>
			<a id="aa" class="navbar-brand" href="/syLibrary/admin/admin_main.jsp">
				<svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
				  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783"/>
				</svg>
				<a>Manager</a>
			</a>
		</div>
	</nav>

	<div class="lo"><%=session.getAttribute("result") %></div>

	<!-- <form method="post" name="form2" action="/syLibrary/admin_servlet/adlogout.do"> -->

		
		<div align="right" style="position: static;">
			<a class="navbar-brand" href="/syLibrary/main/index.jsp">
				<input type="button" value="이용자페이지" class="btn btn-outline-light">
			</a>
			<a class="navbar-brand"  href="#">
				<input type="submit" value="logout" class="btn btn-outline-light" onclick="logout()">
			</a>
		</div>

	<!-- </form> -->
</header>
</body>
</html>