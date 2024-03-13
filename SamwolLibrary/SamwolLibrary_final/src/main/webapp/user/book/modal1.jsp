<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(function(){
	$("#autoKey").keyup(function(){
		let keyword=$("#autoKey").val();
		if(keyword.length===0){
		$("#autocomplete").addClass("card-1");
		}else{
			$("#autocomplete").addClass("card-1");
			$("#autocomplete").css("visibility","visible");
			$.ajax({
				url: "/syLibrary/home/search.do",
				data:{"keyword":keyword},
				success:function(txt){
					$("#autocomplete").html(txt);
				}
			});
		}
	});
	$("#autoKey").focusout(function() {
		$("#autocomplete").removeClass("card-1");
	});
	
	$("#chkAll").click(function() {
		if(!$("#chkAll").is(":checked")) {
			$("#chkAll").attr("checked", true);
			$("input[name=checkIdx]").prop("checked", true);			
		}else {
			$("#chkAll").attr("checked", false);
			$("input[name=checkIdx]").prop("checked", false);
		}
	});
	$("#btnDelete").click(function() {
		let arr=$("input[name=checkIdx]:checked");	
		let cnt=0;	
		let values='';
		for(i=0; i<arr.length; i++){
			if(arr[i].checked==true) cnt++;
			values += arr[i].value+",";
		}
		
		if(cnt==0){
			Swal.fire({
				title: "잠깐!",
				text: "삭제할 항목을 선택해주세요.",
				icon: "warning",
				showDenyButton: true,
				showConfirmButton: false,
				denyButtonText: "OK"
				}).then((result) => {
				if (result.isDenied) {
					return;
				}
			});
		}else{
			$.ajax({
				url: "/syLibrary/home/delete.do",
				data:{"cnt":cnt, "arr":values},
				success:function(txt){
					showTableList();
				}
			});
		}
	});
});

function insert(e){
 	$.ajax({
		url: "/syLibrary/home/insert.do",
		data:{"b_id":e, "a_id":"${a_id}"},
		success:function(txt){
			Swal.fire({
				icon: "info",
				title: "Check",
				text: txt,
				confirmButtonText: "OK"
			});
			showTableList();
		}
	}); 
}
</script>


<style>
.modal-container {
	background: #fbf7f5 !important;
	width:100%;
	height:100%;
	padding:2%;
	border-radius: 7px !important;
}
.modal-container > div {
	margin-bottom:1%;
}
.table {
	white-space:nowrap;
}
input[type="checkbox"] {
	accent-color: #FEC5BB !important;
}
th > input[type="checkbox"] {
	display:none;
}
td > label {
	cursor: pointer;
}
b {
	color:black;
}
.auto-head {
	padding:1%;
	text-align:left;
}
#modal-section2 {
	min-height:40%;
}
#autocomplete {
	background: white !important;
	padding: 0 0 1% 0;
	height:200px;
	border-radius: 5px;
	overflow-y: auto;
}
#autocomplete .tbody {
	padding-left:1%; 
	padding-right:1%; 
}
#autoKey {
	border-color:#FAE0E0;
	outline: none;
}
#btnDelete {
	background-color: #FEC5BB;
	border-color:#FAE0E0;
	outline: none;
}
.card-1 {
	box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
} 
</style>
</head>


<div class="modal-container">
	<div id="modal-header" class="d-flex justify-content-between">
		<div style="background: #fbf7f5 !important;"><h3>&nbsp;&nbsp;<strong><i class="bi bi-magic"></i>&nbsp;EDIT</h3><strong></div>
		<div><button type="button" class="btn-close" id="btnClose" onclick="closeModal()"></button>&nbsp;&nbsp;</div>
	</div><!-- modal-header 끝 -->

	<div id="modal-section1" class="d-flex-col">
	  <table class="table table-sm table-hover align-middle text-center">
		<thead>
			<tr class="align-middle" >
				<th scope="col"><strong>no.</strong></th>
				<th scope="col"><strong>등록번호</strong></th>
				<th scope="col"><strong>제목</strong></th>
				<th scope="col"><strong>저자</strong></th>
				<th scope="col"><strong>발행처</strong></th>
				<th scope="col"><strong>등록</strong></th>
				<th scope="col">
					<input type="checkbox" id="chkAll" name="chkAll" checked="false">
					<label class="btn" for="chkAll"><i class="bi bi-check-all"></i></label>
				</th>
			</tr>
		</thead>
		<tbody class="table-group-divider" style="border-color:#FAE0E0;">
		<c:forEach var="item" items="${list }">
			<tr align="center">
				<th scope="row">${item.ROWNUM}</th>
				<td>${item.B_ID}</td>
				<td><strong>${item.B_NAME}</strong></td>
				<td>${item.B_AUTHOR}</td>
				<td>${item.B_PUB}(${item.B_YEAR})</td>
				<td>
				${item.A_NAME}(${item.POST_DATE})
				</td>
				<td>
	  			<input type="checkbox" value="${item.IDX}" name="checkIdx">
				</td>
			</tr>
		</c:forEach>
		</tbody>
	  </table>
	</div><!-- modal-section1 끝 -->

	<div id="modal-section2 " class="d-flex-col">
		<div class="auto-head d-flex-col" >
		&nbsp;추천도서는 <b>5권</b>까지 등록할 수 있습니다. 찾으시는 책의 키워드를 입력해주세요.
		</div><!-- auto-head 끝 -->
		<div id="auto-search" class="input-group input-group-sm d-flex">
			<div class="auto-head d-flex col-8 " >
				<input id="autoKey" name="autoKey" type="text" class="form-control" placeholder="검색어를 입력하세요" style="box-shadow: none !important;">
			</div>	
		</div><!-- auto-search 끝 -->
		<div id="autocomplete"></div>
	</div><!-- modal-section2 끝 -->

	<div id="buttons" class="d-flex " style="float:right; margin-top:1%">
		<button type="button" class="btn btn-sm btn-light" id="btnDelete" name="btnDelete"><strong>DELETE</strong></button>
		&nbsp;&nbsp;
	</div><!-- buttons -->	
</div><!-- modal-container 끝 -->

</html>