<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(function() {
		$("#btnSearch").click(function() {
			if ($("#search").val() == "") {
				swal("검색어를 입력하세요");
				return false;
			}
		});
		$("#btnAll")
				.click(
						function() {
							location.href = "/syLibrary/rebook_servlet/list.do?cur_page="
									+ page;
						});
	});
	function list(page) {
		location.href = "/syLibrary/rebook_servlet/list.do?cur_page=" + page
				+ "&search_option=${search_option}&search=${search}";
	}
</script>
<style>
.search {
	position: relative;
	height: 40px;
	width: 500px;
	border: 2px solid #6699CC;
	border-radius: 30px;
	overflow: hidden;
	left: 300px;
	margin-bottom: 15px;
}

.search>input {
	height: 36px;
	width: 360px;
	font-size: 16px;
	padding: 10px;
	border: 0;
	float: left;
	outline: none;
}

.icon {
	padding-right: 14px;
	float: left;
	padding: 5px;
}

#search_option {
	font-size: 14px;
	text-align: center;
	height: 36px;
	outline: none;
	width: 100px;
	float: left;
	border: 0;
	color: #3f3f3f;
}

/* 테이블행 */
table {
	position: absolute;
	border-collapse: collapse;
	height: 37.8px;
	width: 1000px;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	border: none;
	left: 300px;
}

th {
	padding: 8px;
	text-align: center;
	background-color: #91C8E4;
	height: 20px;
}

td {
	height: 38px;
}
/* 테이블 올렸을 때 */
tbody tr:hover {
	background-color: #d3d3d3;
	opacity: 0.9;
	cursor: pointer;
}

#hr {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<%@ include file="../admin_header.jsp"%>
	
<div id="body-wrapper">
	<div id="body-content">
	<%@ include file="../menu.jsp"%>
	<div style="width:1000px;">
	<div class="page-direction" style="padding: 20px; padding-left: 250px;">
		<div class="navi">
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대출반납</span>
			<i class="bi bi-chevron-right"></i> <span style="font-weight: bold;">예약도서
				목록</span>
		</div>
	</div>

	<nav style="position: static;">
		<form name="form1" method="post"
			action="/syLibrary/rebook_servlet/search.do">
			<div class="search">
				<select id="search_option" name="search_option">
					<c:choose>
						<c:when test="${search_option==null||search_option=='b_name'}">
							<option value="b_name" selected>도서명</option>
							<option value="m_id">예약자ID</option>
							<option value="m_name">예약자명</option>
						</c:when>
						<c:when test="${search_option=='m_id'}">
							<option value="b_name">도서명</option>
							<option value="m_id" selected>예약자ID</option>
							<option value="m_name">예약자명</option>
						</c:when>
						<c:when test="${search_option=='m_name'}">
							<option value="b_name">도서명</option>
							<option value="m_id">예약자ID</option>
							<option value="m_name" selected>예약자명</option>
						</c:when>
					</c:choose>
				</select> <input id="search" name="search" value="${search}">
				<div class="icon">
					<input type="submit" id="btnSearch" style="display: none;">
					<label for="btnSearch"><svg
							xmlns="http://www.w3.org/2000/svg" width="20" height="20"
							fill="#666666" class="bi bi-search" viewBox="0 0 16 16">
  <path
								d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
</svg>
				</div>
			</div>
		</form>

	</nav>
	<table border="1">
		<tr align="center" style="color: white; font-size: 17px;">
			<th>도서코드</th>
			<th>도서명</th>
			<th>저자</th>
			<th>예약자ID</th>
			<th>예약자명</th>
			<th>예약순서</th>
			<th>예약신청일</th>
		</tr>
		<c:forEach var="row" items="${list}">
			<tr align="center">
				<td>${row.r_bookid}</td>
				<td>${row.b_name}</td>
				<td>${row.b_author}</td>
				<td>${row.m_id}</td>
				<td width="150px">${row.m_name}</td>
				<td>${row.r_reservation}</td>
				<td width="150px">${row.r_regdate}</td>

			</tr>
		</c:forEach>
		<tr align="center">
			<td colspan="7"><c:if test="${page.curPage > 1}">
					<a id="hr" href="#" onclick="list('1')">[처음]</a>
				</c:if> <c:if test="${page.curBlock > 1}">
					<a id="hr" href="#" onclick="list('${page.prevPage}')">[이전]</a>
				</c:if> <c:forEach var="num" begin="${page.blockStart}"
					end="${page.blockEnd}">
					<c:choose>
						<c:when test="${num == page.curPage}">
							<span style="color: blue">${num}</span>
						</c:when>
						<c:otherwise>
							<a id="hr" href="#" onclick="list('${num}')">${num}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach> <c:if test="${page.curBlock < page.totBlock}">
					<a id="hr" href="#" onclick="list('${page.nextPage}')">[다음]</a>
				</c:if> <c:if test="${page.curPage < page.totPage}">
					<a id="hr" href="#" onclick="list('${page.totPage}')">[마지막]</a>
				</c:if></td>
		</tr>
	</table>
	</div>
		</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>