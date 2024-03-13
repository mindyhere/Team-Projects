<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/syLibrary/include/js/bootstrap.js"></script>
<style>
/* 테이블행 */
table {
	border-collapse: collapse;
	height: 20px;
	margin: 0rem auto;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	border: none;
}

th {
	padding: 8px;
	text-align: center;
	height: 20px;
}
/* 테이블 올렸을 때 */
/* tbody tr:hover {
  background-color: #d3d3d3;
  opacity: 0.9;
  cursor: pointer;
} */
.dd {
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
	float: left;
}
</style>
</head>
<body>
	<jsp:include page="/admin/admin_header.jsp" />
<div id="body-wrapper">
	<div id="body-content">
			<jsp:include page="/admin/menu.jsp" />

	<div class="page-direction" style="padding: 20px; padding-left: 250px;">
		<div class="navi">
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;회원정보</span>
			<i class="bi bi-chevron-right"></i> <span style="font-weight: bold;">회원상세정보</span>
		</div>
	</div>
	<nav>
		<div style="left: 290px; position: absolute; width: 2000px;">
			<div class="dd">
				<form name="form1" method="post" enctype="multipart/form-data">
					<table border="1" width="700px" style="position: static;">
						<td rowspan="6"><c:choose>
								<c:when test="${de_list.m_img == null }">
									<img src="../resources/images/member/image_no.png"
										width="250px" height="250px">
								</c:when>
								<c:when test="${de_list.m_img != null }">
									<img src="../resources/images/member/${de_list.m_img}"
										width="250px" height="250px">
								</c:when>
							</c:choose></td>
						<tr>
							<td style="text-align: center;">이름</td>
							<td><input type="text" name="m_name" id="m_name" size="5"
								class="form-control" readonly value="${de_list.m_name}"></td>
						</tr>

						<tr>
							<td style="text-align: center;">아이디</td>
							<td><input type="text" name="m_id" id="m_id" size="5"
								class="form-control" readonly value="${de_list.m_id}"></td>
						</tr>
						<tr>
							<td style="text-align: center;">생년월일</td>
							<td><input type="text" name="m_birth_date" id="m_birth_date"
								size="10" class="form-control" readonly
								value="${de_list.m_birth_date}"></td>
						</tr>
						<tr>
							<td style="text-align: center;">전화번호</td>
							<td><input type="tel" name="m_tel" id="m_tel" size="10"
								class="form-control" readonly value="${de_list.m_tel}"></td>
						</tr>
						<tr>
							<td style="text-align: center;">이메일</td>
							<td><input type="text" name="m_email" id="m_email" size="20"
								class="form-control" readonly value="${de_list.m_email}"></td>
						</tr>
						<tr>
							<td style="text-align: center;">주소</td>
							<td><input type="text" name="m_zip_no" id="m_zip_no"
								size="20" class="form-control" readonly
								value="${de_list.m_zip_no}"></td>
							<td><input type="text" name="m_address" id="m_address"
								size="90" class="form-control" readonly
								value="${de_list.m_address}"></td>
							<td><input type="text" name="m_detail_address"
								id="m_detail_address" size="30" class="form-control" readonly
								value="${de_list.m_detail_address}"></td>
						</tr>
						<tr>
							<td style="text-align: center;">가입일자</td>

							<td colspan="2" width="70px"><input type="text"
								name="m_year" id="m_year" class="form-control" readonly
								value="${de_list.m_year}"></td>
						</tr>
						<tr>
							<td style="text-align: center;">대출가능권수</td>
							<td><input type="text" name="loan_y" id="loan_y" size="3"
								class="form-control" readonly value="${loan_y.l_y}"></td>

							<td style="text-align: center;">예약가능권수</td>
							<td><input type="text" name="reser_y" id="reser_y" size="3"
								class="form-control" readonly value="${reser_y.r_y}"></td>
						</tr>
						<tr>
							<td colspan="4" align="center" height="30px">대출현황</td>
						</tr>
						<td colspan="4" style="font-weight: normal;" align="center">

							<table border="1" style="width: 600px;">
								<tr align="center"
									style="background-color: #91C8E4; color: white; font-size: 17px;">
									<th>도서명</th>
									<th>저자</th>
									<th>대출일</th>
									<th>반납기한</th>
									<c:choose>
										<c:when test="${mem_list.size()==0}">
											<tr height="100px" align="center">
												<td colspan="4"> 대출 현황이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="mem_list" items="${mem_list}">
												<tr align="center">
													<td height="38px">&nbsp;&nbsp;${mem_list.b_name}&nbsp;&nbsp;</td>
													<td height="38px">&nbsp;${mem_list.b_author}&nbsp;</td>
													<td width="130px" height="38px">${mem_list.l_lodate}</td>
													<td width="130px" height="38px">${mem_list.l_retdate}</td>
												</tr>
											</c:forEach>
											</c:otherwise>
											</c:choose>
								</tr>
							</table>
						</td>
						<tr>
							<td colspan="4" align="center">&nbsp;</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</nav>
		</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>