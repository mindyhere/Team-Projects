<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- optionTab-header -->
<div id="optionTab" class="card-header" style="background-color:#f1d59838;">
	<ul name="tabList"class="nav nav-tabs card-header-tabs">
	<c:choose>
	  <c:when test="${opt == 'opt1' || opt == null }">
		<li class="nav-item" name="opt1" onclick="changeTab('opt1')">
		  <a class="nav-link active" aria-current="true" href="#">대출이 많은 책</a>
		</li>
		<li class="nav-item" name="opt1" onclick="changeTab('opt2')">
		  <a class="nav-link" href="#">이달의 책</a>
		</li>
	  </c:when>
	  <c:when test="${opt == 'opt2' }">	
		<li class="nav-item" name="opt1" onclick="changeTab('opt1')">
		  <a class="nav-link" aria-current="true" href="#">대출이 많은 책</a>
		</li>
		<li class="nav-item" name="opt1" onclick="changeTab('opt2')">
		  <a class="nav-link active" href="#">이달의 책</a>
		</li>
	  </c:when>
	</c:choose>	
	<c:if test="${sessionScope.mName == null && sessionScope.a_id != null}">
		<li class="nav-item" id="btnOpen" name="btnOpen">
		  <a class="nav-link" href="#" onclick="openModal()">EDIT<i class="bi bi-magic"></i></a>
		</li>
	</c:if>
	</ul>
</div> <!-- optionTab-header 끝 -->  

<!-- optionTab-body -->
<div class="card-body" style="background-color:#FFFFFF;">
	<!-- container-md -->
	<div class="container-md">
	  <div class="d-flex justify-content-around">
		<div id="row" class="row"> <!-- row -->
			<c:forEach var="dto" items="${list }">
				<div class="col">
					<a href="/syLibrary/search_servlet/bookInfo.do?b_id=${dto.b_id}">
					<div class="card" id="book" style="width: 10em">
						<img src="${dto.b_url}" class="card-img" alt="준비중" title="more detail">
						<div class="card-body" id="bookCover">
							<input type="hidden" name="b_id" value="${dto.b_id }">
							<h5 class="card-title" style="color:white">${dto.b_name }</h5>
							<h6>${dto.b_author }</h6>
						</div>
					</div>
					</a>
				</div>
			</c:forEach> 
		</div> <!-- row 끝 -->
	</div>
	</div> <!-- container-md 끝 -->
</div> <!-- optionTab-body 끝 -->
