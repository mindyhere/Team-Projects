<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/user.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script>
"use strict"; 
$(function() {
	$("input[type='text']").keydown(function(){
		if(event.keyCode===13){
			event.preventDefault();
		}
	});
	
/* 	$("li[name='btnOpen']").click(function(){
		openModal();
	}); */
});

function formCheck() {
	let form = $("form[name=form1]");
    let keyword	= $("input[name=keyword]");
    let view	= $("input[name=view]").val();
	if(keyword.val() == "" || keyword.val().trim().length==0 ){
		Swal.fire({
			icon: "warning",
			title: "잠깐!",
			text: "검색어를 입력해주세요.",
			confirmButtonText: "OK"
		});
		$('#keyword').val("");
		keyword.focus();
		return false;
	}
	form.submit();
}

function showTableList(){
	$.ajax({
		url:"/syLibrary/home/showTableList.do",
		success:function(txt){
			$("#modal-body").html(txt);
		}
	});
}
function openModal(){
	$('.modal-bg').removeClass("invisible");
	$('.modal-bg').addClass("visible");
	$.ajax({
		type:"post",
		url:"/syLibrary/home/showTableList.do",
		success:function(){
			showTableList();
		}
	});
}
function closeModal(){
	Swal.fire({
		title: "잠깐!",
		text: '추천도서목록 편집을 종료할까요?',
		icon: "question",
		showDenyButton: true,
		reverseButtons: true,
		confirmButtonText: "YES",
		denyButtonText: "NO"
		}).then((result) => {
		if (result.isConfirmed) {
			$('.modal-bg').removeClass("visible");
			$('.modal-bg').addClass("invisible");
			location.reload();
		} else if (result.isDenied) {
			return false;
		}
	});
}
</script>

<style>
/* 기본 페이지 레이아웃 */
body {
	background: #fbf7f5 !important;
}
div {
	box-sizing: border-box;
}
.wrap-all { 
	height: 100%;
	min-width: 540px;
	min-height: 405px;
	margin: auto;
}
.wrap-all > div {
	width: 100%;
}
#header {
	height: 15%;
}
#section-main {
	height: 75%;
}
#footer {
	height: 10%;
	margin-bottom:auto;
}

/* 개별요소 */
#section1 {
	min-height:70%;
	background-image: url("/syLibrary/resources/images/bg1.jpg");
	opacity: 0.5;
	padding: 10%;
	justify-content: center;
	align-items: center;
}

#keyword, #btnSearch {
	border-color:#FAE0E0;
	outline: none;
}

/* 추천탭 */
#section2{
margin: 0 1% 0 1%;
}
.col {
	align-content: center;
	padding: 0.5em;
}
.col .card{
	cursor: pointer;
}
.card #bookCover {
	border-radius: 0px 0px 5px 5px;
	position: absolute; left: 0; bottom: 0;
	background: rgba(0,0,0,0.5);
	width: 100%;
	padding: 15px;
	box-sizing: border-box;
	opacity: 0;
	transition: opacity 0.35s ease-in-out;
}
.col > img{
	width: 158px;
	height: 240px;
}
#book:hover #bookCover {
	border-radius: 0px 0px 5px 5px;
	opacity: 1;
}
.card .card-body h5 {
	padding-bottom: 0.4em;
	color:#FFFFFF !important;
	overflow:hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-transform: uppercase;
	text-align: left;
}
.card .card-body h6 {
	font-size: small;
	color:#FFFFFF !important;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-transform: uppercase;
	text-align: left;
}
#optionTab .nav-link{
	color: #212529BF;
}
#optionTab .active{
 	color: #000;
	font-weight:bold;
}

/* 모달페이지 */
.modal-bg {
	position: fixed;
	display: flex;
	justify-content: center;
	padding: 10%;
	top: 0;
	left: 0;
	width: 100%; 
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
	transition : all 1s;
	z-index: 999;
	transition : opacity 0.5s ease;
}
.modal-body {
	box-sizing: border-box;
	position: absolute;
	top: 50%; 
	min-width: 850px !important;
	min-height: 700px !important;
	align-items: center;
	justify-content: center;
	text-align: center;
	background-color: #fbf7f5 !important;
	border-radius: 7px !important;
	box-shadow: 0 1px 7px rgba(0, 0, 0, 0.5); 
	transform: translateY(-50%); 
}
.modal-bg.visible {
	visibility: visible;
	opacity : 1;
	display: block;
	transition : all 0.5s;
}
.invisible {
	display: none;
	z-index: -999;
	opacity : 0;
	transition : all 0.5s;
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
</head>


<body>
<!-- wrap-all -->
<div class="wrap-all d-flex-col">

<div id="header"><%@ include file="../common/header.jsp"%></div>

<!-- section-main -->
<div id="section-main" class="d-flex-col min-vh-100">
	<!-- section1 검색창 -->
	<div id="section1" class="input-group mb-3">
		<form class="d-flex input-group" style="width:100%;" id="form1" name="form1" method="post" action="/syLibrary/search_servlet/search.do">
			<input id="keyword" name="keyword" type="text" class="form-control" placeholder="검색어를 입력하세요" style="box-shadow: none !important;">
			<input id="option" name="option" type="hidden" class="form-control" value="all" >
			<input id="view" name="view" type="hidden" class="form-control" value="view1">
			<button class="btn btn-light" type="button" id="btnSearch" onclick="formCheck()" style="background-color:#FEC5BB !important;">
				<i class="bi bi-search"></i>
			</button>
		</form>
	</div><!-- section1 끝 -->
	
	<!-- section2 추천도서탭-->
	<div id="section2">
	
	  <!-- recommend -->
	  <div id="recommend" class="card text-center">
		<!-- optionTab-header -->
		<div id="optionTab" class="card-header" style="background-color:#f1d59838;">
			<ul name="tabList"class="nav nav-tabs card-header-tabs">
				<c:choose>
				  <c:when test="${opt == 'opt1' || opt == null }">
					<li class="nav-item" name="opt1" onclick="changeTab('opt1')">
					  <a class="nav-link active" aria-current="true" href="#">대출이 많은 책</a>
					</li>
					<li class="nav-item" name="opt1" onclick="changeTab('opt2')">
					  <a class="nav-link" href="#">이달의 책</a>
					</li>
				  </c:when>
				  <c:when test="${opt == 'opt2' }">	
					<li class="nav-item" name="opt1" onclick="changeTab('opt1')">
					  <a class="nav-link" aria-current="true" href="#">대출이 많은 책</a>
					</li>
					<li class="nav-item" name="opt1" onclick="changeTab('opt2')">
					  <a class="nav-link active" href="#">이달의 책</a>
					</li>
				  </c:when>
				</c:choose>	
				<c:if test="${sessionScope.mName == null && sessionScope.a_id != null}">
					<li class="nav-item" id="btnOpen" name="btnOpen">
					  <a class="nav-link" href="#" onclick="openModal()">EDIT<i class="bi bi-magic"></i></a>
					</li>
				</c:if>
			</ul>
		</div> <!-- optionTab-header 끝 -->  
	
		<!-- optionTab-body -->
		<div class="card-body" style="background-color:#FFFFFF;">
			<!-- container-md -->
			<div class="container-md">
			  <div class="d-flex justify-content-around">
				<div id="row" class="row"> <!-- row -->
					<c:forEach var="dto" items="${list }">
						<div class="col">
							<a href="/syLibrary/search_servlet/bookInfo.do?b_id=${dto.b_id}">
							<div class="card" id="book" style="width: 10em">
								<img src="${dto.b_url}" class="card-img" alt="준비중" title="more detail">
								<div class="card-body" id="bookCover">
									<input type="hidden" name="b_id" value="${dto.b_id }">
									<h5 class="card-title" style="color:white">${dto.b_name }</h5>
									<h6>${dto.b_author }</h6>
								</div>
							</div>
							</a>
						</div>
					</c:forEach> 
				</div> <!-- row 끝 -->
			  </div>
			</div> <!-- container-md 끝 -->
		</div> <!-- optionTab-body 끝 -->
	  </div> <!-- recommend 끝-->
	
	<script>
	function changeTab(opt) {
		$.ajax({
			url:"/syLibrary/home/list.do",
			data:{"opt":opt},
			success:function(txt){
				$("#recommend").html(txt);
			}
		});
	}
	</script>
	</div><!-- section2 끝-->

</div><!-- section-main 끝 -->

<div class="modal-bg invisible">
	<div class="modal-body" id="modal-body"></div> <!-- modal-body 끝 -->
</div> <!-- modal-bg 끝 -->

<div id="footer"><%@ include file="../common/footer.jsp"%></div>

</div><!-- wrap-all 끝 -->

</body>
</html>