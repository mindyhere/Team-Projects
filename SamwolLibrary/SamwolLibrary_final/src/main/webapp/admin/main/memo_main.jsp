<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="../resources/images/sist.png" type="image/x-icon">
<link rel="stylesheet" href="../include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="../include/js/bootstrap.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
 <script>
 $(function() { 
		list('1');
});

/*  function list(){
		let params={"a_name": $("#a_name").val(), "me_memo":$("#me_memo").val(), "me_post_date":$("#me_post_date").val(),"page":$("#page").val()};
		$.ajax({
			url:"/syLibrary/memo_servlet/list.do",
			data:params,
			success:function(txt){
				$("#result").html(txt);
			}
		});
	} */
 function list(cur_page){
		let param = {"cur_page":cur_page};
		$.ajax({
			url: "/syLibrary/memo_servlet/list.do",
			data: param,
			success: function(txt){
				$("#result").html(txt);
			}
		});
	}
 </script>
</head>
<body>
 <div id="result"></div>
</body>
</html>