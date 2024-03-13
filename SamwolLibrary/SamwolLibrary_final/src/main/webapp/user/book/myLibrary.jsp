<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script src="/syLibrary/include/js/bootstrap.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/syLibrary/include/user.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script>
function createChart(type) {
	let category=[];
	let cnt =[];
	let title = '';
	$.ajax({
		url: "/syLibrary/myLibrary_servlet/createChart.do",
		type : "get",
		data : {mNo : ${myLibrary.m_no}, type : type},
		dataType: "json",
		contentType: 'text/html;charset=utf-8',
		success: function (data) {
			if(data.length > 0){
				var chartContent = document.getElementById("myChart");
				chartContent.style.display = "block";
		 	for (let i = 0; i < data.length; i++){
				category.push(data[i].category);
				cnt.push(data[i].cnt);
			}
		var chartExist = Chart.getChart("chartResult");
	    if (chartExist != undefined)  
	      chartExist.destroy(); 
		 	new Chart(document.getElementById("chartResult").getContext('2d'),{
				type: 'bar',
				data: {
					labels : category,
					datasets : [{
						 data : cnt,
							backgroundColor: [
								'rgba(255, 99, 132, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(255, 206, 86, 0.2)',
								'rgba(75, 192, 192, 0.2)',
								'rgba(153, 102, 255, 0.2)',
								'rgba(255, 159, 64, 0.2)',
								'rgba(255, 99, 132, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(255, 206, 86, 0.2)'
							]
					}]
				},
				options:{
					maintainAspectRatio: false,
					plugins:{
					legend:{
						display:false
					},
					scales:{
						y:{
							beginAtZero : true
						}
					},
					title: {
						display: true,
						text: data[0].title,
						fontSize : 20
						}
					}
				}
			})
			} else{
				alert("통계 데이터가 충분하지 않습니다.");
			}
		 	; // 차트 end
		},
		error : function (e) {
			alert("차트 데이터를 가져오는 데 실패했습니다.");
		}
	})
}

// 대출현황으로 이동
function goLoBookList(m_no) {
	location.href = '/syLibrary/myLibrary_servlet/myLoanBook.do?mNo=' + m_no;
}

// 대출이력으로 이동
function goHisList(m_no) {
	location.href = '/syLibrary/myLibrary_servlet/myHistory.do?mNo=' + m_no;
}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<div class="row justify-content-between">
			<div class="col-2" style="width: 400px; align-self: center;">
				<h4 class="text-bold">${mName}님,반갑습니다.</h4>
			</div>
			<div class="col-2">
				<input type="button" value="회원정보 수정" style="float: left;"
					id="main-btn"
					onclick="location.href='/syLibrary/member_servlet/detail_memberInfo.do?mId=${myLibrary.m_id}'">
			</div>
		</div>
		<hr>
		<!-- 회원정보 요약 Start -->
		<div class="card-style mb-30">
			<div class="row ">
				<h4>
					<img src="../resources/images/myLibrary/mem_info.png" width="45px"
						height="40px"> 회원정보
				</h4>
				<div class="col-4" style="align-self: center;">
					<img class="mx-auto d-block"
						src="../resources/images/member/${myLibrary.m_img}" width="150px"
						height="150px">
				</div>
				<div class="col-8">
					<table class="tbl">
						<colgroup>
							<col style="width: 25%" />
							<col />
						</colgroup>
						<thead>
						</thead>
						<tbody>
							<tr>
								<th>아이디</th>
								<td>${myLibrary.m_id}</td>
							</tr>
							<tr>
								<th>회원번호</th>
								<td>${myLibrary.m_no}</td>
							</tr>
							<tr>
								<th>가입일</th>
								<td>${myLibrary.m_year}</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>${myLibrary.m_email}</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>${myLibrary.m_tel}</td>
							</tr>
							<tr>
								<th>도서대출현황</th>
								<td>${myLibrary.lo_book_cnt} / 5 (대출 중인 권수 / 대출 가능 권수)</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 회원정보 요약 End -->
		<br>
		<!-- 서비스 이용현황 요약 Start -->
		<div class="row ">
			<div class="card-style mb-30">
				<h4>
					<img src="../resources/images/myLibrary/mem.png" width="45px"
						height="40px"> 서비스 이용현황
				</h4>
				<br>
				<div class="row text-center">
					<div class="col">
						<h5 style="margin-bottom: 10px;">
							<img src="../resources/images/myLibrary/loan.png" width="25px"
								height="25px"> 대출 중인 도서
						</h5>
						<input type="button" class="form-control"
							value="${myLibrary.lo_book_cnt}"
							onclick="goLoBookList(${myLibrary.m_no})">
					</div>
					<div class="col">
						<h5 style="margin-bottom: 10px;">
							<img src="../resources/images/myLibrary/reserv.png" width="25px"
								height="25px"> 예약 중인 도서
						</h5>
						<input type="button" class="form-control"
							onclick="location.href='/syLibrary/res_book_servlet/myReBook.do?mId=${myLibrary.m_id}'"
							;
							value="${myLibrary.re_book_cnt}">
					</div>
					<div class="col">
						<h5 style="margin-bottom: 10px;">
							<img src="../resources/images/myLibrary/history.png" width="30px"
								height="30px"> 대출 이력
						</h5>
						<input type="button" class="form-control"
							value="${myLibrary.total_cnt}"
							onclick="goHisList(${myLibrary.m_no})">
					</div>
				</div>
			</div>
		</div>
		<!-- 대출현황 요약 End -->
		<br>
		<!-- 차트 영역 Start -->
		<div class="row">
			<div class="card-style mb-30">
				<h4 style="margin-bottom: 20px;">
					<img src="../resources/images/myLibrary/chart.png" width="35px"
						height="30px"> 나의 독서 통계
				</h4>
				<div style="text-align: center;">
					<input type="button" value="카테고리별 차트" id="main-btn"
						onclick="createChart('cate')"> <input type="button"
						value="반기별 차트" id="main-btn" onclick="createChart('month')">
					<input type="button" value="연도별 차트" id="main-btn"
						onclick="createChart('year')">
				</div>
			</div>
			<div id="myChart" class="card-style"
				style="position: relative; height: 400px; display: none;">
				<canvas id="chartResult"></canvas>
			</div>
		</div>
		<!-- 차트 영역 End -->
	</div>
</body>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>