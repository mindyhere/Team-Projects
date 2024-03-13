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
<link rel="stylesheet" href="/syLibrary/include/user.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="/syLibrary/include/js/bootstrap.js"></script>


<style>
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
	width: 100% !important;
}
#header {
	height: 15%;
}
#footer {
	height: 5%;
}
#section-main {
	height: 80%;
 	justify-content: center;
	align-items: center;
	padding: 0 1% 1% 1% !important;
}
.card-header-tabs .nav-link{
	color: #212529BF;
}
.card-header-tabs .active{
 	color: #000;
	font-weight:bold;
}

#section-main > div {
	height: 100%;
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24) !important;
}
.bot > div {
	padding:0;
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24) !important;
} 
.col-4 .card-header{
	padding-left: 1.5rem;
	padding-top: 1rem;
	padding-bottom: 0;
	background-color: #FEC5BB;
}
.card-title{
	margin:0;
	padding:0;
	align-items:center;
}
li h5, li p{
	margin:0;
	padding:0
} 

.card-header-tabs .nav-link {
	color: #212529BF;
}
.card-header-tabs .active {
 	color: #000;
	font-weight:bold;
}
a {
text-decoration-line: none !important;
}
.card-body {
  overflow: hidden;
  position: relative;
  width:100%;
  height:100%;
}
.card-body > img {
  position: absolute;
  width: 30%;
  height: 30%;
  opacity: 0.4;
  top: 80%;
  left: 85%;
  z-index:1;
  transform: translate(-50%, -50%);
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
		<i class="bi bi-chevron-right"></i> <span>이용안내</span>
		<i class="bi bi-chevron-right"></i> <span style="font-weight: bold;">사이트맵</span>
	</div>
	<hr style="margin:0.5 rem">
</div> <!-- page-direction 끝 -->
</div> <!-- #header 끝 -->


<!-- 메인 section-main -->
<div id="section-main" class="d-flex-col min-vh-100">
  <div class="card-style d-flex-col">
	<div class="top d-flex-col">
		<h4><span class="mont">Site Map</span> <br> <b>사이트맵</b></h4>
	</div><!-- top 끝 -->
	
	<div class="bot d-flex" >
		<div class="col-4 card">
			<div class="card-header">
				<ul class="card-title">
					<li>
					  <h5 style="margin:0"><strong>자료찾기</strong></h5>
					</li>
				</ul>
			</div><!-- card-header 끝 -->
			<div class="card-body">
			<ul>
			  <li><a href="#" onclick="location.href='/syLibrary/user/search/search.jsp'"><h5><b>소장자료검색</b></h5></a></li>
			  <li><p>- 키워드 통합검색</p></li>
			  <li><p>- 키워드 상세검색</p></li>
			  <li><p>- 도서 상세정보</p></li>
			</ul>
			<img src="/syLibrary/resources/images/book-half.svg" alt="Member information">
		  </div><!-- card-body 끝 -->
		</div>
	  
		<div class="col-4 card" >
			<div class="card-header">
				<ul class="card-title">
					<li>
					  <h5 style="margin:0"><strong>회원정보</strong></h5>
					</li>
				</ul>
			</div><!-- card-header 끝 -->
		    <div class="card-body">
				<ul>
				  <li><h5><b>회원정보</b></h5></li>
				  <li><a href="#" onclick="location.href='/syLibrary/user/login/login.jsp'"><p>- 로그인</p></a></li>
				  <li><a href="#" onclick="location.href='/syLibrary/user/member/join.jsp'"><p>- 회원가입</p></a></li>
				  <li><a href="#" onclick="location.href='/syLibrary/user/login/searchId.jsp'"><p>- 아이디찾기</p></a></li>
				  <li><a href="#" onclick="location.href='/syLibrary/user/login/searchPasswd.jsp'"><p>- 비밀번호찾기</p></a></li>
				  <c:choose>
				  	<c:when test="${sessionScope.mName != null}">
				  		<li><a href="#" onclick="location.href='/syLibrary/member_servlet/detail_memberInfo.do?mId=${sessionScope.mId}'"><p>- 회원정보수정</p></a></li>
				  	</c:when>
				  	<c:otherwise>
				 		<li><p>- 회원정보수정</p></li>
				  	</c:otherwise>
				  </c:choose>
				</ul>
				<br>
				<ul>
				  <c:choose>
				  	<c:when test="${sessionScope.mName != null}">
				  		<li><a href="#" onclick="location.href='/syLibrary/myLibrary_servlet/myLibray_info.do?mId=${sessionScope.mId}'"><h5><b>나의서재</b></h5></a></li>
				  	</c:when>
				  	<c:otherwise>
				 		<li><h5><b>나의서재</b></h5></li>
				  	</c:otherwise>
				  </c:choose>
				  <li><p>- 대출현황</p></li>
				  <li><p>- 예약현황</p></li>
				  <li><p>- 대출이력</p></li>
				  <li><p>- 대출통계</p></li>
				</ul>
				<img src="/syLibrary/resources/images/person-workspace.svg" alt="Member information">
		    </div><!-- card-body 끝 -->
		</div>
		
		<div class="col-4 card" >
			<div class="card-header">
				<ul class="card-title">
					<li>
					  <h5 style="margin:0"><strong>이용안내</strong></h5>
					</li>
				</ul>
			</div><!-- card-header 끝 -->
		  <div class="card-body">
			<ul>
			  <li><h5><b>이용안내</b></h5></li>
			  <li><a href="#" onclick="location.href='/syLibrary/user/info/guide.jsp'"><p>- 대출/반납/예약 안내</p></a></li>
			  <li><a href="#" onclick="location.href='/syLibrary/user/info/map.jsp'"><p>- 도서관 오는길</p></a></li>
			  <li><a href="#" onclick="location.href='/syLibrary/user/info/sitemap.jsp'"><p>- 사이트맵</p></a></li>
			</ul>
			<img src="/syLibrary/resources/images/info-square.svg" alt="Member information">
		  </div><!-- card-body 끝 -->
		</div>
  </div> <!-- bot 끝 -->
  </div> <!-- card-style 전체 끝 -->
</div> <!-- #section-main 끝 -->

</div><!-- .wrap-all 끝 -->

<div id="footer">
<%@ include file="../common/footer.jsp"%>
</div><!-- footer 끝 -->

</body>
</html>