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
<script src="/syLibrary/include/js/bootstrap.js"></script>
<link type="text/css" href="/syLibrary/include/template2.css" rel="stylesheet">
<script>
/* 자바스크립트 */

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
</div>

<!-- 메인 컨텐츠 -->
<div id="contents" class="d-flex min-vh-100">
    <div id="section-right">사이드</div>
    <div id="section-main">메인</div>
</div>


<div id="footer">
	<%@ include file="../common/footer.jsp"%> 
</div>
<!-- 페이지 끝 -->
</div>

</body>
</html>