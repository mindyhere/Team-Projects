<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet" href="/syLibrary/include/user.css">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container min-vh-100">
		<h3 class="text-bold">
			<img src="/syLibrary/resources/images/myLibrary/history.png"
				width="35px" height="35px"> 대출 이력
		</h3>
		<hr>
		<c:choose>
			<c:when test="${myHistory.size() > 0 }">
				<div class="card-style mb-30">
					<h4>나의 대출 이력 : ${myHistory[0].lo_book_cnt} 건</h4>
					<hr>
					<ul>
						<c:forEach var="myHistory" items="${myHistory}">
							<li style="list-style: none;">
								<div class="row mb-4">
									<div class="col col-md-auto" style="margin-right: 30px;">
										<img src="${myHistory.b_url}"
											style="width: 150px; height: 200px; border: 1px solid #dee2e6;">
									</div>
									<div class="col detail" style="margin-right: 30px; margin-left: 10px;">
										<p>
											<a
												href="/syLibrary/search_servlet/bookInfo.do?b_id=${myHistory.l_bookid}">${myHistory.b_name}</a>
										</p>
										<p>
											<span>작가 : ${myHistory.b_author} </span> <span>출판사 :
												${myHistory.b_pub} </span> <span>발행연도 : ${myHistory.b_year}</span>
										</p>
										<p>
											<span>도서분류 : ${myHistory.b_category} </span> <span>ISBN
												: ${myHistory.b_isbn} </span>
										</p>
										<p>
											<span>대출일 : ${myHistory.l_lodate} </span>
											<c:if test="${myHistory.l_complete ne null}">
												<span> 반납일 : ${myHistory.l_complete} </span>
											</c:if>
											<c:if test="${myHistory.l_complete eq null}">
												<span> 반납예정일 : ${myHistory.l_retdate} </span>
											</c:if>
										</p>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="card-style mb-30" style="height: 150px;">
					<h4>나의 대출 이력 : ${myHistory.size()} 건</h4>
					<hr>
					<h5 class="text-bold" align="center">대출 이력이 없습니다.</h5>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>