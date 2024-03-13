<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="icon" href="/syLibrary/resources/images/sist.png" type="image/x-icon">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="/syLibrary/include/js/bootstrap.js"></script>
<link type="text/css" href="/syLibrary/include/template1.css" rel="stylesheet">
<script>
/* 자바스크립트 작성 */

</script>

<style>
/* 커스텀 요소 작성 */

</style>
</head>


<body>
<div class="wrap-all">
<!-- 페이지 시작 -->
<div id="header">
<%@ include file="../common/header.jsp"%>
<!-- 상단메뉴 -->
<div class="container-fluid" id="menubar">
	<ul class="nav nav-underline" id="title">
	  <li class="nav-item">
	    <a class="nav-link active" aria-current="page" href="#">&nbsp;&nbsp;&nbsp;타이틀1&nbsp;&nbsp;&nbsp;</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">&nbsp;&nbsp;&nbsp;타이틀2&nbsp;&nbsp;&nbsp;</a>
	  </li>
	  <li class="nav-item active">
	    <a class="nav-link" href="#">&nbsp;&nbsp;&nbsp;타이틀3&nbsp;&nbsp;&nbsp;</a>
	  </li>
	</ul>
</div>
<!-- 경로표시 -->
<div class="page-direction" style="padding: 1%">
	<div class="navi">
		<span>HOME</span> <i class="bi bi-chevron-right"></i>
		<span>경로1</span> <i class="bi bi-chevron-right"></i> 
		<span>경로2</span> <i class="bi bi-chevron-right"></i> 
		<span style="font-weight:bold;">현위치</span>
	</div>
	<hr>
</div>
</div>

<!-- 메인 컨텐츠 -->
<div id="section-main" class="d-flex-col min-vh-100">
    <div class="section" id="section1" > section1 </div>
    <div class="section" id="section2" > section2 </div>
    <div class="section" id="section3" > section3 </div>
</div>


<div id="footer">
	<%@ include file="../common/footer.jsp"%> 
</div>
<!-- 페이지 끝 -->
</div>

</body>
</html>