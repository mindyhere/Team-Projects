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
		let view	= $("input[name=viewOpt]").val();
		/* if(keyword.val() == "" || keyword.val().trim().length==0 ){
			myAlert("warning", "잠깐!", "검색어를 입력해주세요.");
			$('#keyword').val("");
			keyword.focus();
			return false;
		} */
		form1.submit();
	});
	$("#btnDetail").click(function() {
		let form2 = $("form[name=form2]");
	    let b_name	= $("input[name=b_name]");
	    let b_author= $("input[name=b_author]");
	    let b_pub	= $("input[name=b_pub]");
	    let view	= $("input[name=viewOpt]:checked").val();
	    if(b_name.val()=="" && b_author.val()=="" && b_pub.val()==""){
	    	myAlert("warning", "잠깐!", "검색어를 입력해주세요.");
    		b_name.focus();
    		return false;
	    }
	    form2.submit();
	});

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
	
	$(".btnRdo").click(function(){
		let e = $(this).val();    
		if(e == "view1"){ 
			$("input[name=viewOpt][value='view1']").prop('checked', true);
		}
		if(e == "view2"){ 
			$("input[name=viewOpt][value='view2']").prop('checked', true);
		} 
		let page=$("input[name=page]").val();
		moveTo(page);
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

function searchByName(page) {
    let b_name = $("input[name=b_name]").val();
    let searchOpt="name";
    let view= $("input[name=viewOpt]:checked").val();
    let count=${cntRec.cntName};
    $("#text").html("카테고리 내 키워드검색 - <span>[제목]:"+b_name+"&nbsp;</span>에 대한 검색결과, 총 <span>"+count+"</span> 건");
    let params={"b_name":b_name, "searchOpt":searchOpt, "view":view, "count":count, "page":page};
    if(count!==0){
    	$.ajax({
			url:"/syLibrary/search_servlet/serachBy.do",
			data:params,
			success:function(txt){
				$("#section-resultList").html(txt);
			}
		});
    }
}
function searchByAuthor(page) {
    let b_author = $("input[name=b_author]").val();
    let searchOpt="author";
    let view= $("input[name=viewOpt]:checked").val();
    let count=${cntRec.cntAuthor};
    $("#text").html("카테고리 내 키워드검색 - [저자]:"+b_author+"&nbsp;</span>에 대한 검색결과, 총 <span>"+count+"</span> 건");
    let params={"b_author":b_author, "searchOpt":searchOpt, "view":view, "count":count, "page":page};
    if(count!==0){
    	$.ajax({
			url:"/syLibrary/search_servlet/serachBy.do",
			data:params,
			success:function(txt){
				$("#section-resultList").html(txt);
			}
		});
    }
}
function searchByPub(page) {
	let b_pub = $("input[name=b_pub]").val();
	let searchOpt="pub";
	let view= $("input[name=viewOpt]:checked").val();
    let count=${cntRec.cntPub};
	$("#text").html("카테고리 내 키워드검색 - <span>[발행처]:"+b_pub+"&nbsp;</span>에 대한 검색결과, 총 <span>"+count+"</span> 건");
    let params={"b_pub":b_pub, "searchOpt":searchOpt, "view":view, "count":count, "page":page};
    if(count!==0){
    	$.ajax({
			url:"/syLibrary/search_servlet/serachBy.do",
			data:params,
			success:function(txt){
				$("#section-resultList").html(txt);
			}
		});
    }
}

function moveTo(page){
	let option=$("input[name=searchOpt]").val();
    if(option=="detail"){
        let b_name	= $("input[name=b_name]").val();
        let b_author= $("input[name=b_author]").val();
        let b_pub	= $("input[name=b_pub]").val();
        let view = $("input[name=viewOpt]:checked").val();
    	let params={
    		"b_name":b_name, "b_author":b_author, "b_pub":b_pub, "view":view, "page":page, "option":option
    	};
    	$.ajax({
    		url:"/syLibrary/search_servlet/moveTo.do",
    		data:params,
    		success:function(txt){
    			$("#section-resultList").html(txt);
    		}
    	});	
	}else if(option=="name"){
		searchByName(page);
	}else if(option=="author"){
		searchByAuthor(page);
	}else if(option=="pub"){
		searchByPub(page);
	}else {
		myAlert("error", "Error", "에러발생");
	}
}

function collapse(element) {
	let content = element.nextElementSibling;
	element.classList.toggle("active");      
	
	if (content.style.maxHeight != 0) {       
		content.style.maxHeight = null;       
	} else {
		content.style.maxHeight = content.scrollHeight + "px";  
	}
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

// 대출신청하기
function checkOut(b_id){
	let m_id = "${sessionScope.mId}" != null? "${sessionScope.mId}" : "";
	let a_id = "${sessionScope.a_id}" != null? "${sessionScope.a_id}" : "";
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
#footer{
	height: 5%;
}
#contents{
    height: 80%;
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
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24) !important;
} 
#card-title .nav-link, .page-item li, a {
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
border-color:#FAE0E0 !important;
outline: none;
}
#btnReset, #btnDetail {
background-color: #FEC5BB;
border-color:FAE0E0;
outline: none;
}
.toggleBtn {
	padding: 0.5rem;
	cursor: pointer;
	margin: auto;
	display: block;
	border: none;
}

/* 결과영역 세팅 */
.col-10{
	vertical-align:middle;
	align-items: center;
}
h4 > span{
	font-weight: bold;
	color: crimson;
}
td > a{
	color: black;
	font-weight:bold;
}

#section-resultList{
	margin: 0.5% 0 2% 0;
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

<div class="wrap-all"><!-- wrap-all  -->

<div id="header"><!-- header -->
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
  <div id="section-right"><!-- 사이드메뉴 section-right -->
	<div class="visible-md visible-lg" id="sidebar">
	  <ul class="list-unstyled ps-0">
		<li class="mb-1">
			<button class="collapsible" onclick="collapse(this)">
				<b>&nbsp;&nbsp;검색조건</b>
			</button>
			<div class="content" id="internal">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded" onclick="searchByName(1)">제목(<b>${cntRec.cntName}</b>)</a></li>
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded" onclick="searchByAuthor(1)">저자(<b>${cntRec.cntAuthor}</b>)</a></li>
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded" onclick="searchByPub(1)">발행처(<b>${cntRec.cntPub}</b>)</a></li>
				</ul>
			</div>
		</li>
	  </ul>
	</div><!-- sidebar 끝 -->
  </div><!-- 사이드메뉴 section-right 끝 -->


<!-- section-main -->
  <div id="section-main" class="d-flex-col">
	<div class="card text-center card-1"><!-- 검색툴 -->
		<div class="card-header" style="background-color: #f1d59838;">
			<ul class="nav nav-tabs card-header-tabs" id="card-title">
				<li class="nav-item">
				  <a class="nav-link active" aria-current="true" name="type2" href="#" style="cursor:none">소장자료검색</a>
				</li>
	
			</ul>
		</div><!-- card-header 끝 -->
		
		<div class="card-body">
			<div class="searchForm1" align="center" style="width: 100%;">
				<form name="form1" method="post" action="/syLibrary/search_servlet/search.do">
				<div class="input-group mb-3">
		  			<input name="keyword" id="keyword" value="${keyword}" type="text" class="form-control"placeholder="검색어를 입력하세요" style="box-shadow: none !important;">
		  			<button class="btn btn-light" type="button" id="btnSearch" style="background-color: #FEC5BB;">
						<i class="bi bi-search"></i>
					</button>
				</div>
				</form>
			</div><!-- searchForm1 끝 -->
	
			<!-- 상세검색툴 -->
			<div class="searchForm2" style="display: none; padding: 0 3rem 1rem 3rem">
				<form name="form2" method="post" action="/syLibrary/search_servlet/detailSearch.do" style="border-color:FAE0E0 !important;">
					<div class="input-group input-group-md mb-3" style="border-color:FAE0E0 !important;">
						<span class="input-group-text" id="inputGroup-sizing-sm">&nbsp;&nbsp;제목&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input type="text" class="form-control" id="b_name" name="b_name" value="${b_name}" placeholder="예: 책제목">
					</div>
					<div class="input-group input-group-md mb-3" style="border-color:FAE0E0 !important;" >
						<span class="input-group-text" id="inputGroup-sizing-sm">&nbsp;&nbsp;저자&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input type="text" class="form-control" id="b_author" name="b_author" value="${b_author}" placeholder="예: 홍길동">
					</div>
					<div class="input-group input-group-md mb-3" style="border-color:FAE0E0 !important;" >
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
		<br>	
		<br>
	<!-- section-result -->
	<div id="section-result" class="d-flex-col">
	
	<!-- summary(default) -->
	<div class="d-flex summary" id="summary1" name="summary1"  style="width:100%">
		<div class="col-10">
			<input type="hidden" id="option" value="${option}">
			<h4 id="text"><span>'[제목]:${b_name} [저자]:${b_author} [발행처]:${b_pub} '</span>에 대한 검색결과, 총 <span>${count}</span> 건</h4>
		</div>
		<div class="d-inline-flex col-2 justify-content-end">
			<input type="radio" class="btn-check btnRdo" name="viewOpt" id="view1" value="view1" checked>
			<label class="btn btn-light" for="view1"><i class="bi bi-distribute-vertical"></i></label>
			
			<input type="radio" class="btn-check btnRdo" name="viewOpt" id="view2" value="view2">
			<label class="btn btn-light" for="view2"><i class="bi bi-grid-fill"></i></label>
		</div>
	</div> <!-- summary(default) 끝 -->
	
	<!-- 결과목록 section-resultList -->
	<div id="section-resultList" class="card-1" style="background-color:white; border-radius:5px;">
	<!-- view1 테이블뷰 : default -->
	  <input type="hidden" name="page" value="${page.curPage }">
	  <table class="table table-sm table-striped table-hover align-middle caption-top">
		<c:forEach var="dto" items="${list }" varStatus="vst">
		  <input type="hidden" name="b_id" value="${dto.b_id }">
		  <tr style="max-height:100px; background: #fbf7f5 !important;" align="center">
			<td><img src="${dto.b_url}" alt="준비중" style="width: 100px; max-height: 150px"></td>
			<td align="left">
				<a href="/syLibrary/search_servlet/bookInfo.do?b_id=${dto.b_id}" style="text-decoration-line: none;">
				<h4>${dto.b_name }</h4></a>
				<br>${dto.b_author }
				<br>${dto.b_pub}&nbsp;&nbsp;|&nbsp;&nbsp;${dto.b_year}
			</td>
			<td>
				<div class="btn-group-vertical" style="padding:0.5rem" role="group" aria-label="Vertical button group">
				<c:choose>
					<c:when test="${stateinfo[vst.index].state == 'y' }">
						<button type="button" class="btn btn-light btnChkout" disabled>대출가능<br>(비치중)</button>
						<button type="button" class="btn btn-light btnChkout" name="btnChkout" onclick="checkOut('${dto.b_id}')" style="background-color: #FEC5BB;">대출신청</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-light btnReserv" disabled style="color:crimson;">대출불가</button>
						<button type="button" class="btn btn-light btnReserv" name="btnReserv" onclick="reserve('${dto.b_id}')" style="background-color: #FEC5BB;">예약신청</button> 
					</c:otherwise> 
				</c:choose>	
				</div><!-- btn-group-vertical 끝 -->
			</td>
		  </tr>
		</c:forEach>
	  </table> 
	
	<!-- 페이지 이동툴 -->
	<input type="hidden" name="searchOpt" value="${option }">
	  <div class="d-flex justify-content-center page-tool">
		<nav class="page-navibar" aria-label="Page navigation example"><!-- page-navibar -->
		  <ul class="pagination">
		 
		  <c:if test="${page.curPage > 1 }">
			<li class="page-item"><a class="page-link" href="#" aria-label="Start">
				<span aria-hidden="true" onclick="moveTo('1')"><i class="bi bi-chevron-double-left"></i></span>
			</a></li>
		  </c:if>
		  <c:if test="${page.curBlock > 1 }">
			 <li class="page-item">
			  <a class="page-link" href="#" aria-label="Previous">
				<span aria-hidden="true" onclick="moveTo('${page.prevPage}')"><i class="bi bi-chevron-left"></i></span>
			  </a>
			</li>  
		  </c:if>
		  
		  <c:forEach var="num" begin="${page.blockStart }" end="${page.blockEnd }">
			<c:choose>
				<c:when test="${num==page.curPage} ">
				  <li class="page-item"><a class="page-link" href="#"><strong>${num }<strong></a></li>
				</c:when>
				<c:otherwise>
				  <li class="page-item"><a class="page-link" href="#" onclick="moveTo('${num}')">${num }</a></li>
				</c:otherwise>
			</c:choose>	
		  </c:forEach>
		  
		  <c:if test="${page.curBlock < page.totBlock}">
			<li class="page-item"><a class="page-link" href="#" aria-label="Next">
				<span aria-hidden="true" onclick="moveTo('${page.nextPage}')"><i class="bi bi-chevron-right"></i></span>
			</a></li>
		  </c:if>
		  <c:if test="${page.curPage < page.totPage }">
			<li class="page-item"><a class="page-link" href="#" aria-label="End">
				<span aria-hidden="true" onclick="moveTo('${page.totPage}')"><i class="bi bi-chevron-double-right"></i></span>
			</a></li>
		  </c:if>
		
		  </ul><!-- pagination 끝 -->
		</nav><!-- page-navibar 끝 -->
	  </div><!-- 페이지 이동툴 끝  -->
	</div><!-- section-resultList 끝 -->
	</div><!-- section-result 끝 -->	
		
		
  </div><!-- section-main 끝 -->
</div><!-- contents 끝 -->

</div><!-- wrap-all 끝 -->

<%@ include file="../common/footer.jsp"%>
</body>
</html>