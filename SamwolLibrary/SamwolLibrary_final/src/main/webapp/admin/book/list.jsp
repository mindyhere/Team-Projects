<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(function() {
		$("#btnSearch").click(function() {
			if ($("select[name=search_option] option:selected")
					.text() == "선택") {
				swal("분류를 선택하세요");
				return false;
			}
			if ($("#keyword").val() == "") {
				swal("검색어를 입력하세요");
				return false;
			}
		});
	});

	function list(page) {
		location.href = "/syLibrary/book_servlet/search.do?cur_page=" + page
				+ "&search_option=${search_option}&keyword=${keyword}";
	}
</script>
<style>
html, body {
	height: 100%;
}

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

table {
position: absolute;
	border-collapse: collapse;
	height: 37.8px;
	margin: 0rem auto;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	border: none;
	width: 1000px;
	left: 300px;
}

th {
	padding: 8px;
	text-align: center;
	background-color: #91C8E4;
	height: 37.8px;
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

#s_list {
	font-size: 14px;
	text-align: center;
	height: 36px;
	outline: none;
	width: 100px;
	float: left;
	border: 0;
	color: #3f3f3f;
}
.dd {
padding-left: 20px;
padding-right: 20px;
padding-top: 20px;
padding-bottom: 20px;
}

#hr {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<jsp:include page="../admin_header.jsp" />
	<div id="body-wrapper">
	<div id="body-content">
	<jsp:include page="../menu.jsp" />
	<div style="width:1000px;">
	<div class="page-direction" style="padding: 20px; padding-left: 250px;">
		<div class="navi">
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;도서관리</span> <i class="bi bi-chevron-right"></i>
				<span style="font-weight:bold;">도서목록</span>
		</div>
	</div>

	<form name="form1" method="post"
		action="/syLibrary/book_servlet/search.do">
		<div class="search">
			<select id="s_list" id="search_option" name="search_option">
				<c:choose>
					<c:when test="${search_option == null}">
						<option value="none" hidden>선택</option>
						<option value="b_id">도서번호</option>
						<option value="b_name">도서명</option>
						<option value="b_author">저자명</option>
						<option value="b_pub">출판사</option>
						<option value="b_category">분류</option>
					</c:when>
					<c:when test="${search_option == 'b_id'}">
						<option value="none" hidden>선택</option>
						<option value="b_id" selected>도서번호</option>
						<option value="b_name">도서명</option>
						<option value="b_author">저자명</option>
						<option value="b_pub">출판사</option>
						<option value="b_category">분류</option>
					</c:when>
					<c:when test="${search_option == 'b_name'}">
						<option value="none" hidden>선택</option>
						<option value="b_id">도서번호</option>
						<option value="b_name" selected>도서명</option>
						<option value="b_author">저자명</option>
						<option value="b_pub">출판사</option>
						<option value="b_category">분류</option>
					</c:when>
					<c:when test="${search_option == 'b_author'}">
						<option value="none" hidden>선택</option>
						<option value="b_id">도서번호</option>
						<option value="b_name">도서명</option>
						<option value="b_author" selected>저자명</option>
						<option value="b_pub">출판사</option>
						<option value="b_category">분류</option>
					</c:when>
					<c:when test="${search_option == 'b_pub'}">
						<option value="none" hidden>선택</option>
						<option value="b_id">도서번호</option>
						<option value="b_name">도서명</option>
						<option value="b_author">저자명</option>
						<option value="b_pub" selected>출판사</option>
						<option value="b_category">분류</option>
					</c:when>
					<c:when test="${search_option == 'b_category'}">
						<option value="none" hidden>선택</option>
						<option value="b_id">도서번호</option>
						<option value="b_name">도서명</option>
						<option value="b_author">저자명</option>
						<option value="b_pub">출판사</option>
						<option value="b_category" selected>분류</option>
					</c:when>
				</c:choose>
			</select> <input type="text" id="keyword" name="keyword" value="${keyword}"
				placeholder="검색어를 입력하세요">
			<div class="icon">
				<input type="submit" id="btnSearch" style="display: none;">
				<label for="btnSearch"><svg
						xmlns="http://www.w3.org/2000/svg" width="20" height="20"
						fill="#666666" class="bi bi-search" viewBox="0 0 16 16">
  <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
</svg></label>
			</div>
		</div>
	</form>
	<table border="1">
		<tr align="center" style="color: white; font-size: 17px;">
			<th>도서번호</th>
			<th>도서명</th>
			<th>저자</th>
			<th>출판사</th>
			<th>발행년도</th>
			<th>분류</th>
		</tr>
		<c:choose>
			<c:when test="${dto.size()==0}">
			<tr height="100px" align="center">
			<td colspan="6">일치하는 항목이 없습니다.</td>
			</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="dto" items="${dto}">
					<tr align="center">
						<td><a style="color: black;" href="../book_servlet/edit.do?b_id=${dto.b_id}">${dto.b_id}</a></td>
						<td>${dto.b_name}&nbsp;</td>
						<td>${dto.b_author}</td>
						<td>${dto.b_pub}</td>
						<td width="150px">${dto.b_year}</td>
						<td>${dto.b_category}&nbsp;</td>
					</tr>
				</c:forEach>

				<tr align="center">
					<td colspan="7"><c:if test="${page.curPage>1}">
							<a id="hr" href="#" onclick="list('1')">[처음]</a>
						</c:if> <c:if test="${page.curBlock>1}">
							<a id="hr" href="#" onclick="list('${page.prevPage}')">[이전]</a>
						</c:if> <c:forEach var="num" begin="${page.blockStart}"
							end="${page.blockEnd}">
							<c:choose>
								<c:when test="${num==page.curPage}">
									<span style="color: blue">${num}</span>
								</c:when>
								<c:otherwise>
									<a id="hr" href="#" onclick="list('${num}')">${num} </a>
								</c:otherwise>
							</c:choose>
						</c:forEach> <c:if test="${page.curBlock<page.totBlock}">
							<a id="hr" href="#" onclick="list('${page.nextPage}')">[다음]</a>
						</c:if> <c:if test="${page.curPage<page.totPage}">
							<a id="hr" href="#" onclick="list('${page.totPage}')">[마지막]</a>
						</c:if></td>
				</tr>

			</c:otherwise>
		</c:choose>
	</table>
	</div>
		</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>