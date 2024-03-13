<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	$(function() {
		$("#btnMemo").click(function() {
			/* let me_a_id = $("#me_a_id");
			if (me_a_id.val() == "") {
				alert("작성자를 입력하세요");
				return false;
			}  */
			let me_memo = $("#me_memo");
			if (me_memo.val() == "") {
				swal("메모를 입력하세요");
				return false;
			}
			/* document.form1.action = "/syLibrary/memo_servlet/insert.do?me_a_id="+me_a_id;
			document.form1.submit(); */
		});
	});
</script>
</head>
<body>
	<form method="post" name="form1" action="/syLibrary/memo_servlet/insert.do">
		<table border="1" style="width: 300px" class="table table-hover">
			<tr align="center">
				<td>
					<%-- <input type="text" name="me_memo" id="me_memo" size="6" class="form-control" value="${memo.me_memo}"> --%>
					<textarea class="form-control" type="text" name="me_memo" id="me_memo" rows="5" cols="30" placeholder="메모작성" id="contents" value="${memo.me_memo}"></textarea>
					<input type="hidden" name="me_a_id" id="me_a_id" value="<%=session.getAttribute("a_id")%>">
					<input type="hidden" name="me_post_date" id="me_post_date" size="4">
					<input type="hidden" value="${memo.me_idx}" name="me_idx"></td>
			</tr>
			<tr>
				<td align="center"><input type="submit" id="btnMemo" value="메모등록" class="btn btn-warning"></td>
			</tr>
		</table>
	</form>
</body>
</html>