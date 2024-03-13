<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 테이블뷰 -->
<input type="hidden" name="page" value="${page.curPage }">
<table class="table table-sm table-striped table-hover align-middle caption-top">
<c:forEach var="dto" items="${list }" varStatus="vst">

	<input type="hidden" name="b_id" value="${dto.b_id }">
	<tr style="max-height:100px;" align="center">
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