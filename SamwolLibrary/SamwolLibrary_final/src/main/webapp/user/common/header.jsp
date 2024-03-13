<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>3월에 만나요:)</title>

<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<link rel="stylesheet" href="/syLibrary/include/user.css">
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script src="/syLibrary/include/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--  폰트 적용  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<style>
* {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	font-style: normal;
}

body {
	-ms-overflow-style: none;
}

::-webkit-scrollbar {
	display: none;
}

.navbar {
	padding: 0;
}

.nav-item {
	margin-right: 15px;
}

/* .nav-item:hover .dropdown-menu .dropdown-menu-end {
	display: block;
	margin-top: 0;
} */
</style>
<body>
	<nav class="navbar navbar-expand-lg" style="background-color: #FBFBFD;">
		<div class="container-fluid">
			<a class="navbar-brand" href="/syLibrary/main/index.jsp"> <img
				src="/syLibrary/resources/images/icon.png" width="60px"
				height="60px"> <b> 3월 도서관</b>
			</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDarkDropdown"
				aria-controls="navbarNavDarkDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNavDropdown">
				<div class="navbar-nav">
					<c:choose>
						<c:when
							test="${sessionScope.mName != null && sessionScope.a_id == null}">
							<div class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" role="button"
									data-bs-toggle="dropdown" aria-expanded="false">마이 페이지</a>
								<div
									class="dropdown-menu dropdown-menu-end">
									<div>
										<a class="dropdown-item"
											href="/syLibrary/member_servlet/detail_memberInfo.do?mId=${sessionScope.mId}">회원정보
											수정</a>
									</div>
									<div class="dropdown-divider"></div>
									<div>
										<a class="dropdown-item"
											href="/syLibrary/myLibrary_servlet/myLibray_info.do?mId=${sessionScope.mId}">나의
											서재</a>
									</div>
									<div class="dropdown-divider"></div>
									<div>
										<a class="dropdown-item"
											href="/syLibrary/login_servlet/logout.do">로그아웃</a>
									</div>
								</div>
							</div>
						</c:when>

						<c:when
							test="${sessionScope.mName == null && sessionScope.a_id != null}">
							<div class="nav-item">
								<a class="nav-link" href="/syLibrary/admin/admin_main.jsp"
									title="사서 통합관리시스템">${sessionScope.a_name }
									님&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
							</div>
							<div class="nav-item">
								<a class="nav-link" href="/syLibrary/login_servlet/logout.do">관리자계정
									로그아웃</a>
							</div>
						</c:when>

						<c:otherwise>
							<div class="nav-item">
								<a class="nav-link" href="/syLibrary/user/login/login.jsp">로그인</a>
							</div>
							<div class="nav-item">
								<a class="nav-link" href="/syLibrary/user/member/join.jsp">회원가입</a>
							</div>
						</c:otherwise>
					</c:choose>

					<div class="nav-item">
						<a class="nav-link" href="/syLibrary/user/search/search.jsp">자료찾기</a>
					</div>
					<div class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" role="button"
							id="dropdownMenu2" data-bs-toggle="dropdown"
							aria-expanded="false">이용안내</a>
						<div class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenu2">
							<div>
								<a class="dropdown-item" href="/syLibrary/user/info/guide.jsp">대출/반납/예약</a>
							</div>
							<div class="dropdown-divider"></div>
							<div>
								<a class="dropdown-item" href="/syLibrary/user/info/map.jsp">도서관
									오는길</a>
							</div>
							<div class="dropdown-divider"></div>
							<div>
								<a class="dropdown-item" href="/syLibrary/user/info/sitemap.jsp">사이트맵</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>
</body>