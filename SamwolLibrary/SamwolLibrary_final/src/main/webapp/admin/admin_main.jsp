<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../include/js/bootstrap.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
</head>
<style>
html, body {
	height: 100%;
}
.dd {
padding-left: 10px;
padding-right: 10px;
padding-top: 10px;
padding-bottom: 10px;
float: left;
}
.M {
padding-left: 10px;
padding-top: 10px;
font-size: 30px;
}
.ddm {
padding-left: 10px;
padding-right: 10px;
padding-top: 80px;
padding-bottom: 10px;
float: left;
}
</style>
<body>
	<jsp:include page="/admin/admin_header.jsp" />
	
<div id="body-wrapper">
	<div id="body-content">
			<jsp:include page="/admin/menu.jsp" />
			<div style="padding-top: 30px; left: 250px; position: absolute; width: 2000px;">
				<div class="dd" style="width: 350px;">
					<%@ include file="../admin/main/calendar.jsp" %>
				</div>
				
				<div class="ddm" style="width: 350px; ">	
					<%@ include file="../admin/main/memo_insert.jsp" %>
				</div>
				
				<div class="ddm" style="width: 550px;">	
					<%@ include file="../admin/main/memo_main.jsp" %>
				</div>
			</div>
	</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>