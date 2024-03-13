<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
$(function() {
	$("#btnSearch").click(function() {
		let form1 = $("form[name=form1]");
        let keyword	= $("input[name=keyword]");
		if(keyword.val() == "" || keyword.val().trim().length==0 ){
			myAlert("warning", "잠깐!", "검색어를 입력해주세요.");
			$('#keyword').val("");
			keyword.focus();
			return false;
		}
		form1.submit();
	});
	$("#btnDetail").click(function() {
		let form2 = $("form[name=form2]");
	    let b_name	= $("input[name=b_name]");
	    let b_author= $("input[name=b_author]");
	    let b_pub	= $("input[name=b_pub]");
	    if(b_name.val()=="" && b_author.val()=="" && b_pub.val()==""){
	    	myAlert("warning", "잠깐!", "검색어를 입력해주세요.");
    		b_name.focus();
    		return false;
	    }
	    form2.submit();
	}); 

	// 상세검색창 토글버튼
	$("#btnShow").click(function() {
		$(".searchForm2").slideDown("fast");
		$("#btnShow").hide();
		$("#btnHide").show();
	});
	$("#btnHide").click(function() {
		$(".searchForm2").slideUp("fast");
		$("#btnShow").show();
		$("#btnHide").hide();
	});
});

function myAlert(icon, title, msg){
	Swal.fire({
		icon: icon,
		title: title,
		text: msg,
		confirmButtonColor: "#FEC5BB",
		confirmButtonText: "OK"
	});
}

function collapse(element) {
	var content = element.nextElementSibling;
	element.classList.toggle("active");        
	
	if (content.style.maxHeight != 0) {      
		content.style.maxHeight = null;      
	} else {
		content.style.maxHeight = content.scrollHeight + "px";  
	}
}
</script>

<style>
/* 기본 페이지 레이아웃 */
body {
	background: #fbf7f5 !important;
}
div{
	box-sizing: border-box;
}
.wrap-all{ 
	min-width: 540px;
	min-height: 405px; 
	padding: 0 5% 0 5%; 
	margin: auto;
}
.wrap-all > div{ 
	width: 100%;
	margin: auto%;
}
#header{
	height: 15%;
}
#contents{
heigh	t: 80%;
}
#contents > div{
	height: 100%;
	float: left;
}
#section-right{
	width: 10%;
	min-width: 120px;
}
#section-main{
	width: 90%;
	padding-left: 1%;
}

/* 개별요소 */
.card-header-tabs .nav-link{
	color: #212529BF;
}
.card-header-tabs .active{
 	color: #000;
	font-weight:bold;
}
#contents .collapsible {
	background-color: #FBFBFD !important;
	color: #343a40;	
	cursor: pointer;
	width: 100%;
	border: none;
	text-align: left;
	outline: none;
	font-size: 15px;
	text-aling:center;
	padding:2%;
}
#contents .content {
	color: #343a40;	
	padding: 0 1rem;
	max-height: 0px;
	overflow: hidden;
	transition: max-height 0.2s ease-out;
	background-color: #f1f1f1;
}
.card-1{
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
} 
#card-title .nav-link {
	color: black !important;
}
#inputGroup-sizing-sm, #b_name, #b_author, #b_pub {
	border-color:#FAE0E0;
	box-shadow: none !important;
}

#sidebar .collapsible:after {
	content: '\002B';
	padding-right: 0.5em;
	color: #343a40;
	font-weight: bold;
	float: right;
}
#sidebar .active:after {
	content: "\2212";
	padding-right: 0.5em;
}

#keyword, #btnSearch {
	border-color:#FAE0E0;
	outline: none;
	box-shadow: none !important;
}
#btnReset, #btnDetail {
	background-color: #FEC5BB;
	border-color:#FAE0E0;
	outline: none;
	box-shadow: none !important;
}
.toggleBtn {
	padding: 0.5rem;
	cursor: pointer;
	margin: auto;
	display: block;
	border: none;
}

/* alert 커스텀 */
.swal2-confirm {
	background-color: #FEC5BB !important;
	border: 1px solid #FEC5BB !important;
	box-shadow: none !important;
	outline:none !important;
	height: 44px;
}
</style>
</head>

<body>
<%@ include file="../common/header.jsp"%>

<div class="wrap-all">

<div id="header">
  <div class="page-direction" style="padding: 1%">
	<div class="navi">
		<span>HOME</span> <i class="bi bi-chevron-right"></i>
		<span style="font-weight:bold;">자료찾기</span>
	</div>
	<hr>
  </div><!-- page-direction 끝 -->
</div><!-- header 끝 -->


<!-- 메인 contents -->
<div id="contents" class="d-flex min-vh-100">
	<div id="section-right"> <!-- section-right 사이드메뉴 -->
		<div class="visible-md visible-lg" id="sidebar">
		  <ul class="list-unstyled ps-0">
			<li class="mb-1">
				<button class="collapsible" onclick="collapse(this)">
					<b>&nbsp;&nbsp;검색조건</b>
				</button>
				<div class="content">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded" disabled style="cursor:none;">제목</a></li>
						<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded" disabled style="cursor:none;">저자</a></li>
						<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded" disabled style="cursor:none;">발행처</a></li>
					</ul>
				</div>
			</li>
		  </ul>
		</div><!-- sidebar -->
	</div><!-- section-right 끝 -->


<div id="section-main" class="d-flex-col"><!-- section-main -->
	
	<div class="card text-center card-1" ><!-- 검색툴 -->
		<div class="card-header" style="background-color: #f1d59838;">
			<ul class="nav nav-tabs card-header-tabs" id="card-title">
				<li class="nav-item">
				  <a class="nav-link active" aria-current="true" name="type2" href="#" disabled style="cursor:none">소장자료검색</a>
				</li>
			</ul>
		</div><!-- card-header 끝 -->
		
		<div class="card-body">
			<div class="searchForm1" align="center" style="width: 100%;">
				<form name="form1" method="post" action="/syLibrary/search_servlet/search.do">
				<div class="input-group mb-3">
		  			<input name="keyword" id="keyword" value="${keyword}" type="text" class="form-control" placeholder="검색어를 입력하세요">
		  			<button class="btn btn-light" type="button" id="btnSearch" style="background-color: #FEC5BB;">
						<i class="bi bi-search"></i>
					</button>
				</div>
				</form>
			</div><!-- searchForm1 끝 -->
	
			<div class="searchForm2" style="display: none; padding: 0 3rem 1rem 3rem">
				<form name="form2" method="post" action="/syLibrary/search_servlet/detailSearch.do" >
					<div class="input-group input-group-md mb-3">
						<span class="input-group-text" id="inputGroup-sizing-sm">&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input type="text" class="form-control" id="b_name" name="b_name" value="${b_name}" placeholder="예: 책제목">
					</div>
					<div class="input-group input-group-md mb-3">
						<span class="input-group-text" id="inputGroup-sizing-sm">&nbsp;&nbsp;저자&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input type="text" class="form-control" id="b_author" name="b_author" value="${b_author}" placeholder="예: 홍길동">
					</div>
					<div class="input-group input-group-md mb-3">
						<span class="input-group-text" id="inputGroup-sizing-sm">&nbsp;&nbsp;발행처&nbsp;</span>
							<input type="text" class="form-control" id="b_pub" name="b_pub" value="${b_pub}" placeholder="예: 가나출판사">
					</div>
			
					<div class="d-flex justify-content-end" >
						<button type="reset" class="btn btn-light" id="btnReset">입력초기화</button>
						&nbsp;
						<button type="button" class="btn btn-light" id="btnDetail">&nbsp;&nbsp;상세검색&nbsp;&nbsp;</button>
					</div>
				</form><!-- form2 끝 -->
			</div><!-- searchForm2 끝 -->
	
			<button class="toggleBtn btn btn-sm btn-light" type="button" id="btnShow"><i class="bi bi-chevron-double-down"></i></button>
			<button class="toggleBtn btn btn-sm btn-light" type="button" id="btnHide" style="display: none;"><i class="bi bi-chevron-double-up"></i></button>
		</div><!-- card-body 끝 -->
	</div><!-- 검색틀 끝 -->
</div><!-- section-main 끝 -->
</div><!-- contents 끝 -->


</div><!-- wrap-all 끝 -->

<%@ include file="../common/footer.jsp"%>
</body>
</html>