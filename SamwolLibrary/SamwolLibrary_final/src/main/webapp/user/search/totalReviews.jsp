<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <table class="table table-sm table-hover align-middle text-center">
	<colgroup>
		<col width=5%>
		<col width=10%>
		<col width=15%>
		<col width=55%>
		<col width=10%>
		<col width=5%>
	</colgroup>
	<thead>
	  <tr class="align-middle">
		<th class="t-head" scope="col"><strong>no.</strong></th>
		<th class="t-head" scope="col"><strong>Writer</strong></th>
		<th class="t-head" scope="col"><strong>Book title</strong></th>
		<th class="t-head" scope="col"><strong>Review</strong></th>
		<th class="t-head" scope="col"><strong>Date</strong></th>
		<th class="t-head" scope="col">
		  <c:choose>
			<c:when test="${sessionScope.mId !=null}">
				<input type="checkbox" id="delUser" name="deleteU" checked="false">
				<label class="btn" for="delUser"><i class="bi bi-eraser-fill"></i></label>
			</c:when>
			<c:when test="${sessionScope.a_id !=null}">
				<input type="checkbox" id="delAdmin" name="deleteA" checked="false">
				<label class="btn" for="delAdmin"><i class="bi bi-eraser-fill"></i></label>
			</c:when>
			<c:otherwise>
				<input type="checkbox" id="none" checked="false" disabled>
				<label class="btn" for="none" style="cursor:none;" disabled><i class="bi bi-eraser-fill"></i></label>
			</c:otherwise>
		  </c:choose>
		</th>
	  </tr>
	</thead>
	<tbody class="table-group-divider" style="border-color:#FAE0E0;">
		<c:choose>
		  <c:when test="${reviews.size() !=0 }">
			<c:forEach var="item" items="${reviews }">
			  <tr class="align-middle">
				<th scope="row">${item.ROWNUM}</th>
				<td>${item.WRITER}</td>
				<td>${item.B_NAME}</td>
				<td>${item.CONTENTS}</td>
				<td>${item.POST_DATE}</td>
				<td>
				  <c:choose>
					<c:when test="${sessionScope.mId !=null && item.M_ID == sessionScope.mId }">
						<input type="checkbox" name="checkIdx" value="${item.IDX}">
					</c:when>
					<c:when test="${sessionScope.a_id !=null }">
						<input type="checkbox" name="checkIdx" value="${item.IDX}">
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="checkIdx" style="display:none">
					</c:otherwise>
				  </c:choose>
				</td>
			  </tr>
			</c:forEach>
		  </c:when>
		  
		  <c:otherwise>
		  <tr class="align-middle">
		  	<td colspan="6" ><br><p>등록된 게시글이 없습니다.</p></td>
		  </tr>	
		  </c:otherwise>	
		</c:choose>	
	</tbody>
  </table>
  
<script>
$(function() {
	$("#delUser").click(function(){
		let arr=$("input[name=checkIdx]:checked");
		let cnt=0;
		let values='';
		for(i=0; i<arr.length; i++){
			if(arr[i].checked==true) cnt++;
			values += arr[i].value+",";
		}

		if(cnt==0){
			myAlert("warning","잠깐!", "삭제할 항목을 선택해주세요.");
			return;
		}else{
			let	params={"option":"user", "arr":values, "m_id":"${mId}" };
			$.ajax({
				url: "/syLibrary/review_servlet/delete.do",
				data:params,
				success:function(txt){
					totalList();
				}
			}); 
		}	
	});
	
	$("#delAdmin").click(function() {
		let arr=$("input[name=checkIdx]:checked");
		let cnt=0;
		let values='';
		for(i=0; i<arr.length; i++) {
			if(arr[i].checked==true) cnt++;
			values += arr[i].value+",";
		}

		if(cnt==0){
			myAlert("warning","잠깐!", "삭제할 항목을 선택해주세요.");
			return;
		}else{
			let	params={"option":"admin", "arr":values};
			$.ajax({
				url: "/syLibrary/review_servlet/delete.do",
				data:params,
				success:function(txt){
					totalList();
				}
			}); 
		}
	});
});
</script>
