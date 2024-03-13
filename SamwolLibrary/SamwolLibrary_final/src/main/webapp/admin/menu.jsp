<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>


html, body {
	height: 100%;
}

.menu {
	background-color: #B9D9EB;
	width: 225px;
	margin: 0;
	position: absolute;
	height: 100%;
	float: left;
	padding-right: 20px;
}

.menu>.big_menu li {
	display: block;
	color: #000;
	font_size: 20px;
	font-weight: bold;
	padding-top: 15px;
}

.sub_menu li {
	list-style: none;
	display: block;
	color: #000;
	font_size: 20px;
	margin-left: 14px;
}

#menu_a {
	text-decoration: none;
	color: black;
}
</style>
<body>
	<div class="menu">
		<ul class="big_menu">
			<li><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
				  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783"/>
				</svg>&nbsp;도서 관리</li>
		</ul>
		<ul class="sub_menu">
			<li><a id="menu_a" href="/syLibrary/book_servlet/list_all.do">도서 목록</a><br></li>
			<li><a id="menu_a" href="/syLibrary/book_servlet/select_cg.do">도서 등록</a><br></li>
		</ul>
		<ul class="big_menu">
			<li><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left-right" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M1 11.5a.5.5 0 0 0 .5.5h11.793l-3.147 3.146a.5.5 0 0 0 .708.708l4-4a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 11H1.5a.5.5 0 0 0-.5.5m14-7a.5.5 0 0 1-.5.5H2.707l3.147 3.146a.5.5 0 1 1-.708.708l-4-4a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 4H14.5a.5.5 0 0 1 .5.5"/>
				</svg>&nbsp;대출 반납</li>
		</ul>
		<ul class="sub_menu">
			<li><a id="menu_a" href="/syLibrary/record_servlet/list.do">대출/반납 목록</a><br>
				<a id="menu_a" href="/syLibrary/loanBook_servlet/list.do">대출 도서 관리</a><br>
				<a id="menu_a" href="/syLibrary/rebook_servlet/list.do">예약 도서 목록</a><br></li>
		</ul>
		<ul class="big_menu">
			<li><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-bar-chart-line" viewBox="0 0 16 16">
				  <path d="M11 2a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v12h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h1V7a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7h1zm1 12h2V2h-2zm-3 0V7H7v7zm-5 0v-3H2v3z"/>
				</svg>&nbsp;도서 통계</li>
		</ul>
		<ul class="sub_menu">
			<li><a id="menu_a" href="/syLibrary/admin/loan_chart.jsp">주간 도서 대출량</a><br></li>
			<li><a id="menu_a" href="/syLibrary/admin/ct_chart.jsp">월간 분류별 대출량</a><br></li>
		</ul>
		<ul class="big_menu">
			<li><a style="text-decoration: none; color: black; font-weight:bold;" href="/syLibrary/admember_servlet/list.do"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16">
				  <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1zm-7.978-1L7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002-.014.002zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0M6.936 9.28a6 6 0 0 0-1.23-.247A7 7 0 0 0 5 9c-4 0-5 3-5 4q0 1 1 1h4.216A2.24 2.24 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816M4.92 10A5.5 5.5 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0m3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4"/>
				</svg>&nbsp;회원 정보</a></li>
		</ul>
	</div>
</body>
</html>