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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(function() {
		$("#btnSearch")
				.click(
						function() {
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
		$("#ca").click(function() {
			const modal = document.getElementById("modal");
			modal.style.display = "none";
		});
		$("#btnEmail").click(function() {
			let receive_mail = $("#receive_mail").val();
			let subject = $("#subject").val();
			let message = $("#message").val();
			$.ajax({
				type : "post",
				url : "email_servlet/send.do",
				data : {
					"receive_mail" : receive_mail,
					"subject" : subject,
					"message" : message
				},
				success : function() {
					swal('전송되었습니다');
					const modal = document.getElementById("modal");
					modal.style.display = "none";
				}
			});
		});
		$('.select').selectpicker();
	});

	function list(page) {
		location.href = "/syLibrary/record_servlet/search.do?cur_page=" + page
				+ "&search_option=${search_option}&keyword=${keyword}";
	}

	function modal() {
		const modal = document.getElementById("modal")
		modal.style.display = "flex"
	}
	
	$(document).mouseup(function (e){
		var LayerPopup = $("#modal-window");
		if(LayerPopup.has(e.target).length === 0){
			const modal = document.getElementById("modal");
			modal.style.display = "none";
		}
	});
	
	function mail(l_num) {
		$.ajax({
			type : "post",
			url : "record_servlet/email.do",
			data : {
				"l_num" : l_num
			},
			dataType : "json",
			success : function(data) {
				modal();
				$("#receive_mail").val(data.data);
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
	height: 37.8px;
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
	height: 37.8px;
}

td {
	height: 38px;
}

#m_form>input[type=text] {
	border-left: 0;
	border-right: 0;
	border-top: 0;
	border-bottom: 1px solid black;
	outline: none;
	padding: 5px;
}

#m_form>input[type=text]:focus {
	border-bottom: 1px solid #6699CC;
	background-color: #f1f3f5;
	border-radius: 5px;
	
}

#m_form>textarea:focus {
	background-color: #f1f3f5;
	border-radius: 5px;
	outline: none;
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

#modal.modal-overlay {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
	display: none;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	background: rgba(255, 255, 255, 0.25);
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
	backdrop-filter: blur(1.5px);
	-webkit-backdrop-filter: blur(1.5px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
}

#modal .modal-window {
	background: white;
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
	backdrop-filter: blur(13.5px);
	-webkit-backdrop-filter: blur(13.5px);
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.18);
	width: 400px;
	height: 400px;
	position: relative;
	top: -100px;
	padding: 10px;
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

#modal .title {
	padding-left: 10px;
	display: inline;
	text-shadow: 1px 1px 2px gray;
	color: black;
}

#modal .title h3 {
	display: inline;
}

#modal .close-area {
	display: inline;
	float: right;
	padding-right: 10px;
	cursor: pointer;
	text-shadow: 1px 1px 2px gray;
	color: black;
}

#modal .content {
	padding-left: 10px;
	text-shadow: 1px 1px 2px gray;
}

#hr {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<div id="container">
		<jsp:include page="../admin_header.jsp" />
		<div id="body-wrapper">
	<div id="body-content">
		
		<jsp:include page="../menu.jsp" />
		<div style="width:1200px;">

		<div class="page-direction" style="padding: 20px; padding-left: 250px;">
		<div class="navi">
				<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대출반납</span> <i class="bi bi-chevron-right"></i>
				<span style="font-weight:bold;">대출/반납 목록</span>
		</div>
		</div>
		
		<form name="form1" method="post"
			action="/syLibrary/record_servlet/search.do">
			<div class="search">
				<select id="s_list" id="search_option" name="search_option">
					<c:choose>
						<c:when test="${search_option == null}">
							<option value="none" hidden>선택</option>
							<option value="l_bookid">도서코드</option>
							<option value="b_name">도서명</option>
							<option value="m_id">대출자 ID</option>
							<option value="l_lodate">대출일</option>
							<option value="l_retdate">반납일</option>
						</c:when>
						<c:when test="${search_option == 'l_bookid'}">
							<option value="none" hidden>선택</option>
							<option value="l_bookid" selected>도서코드</option>
							<option value="b_name">도서명</option>
							<option value="m_id">대출자 ID</option>
							<option value="l_lodate">대출일</option>
							<option value="l_retdate">반납일</option>
						</c:when>
						<c:when test="${search_option == 'b_name'}">
							<option value="none" hidden>선택</option>
							<option value="l_bookid">도서코드</option>
							<option value="b_name" selected>도서명</option>
							<option value="m_id">대출자 ID</option>
							<option value="l_lodate">대출일</option>
							<option value="l_retdate">반납일</option>
						</c:when>
						<c:when test="${search_option == 'm_id'}">
							<option value="none" hidden>선택</option>
							<option value="l_bookid">도서코드</option>
							<option value="b_name">도서명</option>
							<option value="m_id" selected>대출자 ID</option>
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
				<th>출판사명</th>
				<th>대출자 ID</th>
				<th>대출일</th>
				<th>반납일</th>
				<th>반납 여부</th>
				<th><a style="text-decoration: under; color: white;"
					href="/syLibrary/record_servlet/order.do">연체일</a></th>
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
							<td>${dto.b_name}&nbsp;</td>
							<td>${dto.b_author}</td>
							<td>${dto.b_pub}</td>
							<td>${dto.m_id}</td>
							<td width="150px">${dto.l_lodate}</td>
							<td>${dto.l_retdate}</td>
							<td><c:choose>
									<c:when test="${dto.l_return_yn == 'Y'}">
							반납 완료
						</c:when>
									<c:otherwise>
							미반납
						</c:otherwise>
								</c:choose></td>
							<td><input type="hidden" id="l_num" name="l_num"
								value="${dto.l_num}">
								<c:if test="${dto.l_over > 0 && dto.l_return_yn == 'N'}">
									<a id="hr" href="#"><span id="btnModal" onclick="mail(${dto.l_num})" style="color: red">${dto.l_over}</span></a>
								</c:if></td>
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
	<div id="modal" class="modal-overlay">
		<div class="modal-window" id="modal-window">
			<div class="title">
				<h3>연체자 이메일 전송</h3>
			</div>
			<div class="close-area" id="ca">X</div><hr/>
			<div class="content">
				<form id="m_form" method="post"
					action="/syLibrary/email_servlet/send.do">
					<span style="color: #26262b">받는 사람</span> <input type="text" id="receive_mail" name="receive_mail"><br>
					<span style="color: #26262b">제목</span> <input type="text" id="subject" name="subject"><br><br>
					<textarea rows="5" cols="40" id="message" name="message"
						placeholder="내용" ></textarea>
					<br>
					<div align="center">
					<input type="submit" class="btn text-white" style="background-color: #6699CC;" id="btnEmail" value="전송">
					</div>
				</form>
			</div>
		</div>
		</div>
			</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
		
	</div>
</body>
</html>