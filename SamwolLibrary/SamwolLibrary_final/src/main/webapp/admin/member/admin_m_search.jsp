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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
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
	$("#btnAll").click(function() {
		return;
	});
});

function ad_list() {
/* 	let m_name = $("#m_name").val();
	let m_birth_date = $("#m_birth_date").val();
	let m_id = $("#m_id").val();
	let m_tel = $("#m_tel").val();
	let m_year = $("#m_year").val();
	 let num = ${"#num"}.val(); */
	
	/* let params = {"m_name": m_name,"m_birth_date":m_birth_date,"m_id":m_id,"m_tel":m_tel,"m_year":m_year}; */
	let params={"search_option": $("#search_option").val(), "search":$("#search").val(),"num":$("#num")};
	$.ajax({
		url :"/syLibrary/admember_servlet/search.do",
		data : params,
		success : function(txt) { //작업종료
			$("#result").html(txt);
/* 			list();
			$("#m_name").val("");
			$("#m_birth_date").val("");
			$("#m_id").val("");
			$("#m_tel").val("");
			$("#m_year").val(""); */
		}
	});
}

function slist(m_no){
	location.href="/syLibrary/admember_servlet/ad_list_detail.do?m_no=" + m_no;
}
function list(page){
	location.href="/syLibrary/admember_servlet/search.do?cur_page="+page+"&search_option=${search_option}&search=${search}";
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
  margin: 0rem auto;
  height: 20px;
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
<%@ include file="../admin_header.jsp" %>
<div id="body-wrapper">
	<div id="body-content">
			<jsp:include page="/admin/menu.jsp" />

<div style="width:1000px;">
<div class="page-direction" style="padding: 20px; padding-left: 250px;">
	<div class="navi">
			<span style="font-weight:bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;회원정보</span>
	</div>
</div>

	<nav style="position: static; padding-left: 300px;">
			<form name="form1" method="post" action="/syLibrary/admember_servlet/search.do">
			<div class="search" style="text-color: white;">
			<select id="search_option" name="search_option">
				<c:choose>
					<c:when test="${search_option==null||search_option=='m_name'}">
						<option value="m_name" selected>이름</option>
						<option value="m_birth_date">생년월일</option>
						<option value="m_id">아이디</option>
						<option value="m_tel">전화번호</option>
						<option value="m_year">가입일</option>
					</c:when>
					<c:when test="${search_option=='m_birth_date'}">
						<option value="m_name">이름</option>
						<option value="m_birth_date" selected>생년월일</option>
						<option value="m_id">아이디</option>
						<option value="m_tel">전화번호</option>
						<option value="m_year">가입일</option>
					</c:when>
					<c:when test="${search_option=='m_id'}">
						<option value="m_name">이름</option>
						<option value="m_birth_date">생년월일</option>
						<option value="m_id" selected>아이디</option>
						<option value="m_tel">전화번호</option>
						<option value="m_year">가입일</option>
					</c:when>
					<c:when test="${search_option=='m_tel'}">
						<option value="m_name">이름</option>
						<option value="m_birth_date">생년월일</option>
						<option value="m_id">아이디</option>
						<option value="m_tel" selected>전화번호</option>
						<option value="m_year">가입일</option>
					</c:when>
					<c:when test="${search_option=='m_year'}">
						<option value="m_name">이름</option>
						<option value="m_birth_date">생년월일</option>
						<option value="m_id">아이디</option>
						<option value="m_tel">전화번호</option>
						<option value="m_year" selected>가입일</option>
					</c:when>
				</c:choose>
			</select>
				<input id="search" name="search" value="${search}">
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
		 	<th>이름</th>
		 	<th>생년월일</th>
		 	<th>아이디</th>
		 	<th>전화번호</th>
		 	<th>가입일</th>
		 	<th>&nbsp;</th>
	</tr>
	<c:choose>
			<c:when test="${list.size()==0}">
			<tr height="100px" align="center">
			<td colspan="6">일치하는 항목이 없습니다.</td>
			</tr>
			</c:when>
			<c:otherwise>
	<c:forEach var="row" items="${list}">
		    <tr align="center">
			  	<td width="150px">${row.m_name}</td>
				<td width="150px">${row.m_birth_date}</td>
			   	<td>${row.m_id}</td>
			   	<td width="200px">${row.m_tel}</td>
				<td width="150px">${row.m_year}</td>
 				<td width="70px">
 					<input type="button" value="상세" class="btn text-white" style="background-color: #6699CC;" onclick="slist(${row.m_no});">
				</td>
			</tr>
	 </c:forEach>

	<tr align="center">
			<td colspan="7">
				<c:if test="${page.curPage > 1}">
					<a id="hr" href="#" onclick="list('1')">[처음]</a>
				</c:if>
				<c:if test="${page.curBlock > 1}">
					<a id="hr" href="#" onclick="list('${page.prevPage}')">[이전]</a>
					<a id="hr" href="#" onclick="slist(${row.m_no}); mlist(${row.m_no});">상세</a>
				</c:if>
				<c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
					<c:choose>
						<c:when test="${num == page.curPage}">
							<span style="color:blue">${num}</span>
						</c:when>
						<c:otherwise>
							<a id="hr" href="#" onclick="list('${num}')">${num}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${page.curBlock < page.totBlock}">
					<a id="hr" href="#" onclick="list('${page.nextPage}')">[다음]</a>
				</c:if>
				<c:if test="${page.curPage < page.totPage}">
					<a id="hr" href="#" onclick="list('${page.totPage}')">[마지막]</a>
				</c:if>
			</td>
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