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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(function() {
		$("#btnSearch").click(function() {
			if ($("select[name=search_option] option:selected").text() == "선택") {
				swal("분류를 선택하세요");
				return false;
			}
			if ($("#keyword").val() == "") {
				swal("검색어를 입력하세요");
				return;
			}
		});
	});

	function list(page) {
		location.href = "/syLibrary/loanBook_servlet/search.do?cur_page=" + page
				+ "&search_option=${search_option}&keyword=${keyword}";
	}
	
	
	function rebook(l_num) {
		swal_confirm(l_num);
	}
	
	function swal_confirm(l_num) {
	    swal({
	        text: "반납하시겠습니까?",
	        buttons: ["취소", "확인"],
	    }).then(function(isConfirmed) {
	        if (isConfirmed) {
	        	location.href = "/syLibrary/loanBook_servlet/re_book.do?l_num="+l_num;
	        } 
	    });
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
	height: 20px;
	margin: 0rem auto;
	width: 1200px;
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
	<div style="width:1200px;">
	<div class="page-direction" style="padding: 20px; padding-left: 250px;">
		<div class="navi">
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대출반납</span>
			<i class="bi bi-chevron-right"></i> <span style="font-weight: bold;">대출도서
				목록</span>
		</div>
	</div>

	<form name="form1" method="post"
		action="/syLibrary/loanBook_servlet/search.do">
		<div class="search">
			<select id="s_list" id="search_option" name="search_option">
				<c:choose>
					<c:when test="${search_option == null}">
						<option value="none" hidden>선택</option>
						<option value="l_bookid">도서코드</option>
						<option value="b_name">도서명</option>
						<option value="m_name">대출자명</option>
						<option value="l_lodate">대출일</option>
						<option value="l_retdate">반납일</option>
					</c:when>
					<c:when test="${search_option == 'l_bookid'}">
						<option value="none" hidden>선택</option>
						<option value="l_bookid" selected>도서코드</option>
						<option value="b_name">도서명</option>
						<option value="m_name">대출자명</option>
						<option value="l_lodate">대출일</option>
						<option value="l_retdate">반납일</option>
					</c:when>
					<c:when test="${search_option == 'b_name'}">
						<option value="none" hidden>선택</option>
						<option value="l_bookid">도서코드</option>
						<option value="b_name" selected>도서명</option>
						<option value="m_name">대출자명</option>
						<option value="l_lodate">대출일</option>
						<option value="l_retdate">반납일</option>
					</c:when>
					<c:when test="${search_option == 'm_name'}">
						<option value="none" hidden>선택</option>
						<option value="l_bookid">도서코드</option>
						<option value="b_name">도서명</option>
						<option value="m_name" selected>대출자명</option>
						<option value="l_lodate">대출일</option>
						<option value="l_retdate">반납일</option>
					</c:when>
					<c:when test="${search_option == 'l_lodate'}">
						<option value="none" hidden>선택</option>
						<option value="l_bookid">도서코드</option>
						<option value="b_name">도서명</option>
						<option value="m_name">대출자명</option>
						<option value="l_lodate" selected>대출일</option>
						<option value="l_retdate">반납일</option>
					</c:when>
					<c:when test="${search_option == 'l_retdate'}">
						<option value="none" hidden>선택</option>
						<option value="l_bookid">도서코드</option>
						<option value="b_name">도서명</option>
						<option value="m_name">대출자명</option>
						<option value="l_lodate">대출일</option>
						<option value="l_retdate" selected>반납일</option>
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
					<th>도서코드</th>
					<th>도서명</th>
					<th>저자명</th>
					<th>대출자 ID</th>
					<th>대출자명</th>
					<th>대출일</th>
					<th>반납기한</th>
					<th>연장신청 여부</th>
					<th>반납</th>
				</tr>
				<c:choose>
					<c:when test="${dto.size()==0}">
						<tr height="100px" align="center">
							<td colspan="9">일치하는 항목이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="dto" items="${dto}">
							<tr align="center">
								<td>${dto.l_bookid}</td>
								<td>${dto.b_name}</td>
								<td>${dto.b_author}</td>
								<td>${dto.m_id}</td>
								<td width="150px">${dto.m_name}</td>
								<td width="150px">${dto.l_lodate}</td>
								<td width="150px">${dto.l_retdate}</td>
								<td>${dto.l_renew_yn}</td>
								<td width="70px"><input type="button" id="btnRebook"
									value="반납" class="btn text-white"
									style="background-color: #6699CC;"
									onclick="rebook(${dto.l_num})"></td>
							</tr>
						</c:forEach>
						<tr align="center">
							<td colspan="10"><c:if test="${page.curPage>1}">
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
	<c:if test="${result == 'success'}">
		<script>
		swal({
	        text: "반납되었습니다",
	        buttons: {cancel: false, confirm: true,},
	    }).then(function(isConfirmed) {
	        if (isConfirmed) {
	        	location.href = "../loanBook_servlet/list.do";
	        } 
	    });
			
		</script>
	</c:if>
		</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>

