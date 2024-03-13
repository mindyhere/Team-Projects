<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	getReviews();
	
	$("#btnShow").click(function() {
		$("#review").slideDown("fast");
		$("#btnShow").hide();
		$("#btnHide").show();
	});
	$("#btnHide").click(function() {
		$("#review").slideUp("fast");
		$("#btnShow").show();
		$("#btnHide").hide();
	});
	
	$("#btnPrint").click(function() {
		$('.navbar-toggler').hide();
		$('#info4').hide();
		let initBody;
		window.onbeforeprint = function(){
			initBody = $('body').html;
			$('.body').html = $('#printArea').html();
		};
		window.onafterprint = function(){
			$('body').html = initBody;
			$('.navbar-toggler').show();
			$('#info4').show();
		}
		window.print();
		return false;
	});
	
	$("#btnConfirm").click(function(){
		let b_id = ${dtoB.b_id};
		let m_id = "${sessionScope.mId}" != null? "${sessionScope.mId}" : "";
		let a_id = "${sessionScope.a_id}" != null? "${sessionScope.a_id}" : "";
		let contents =  $("#textarea");
		
		if (m_id != ""){
			if(contents.val()==""||contents.val().trim().length==0){
				myAlert("warning", "잠깐!", "내용을 입력해주세요.");
				return false;
			}
			let params={"m_id":m_id,"b_id":b_id, "contents":contents.val()};
			insert(params);
			contents.val("");
		}else if(a_id != ""){
			myAlert("warning","잠깐!", "관리자로 로그인 중입니다. 권한 문의바랍니다.");
		}else if(m_id=="" && a_id==""){
			Swal.fire({
				title: "잠깐!",
				html: "로그인 후 이용가능합니다.<br>해당 페이지로 이동할까요?",
				icon: "question",
				showCancelButton: true,
				reverseButtons: true,
				cancelButtonColor: "#C6C7C8",
				confirmButtonText: "YES",
				cancelButtonText: "NO"
				}).then((result) => {
				if (result.isConfirmed) {
					location.href="/syLibrary/user/login/login.jsp";
				}
			});
		}
	});
	
	$("#btnOpen").click(function(){
		totalList();
		$('.modal-bg').removeClass("invisible");
		$('.modal-bg').addClass("visible");
	});
	$("#btnClose").click(function(){
		$('.modal-bg').removeClass("visible");
		$('.modal-bg').addClass("invisible");
		getReviews();
	});
	$(document).mouseup(function (e){
		if($(".modal-bg").has(e.target).length === 0){
			$('.modal-bg').removeClass("visible");
			$('.modal-bg').addClass("invisible");
		}
	});
	
	$("#autoKey").keyup(function(){
		let keyword=$("#autoKey").val();
		let searchOpt=$("#searchOpt :selected").val();
		if(keyword != "" || keyword.trim().length !== 0){
			let params={"searchOpt":searchOpt, "keyword":keyword};
			$.ajax({
				url: "/syLibrary/review_servlet/search.do",
				data:params,
				success:function(txt){
					$("#review-total").html(txt);
				}
			});
		}else {
			totalList();
		}
	});
});

function myConfirm(title, msg, icon, url){
	Swal.fire({
		title: title,
		html: msg,
		icon: icon,
		showDenyButton: true,
		reverseButtons: true,
		confirmButtonText: "YES",
		denyButtonText: "NO"
		}).then((result) => {
		if (result.isConfirmed) {
			location.href=url;
		}else if (result.isDenied) {
			location.reload();
		}
	});
}
function myAlert(icon, title, msg){
	Swal.fire({
		icon: icon,
		title: title,
		text: msg,
		confirmButtonText: "OK"
	});
}
//예약신청하기	
function reserve(b_id){ 
	let m_id = "${sessionScope.mId}";
	$.ajax({
		url : "/syLibrary/res_book_servlet/recheck_book.do",
		data : {"b_id" : b_id, "m_id" : m_id},
		success : function (result) {
			if(result == 1){
				myAlert("error", "잠깐!", "예약가능 권수가 초과되었습니다.");
			} else if(result == 2){
				myAlert("warning", "잠깐!", "이미 예약하신 도서입니다.");
			} else if (result== 3) {
				myAlert("success", "Check", "예약신청이 완료되었습니다.");
			}
		},
		error : function () {
			myAlert("error", "Error", "에러발생");
		}
	})
} 
//대출신청하기
function checkOut(b_id){
	let m_id = "${sessionScope.mId}" != null? "${sessionScope.mId}":"";
	let a_id = "${sessionScope.a_id}" != null? "${sessionScope.a_id}":"";
	if(m_id != ""){
		$.ajax({
			url:"/syLibrary/checkout_servlet/checkout.do",
			data:{"m_id":m_id,"b_id":b_id},
			success: function(txt){
				myConfirm(txt,
						"나의서재에서 신청현황을 조회할 수 있습니다.<br>해당 페이지로 이동할까요?", 
						"info",
						"/syLibrary/myLibrary_servlet/myLibray_info.do?mId="+m_id);
			},
			error: function(request, status, error){
				myAlert("error", "Error", `"code= "+request.status+", msg= "+request.responseText+", error= "+error`);
			}
		});
	}else if(a_id != ""){
		myAlert("warning","잠깐!", "관리자로 로그인 중입니다. 권한 문의바랍니다.");
	}else if(m_id=="" && a_id==""){
		Swal.fire({
			title: "잠깐!",
			html: "로그인 후 이용가능합니다.<br>해당 페이지로 이동할까요?",
			icon: "question",
			showCancelButton: true,
			reverseButtons: true,
			cancelButtonColor: "#C6C7C8",
			confirmButtonText: "YES",
			cancelButtonText: "NO"
			}).then((result) => {
			if (result.isConfirmed) {
				location.href="/syLibrary/user/login/login.jsp";
			}
		});
	}
}

function getReviews(){
	let b_id=${dtoB.b_id};
	$.ajax({
		url:"/syLibrary/review_servlet/getReviews.do",
		data:{"b_id":b_id},
		success:function(txt){
			$("#review-table").html(txt);
		}
	}); 
}
function totalList() {
	$.ajax({
		type:"post",
		url:"/syLibrary/review_servlet/totalList.do",
		success:function(txt){
			$("#review-total").html(txt);
		}
	});
}

function insert(params){
	$.ajax({
		url:"/syLibrary/review_servlet/insert.do",
		data:params,
		success: function(txt){
			myAlert("info", "Check", txt);
			getReviews();
		},
		error: function(request, status, error){
			alert("code= "+request.status+", msg= "+request.responseText+", error= "+error);
		}
	});
}
function deleteReview(params) {
	$.ajax({
		url: "/syLibrary/review_servlet/delete.do",
		data:params,
		success:function(txt){
			getReviews();
		}
	}); 
}
function search(keyword){
	let params={"searchOpt":$("#searchOpt").val(), "keyword":keyword};
	$.ajax({
		url: "/syLibrary/review_servlet/search.do",
		data:params,
		success:function(txt){
			$("#review-total").html(txt);
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
	min-width: 540px;
	min-height: 405px;
	padding: 0 5% 0 5%;
	margin: auto;
}
.wrap-all > div {
	width: 100%;
}
#header {
	height: 15%;
}
#footer {
	height: 5%;
}
#contents {
	height: 80%;
}
#contents > div {
	height: 100%;
	float: left;
}

/* 개별요소 */
.card-header-tabs .nav-link{
	color: #212529BF;
}
.card-header-tabs .active{
 	color: #000;
	font-weight:bold;
}

#section-main {
 	justify-content: center;
	align-items: center;
	padding: 0 1% 1% 1%;
}
#section-main .card-body > div {
	margin-top: 1%;
} 
.container {
	margin: 0 0 2rem 0;
}
.card-1{
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24) !important;
} 

.card button {
	margin: auto;
	display: block;
	border: none;
	font-size: 1.2rem;
}
.myBtn {
	padding: 0.5rem;
	cursor: pointer;
	margin: auto;
	display: block;
	border: none;
}
.btnChkout, .btnReserv, #btnConfirm, #btnPrint{
	font-size: 1rem !important;
	background-color: #FEC5BB;
	border-color:#FAE0E0;
	outline: none;
}
#btnPrint{
	float: right;
}

.review-table{
padding:0;
white-space:nowrap;
overflow-y: auto;
}
th > input[type="checkbox"] {
display:none;
}
td > input[type="checkbox"] {
cursor: pointer;
accent-color: #FEC5BB !important;
}
#textarea, #autoKey, #searchOpt{
	box-shadow: none !important;
	border-color:#FAE0E0;
	outline: none;
}
.review-write .input-group > *, #review-options .autocomplete, #review-search .autocomplete  {
	border-color:#FAE0E0;
	border-radius: 7px;
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
	/* overflow-y: auto; */
	box-sizing: border-box;
	position: absolute;
	top: 50%; 
	min-width: 700px !important;
	height: 600px !important;
	align-items: center;
	justify-content: center;
	text-align: center;
	background: #fbf7f5 !important;
	border-radius: 7px;
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
.modal-container {
background: #fbf7f5 !important;
width:100%;
height:100%;
padding:2%;
border-radius: 7px !important;
}
#modal-header {
height:10%;
margin-bottom:1%
}
#modal-section1 {
overflow-y: scroll;
height:70%;
margin-bottom:2%;
overflow-y: auto;
background-color:white !important;
border-radius: 7px !important;
box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);\
}
#modal-section2 {
height:15%;
max-height:2.5rem;
}
#review-total .table {
white-space:nowrap;
}

/* 페이지 인쇄영역설정 */
@media print{
	html, body{
		size:auto;
		margin:0 !important;
		padding:0 !important;
	}
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
<%@ include file="../common/header.jsp"%>
<div class="wrap-all">

<div id="header">
	<div class="page-direction" style="padding: 1%">
		<div class="navi">
			<span>HOME</span> 
			<i class="bi bi-chevron-right"></i> <span>자료찾기</span>
			<i class="bi bi-chevron-right"></i> <span style="font-weight: bold;">도서상세정보</span>
		</div>
		<hr>
	</div> <!-- page-direction 끝 -->
</div> <!-- #header 끝 -->


<div id="section-main" >
  <div class="card text-center card-1" ><!-- .card text-center(main컨텐츠 전체) -->
	<div class="card-header" style="background-color: #f1d59838;">
		<ul class="nav nav-tabs card-header-tabs">
		<li class="nav-item"><a class="nav-link active" aria-current="true" name="type2" href="#" disabled style="cursor:none">상세정보</a></li>
		</ul>
	</div><!-- .card-header 끝 -->

	<div class="card-body">
		<div class="container d-flex-col" name="info1">
		  <input type="hidden" name="b_id" value="${dtoB.b_id }">
		  <div class="row g-0">
			<div class="col-md-2" style="padding: 1%;">
				<img src="${dtoB.b_url}" class="img-fluid rounded card-1" alt="준비중">
			</div>
			<div class="col-md-10">
				<div class="card-body" align="left" style="padding: 2em 0 2em 2em;">
					<caption>
						<h4 class="card-title" style="font-weight: bold">${dtoB.b_name }
						</h4>
					</caption>
				<hr style="border:solid 1px #FAE0E0;">
					<button type="button" class="btn btn-light" id="btnPrint">
						<i class="bi bi-printer-fill"></i></button>
					<p class="card-text">${dtoB.b_author }&nbsp;&nbsp;|&nbsp;&nbsp;${dtoB.b_pub}&nbsp;&nbsp;|&nbsp;&nbsp;${dtoB.b_year}</p>
					<p class="card-text">분류 : ${dtoB.b_category}</p>
					<p class="card-text">ISBN : ${dtoB.b_isbn}</p>
				</div> <!-- card-body 끝  -->
			</div>
		  </div>
		</div> <!-- info1(책 상세정보 끝) -->

		<div class="container"  name="info2" align="left">
		  <caption><h4 class="card-title">소장정보</h4></caption>
		  <table class="table table-sm align-middle text-center" >
			<thead><tr class="align-middle">
				<th scope="col">등록번호</th>
				<th scope="col">대출상태</th>
				<th scope="col">반납예정일</th>
				<th scope="col">예약여부</th>
				<th scope="col">서비스신청</th></tr>
			</thead>
			<tbody class="table-group-divider" style="border-color:#FAE0E0; background: #fbf7f5 !important;">
			  <tr>
				<th scope="row">${dtoB.b_id }</th>
			  <td>
				<c:choose>
				  <c:when test="${state == 'y' }">대출가능<br>(비치중)</c:when>
				  <c:otherwise>대출불가<br>(대출중)</c:otherwise>
				</c:choose>	
			  </td>
			  <td>
				<c:choose>
				  <c:when test="${l_retdate == '' || l_retdate ==null }">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
				  <c:otherwise>${l_retdate }</c:otherwise>
				</c:choose>	
			  </td>
			  <td>
				<c:choose>
				  <c:when test="${state == 'y' }">예약불가</c:when>
				  <c:otherwise>예약가능</c:otherwise>
				</c:choose>	
			  </td>
			  <td>
			    <div class="btn-group-vertical btn-group-sm" style="padding:0.5rem" role="group" aria-label="Vertical button group">
				<c:choose>
					<c:when test="${state == 'y' }">
						<button type="button" class="btn btn-light btnChkout" id="btnChkout" name="btnChkout" onclick="checkOut('${dtoB.b_id}')" style="background-color:#FEC5BB;"><strong>도서대출하기</strong></button>
						<button type="button" class="btn btn-light btnChkout" style="color:crimson;" disabled>도서예약불가</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-light btnReserv" style="color:crimson;" disabled>도서대출불가</button>
						<button type="button" class="btn btn-light btnReserv" id="btnReserv" name="btnReserv"  onclick="reserve('${dtoB.b_id}')" style="background-color:#FEC5BB;"><strong>도서예약하기</strong></button>
					</c:otherwise>
				</c:choose>	
				</div>
			  </td>
			  </tr>
			</tbody>
	 	  </table>
		</div> <!-- info2(책 소장정보 끝) -->

		<div class="container" name="info3" align="left">
			<h4>책소개</h4>
			<p>${dtoB.b_description }</p>
		</div> <!-- info3(책소개 끝) -->

		<div class="container" id="info4" name="info4">
		  <div class="row justify-content-between" id="reviewHead">
			<div class="col-4" align="left"><h4>한줄서평</h4></div>
			<div class="col-4" style="float: right">
				<button class="myBtn btn btn-sm btn-light" type="button" id="btnShow" style="display: none; float: right">
					<i class="bi bi-chevron-double-down"></i>
				</button>
				<button class="myBtn btn btn-sm btn-light" type="button" id="btnHide" style="float: right">
					<i class="bi bi-chevron-double-up"></i>
				</button>
				<button class="myBtn btn btn-sm btn-light" type="button" id="btnOpen" style="float: right">
					<i class="bi bi-justify-left"></i>
				</button>
			</div>
		  </div> <!-- #reviewHead 끝 -->
					
		  <div class="review d-flex-col" id="review">
			<div class="review-table d-flex" id="review-table">
	 			<%@ include file="./reviews.jsp"%> 
			</div><!-- .review-table 끝 -->
		
		  <div class="review-write d-flex">
			<div class="input-group">
				<span class="input-group-text">
					<button type="button" class="btn btn-sm btn-outline" disabled>
						<i class="bi bi-chat-square-text"></i>
					</button>
				</span>	
				<textarea id="textarea" name="textarea" class="form-control" placeholder="내용을 입력해주세요.&#13;&#10;(리뷰등록은 로그인 후 이용가능합니다.)" required></textarea>
				<span class="input-group-text" style="background-color: #FEC5BB;">
					<button type="button" class="btn btn-sm btn-light" id="btnConfirm">
						<strong>리뷰등록</strong>
					</button>
				</span>
			</div><!-- input-group 끝  -->
		  </div><!-- .review-write 끝 -->
		  </div> <!-- #review 끝 -->
		</div> <!-- info4(한줄리뷰 끝) -->

	</div><!-- .card-body 끝 -->
  </div> <!-- .card text-center(main컨텐츠 전체) 끝 -->
</div><!-- #section-main 끝 -->


<!-- 모달 -->
<div class="modal-bg invisible">
	<div class="modal-body" id="modal-body">
		<div class="modal-container">
			<div id="modal-header" class="d-flex justify-content-between">
				<div><h3>&nbsp;&nbsp;<strong><i class="bi bi-justify-left"></i>&nbsp;REVIEW</h3></stong></div>
				<div><button type="button" class="btn-close" id="btnClose"></button></div>
			</div><!-- modal-header 끝 -->	
			
			<div id="modal-section1" class="d-flex-col">
				<div class="review-table d-flex" id="review-total">
				</div><!-- #review-total 끝 -->
			</div><!-- modal-section1 끝 -->
			
			<div id="modal-section2" class="d-flex col-6">
				<div id="review-options" class="d-flex col-3">
					<div class="input-group d-flex-sm">
					  <select class="form-select form-select-sm autocomplete" id="searchOpt" style="size:10px;">
						<option value="all" selected>ALL</option>
						<option value="m_id">작성자ID</option>
						<option value="b_name">책제목</option>
					  </select>
				    </div>	
				</div>
					&nbsp;&nbsp;
				<div id="review-search" class="d-flex col-9">  
					  <input type="text" class="form-control autocomplete" id="autoKey" name="autoKey" placeholder="검색어를 입력하세요">
				</div>
			</div><!-- modal-section2 끝 -->			
		</div><!-- modal-container 끝 -->
	</div> <!-- modal-body 끝 -->
</div> <!-- modal-bg 끝 -->

</div><!-- .wrap-all 끝 -->

<div id="footer">
	<%@ include file="../common/footer.jsp"%>
	<div id="printArea" style="display:none;"></div>
</div>

</body>
</html>
