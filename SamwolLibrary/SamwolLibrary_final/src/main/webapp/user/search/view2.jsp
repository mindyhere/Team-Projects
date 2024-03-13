<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
div{
    /*border: 2px dashed #343a40;	/*테스트용 아웃라인*/
    box-sizing: border-box;
}
/* 카드 뷰 */
.card-view{
padding:1%; 
margin-bottom:10%;
white-space: nowrap;
}
#book{
width: 10rem;
}
.card-img-overlay .btn-group-sm{
	float:right;
}
.card #bookCover {
	border-radius: 0px 0px 5px 5px;
	color: #fff;
	position: absolute; left: 0; bottom: 0;
	background: rgba(0,0,0,0.5);
	width: 100%;
	padding: 5%;
	box-sizing: border-box;
	opacity: 0;
	transition: opacity 0.35s ease-in-out;
}
#book:hover #bookCover {
	border-radius: 5px;
	opacity: 1;
}

#book #bookCover h4, p {
	display:block;
	padding-bottom: 0.4em;
	color:#FFFFFF !important;
	overflow:hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-transform: uppercase;
	-webkit-text-size-adjust: 100%;
    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
    word-wrap: break-word;
	text-align: left;
}
#card-header {
	height:80%;	
	padding:1%;
}

.card-body > .btn-group-sm {
	cursor: pointer;
}

.row > col{
	max-height: 200px;
}
.btnInfo, .btnChkout, .btnReserv{
	border-color:#FAE0E0 !important; 
}

</style>

<!-- 카드뷰 -->
<div class="card-view ">
<input type="hidden" name="page" value="${page.curPage }">
<div class="row justify-content-start ">
	<c:forEach var="dto" items="${list }" varStatus="vst">
	<div class="col-2 mb-3" style="padding:0 2% 0 2%;">
		<div class="card" id="book" style="align-self:center;">
			<img src="${dto.b_url}" class="card-img" alt="준비중" style="height:220px">
			<div class="card-img-overlay" id="bookCover">
			  <div calss="card-header" id="card-header">
				<input type="hidden" name="b_id" value="${dto.b_id }">
				<h4 class="card-title" style="font-weight:bold">${dto.b_name }</h4>	
				<p>${dto.b_author }
				<br>${dto.b_pub}&nbsp;&nbsp;|&nbsp;&nbsp;${dto.b_year}</p>
			
			  </div>
			  <div calss="card-body" style="height:20%; padding-bottom:1%">
				<div class="btn-group-sm" role="group">
				  <button type="button" class="btn btn-outline-light btnInfo" onclick="location.href='/syLibrary/search_servlet/bookInfo.do?b_id=${dto.b_id}'"><i class="bi bi-info-lg"></i></button>
					<c:choose>
					  <c:when test="${stateinfo[vst.index].state == 'y' }">
						<button type="button" class="btn btn-outline-light btnChkout" name="btnChkout" onclick="checkOut('${dto.b_id}')"><i class="bi bi-check2-square"></i></button>
						<button type="button" class="btn btn-outline-light btnReserv" name="btnReserv" disabled><i class="bi bi-people-fill"></i></button>
				  	  </c:when>
					  <c:otherwise>
						<button type="button" class="btn btn-outline-light btnChkout" name="btnChkout" disabled><i class="bi bi-check2-square"></i></button>
						<button type="button" class="btn btn-outline-light btnReserv" name="btnReserv" value="${dto.b_id}"><i class="bi bi-people-fill"></i></button>
				  	  </c:otherwise>
					</c:choose>					
				</div>						
			  </div>
			</div>
		</div>
	</div>
	</c:forEach>	
</div>
</div>

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