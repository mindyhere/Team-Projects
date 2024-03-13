<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Document</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>
<script>
 	$(function() {
		ct_Chart();
	}); 

	//차트 색상 랜덤
	function randomColor(category) {
		var colors = [];
		for (let i = 0; i < category.length; i++) {
			//colors.push("#"+Math.round(Math.random() * 0xffffff * 0.5).toString(16));
			var r = Math.round(Math.random() * 127 + 127);
			var g = Math.round(Math.random() * 127 + 127);
			var b = Math.round(Math.random() * 127 + 127);
			colors.push("rgb(" + r + ", " + g + ", " + b + ")");
		}
		return colors;
	}

	function ct_Chart() {

		let category = [];
		let cnt = [];

		$.ajax({
					url : "/syLibrary/admin_servlet/ct_cht.do",
					type : "get",
					dataType : "json",
					contentType : "text/html;charset=utf-8",
					success : function(data) {
						for (let j = 0; j < data.length; j++) {
							category.push(data[j].category);
							cnt.push(data[j].cnt);
						}
						const ctx = document.getElementById('myChart')
								.getContext('2d');
						const myChart = new Chart(ctx, {
							type : 'pie', // bar, pie, line, doughnut, polarArea 옵션들을 선택
							data : {
								labels : category,
								datasets : [{
									label: '월간 분류별 대출량',
									borderWidth: 3,
									data : cnt, //데이터 수치를 넣으면 자동으로 조절(10% 이하는 텍스트 노출이 안됨.)
									//backgroundColor: ['#FB3640', '#EFCA08', '#43AA8B', '#253D5B','#ffd950', '#02bc77', '#28c3d7', '#FF6384','#FFFFFF','#D0FC5C']
									backgroundColor : randomColor(category)
								} ]
							},
							options : {
								responsive : false,
								maintainAspectRatio: false,
								legend : {
									position : 'bottom'
								},
								plugins : {
									datalabels : {
										color : [ '#fff', '#fff', '#fff',
												'#fff' ],
										borderWidth : 2,
										borderColor : [ '#fff', '#fff', '#fff',
												'#fff' ],
										borderRadius : 25,
										anchor : 'center',
/* 										formatter: function(value, context) {
				                                return (value > 3) ? value+ "%" : null //data가 10 미만이면 숫자 값은 출력x
				                        } */
									},
								}
							}
						});
						
						// 테이블 생성
						var table = document.createElement('table');
						table.className = 'table table-bordered';
						var thead = document.createElement('thead');
						var tbody = document.createElement('tbody');

						// 테이블 헤더 생성
						var tr = document.createElement('tr');
						var th = document.createElement('th');
						th.textContent = 'category';
						tr.appendChild(th);
						th = document.createElement('th');
						th.textContent = 'amount';
						tr.appendChild(th);
						thead.appendChild(tr);
						table.appendChild(thead);

						// 테이블 본문 생성
						for (var i = 0; i < category.length; i++) {
							var tr = document.createElement('tr');
							var td = document.createElement('td');
							td.textContent = category[i];
							tr.appendChild(td);
							td = document.createElement('td');
							td.textContent = cnt[i];
							tr.appendChild(td);
							tbody.appendChild(tr);
						}
						table.appendChild(tbody);

						// 테이블을 삽입할 위치를 찾아서 테이블을 삽입
						var chartWrapper = document.querySelector('.chart-table');
						chartWrapper.appendChild(table);
					}
				});
	}
</script>
<style>
.chart-wrapper {
position: absolute;
left: 300px;
width: 700px;

}
</style>
</head>
<body>
<nav>
	<jsp:include page="admin_header.jsp" />
<div id="body-wrapper">
	<div id="body-content">
			<jsp:include page="/admin/menu.jsp" />
	<div style="width:1000px;">
	<div class="page-direction" style="padding: 20px; padding-left: 250px;">
	<div class="navi">
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;도서통계</span> <i class="bi bi-chevron-right"></i>
			<span style="font-weight:bold;">월간 분류별 대출량</span>
	</div>
	</div>
	
		<div class="chart-wrapper">
			<canvas id="myChart" class="chartjs-render-monitor" width="500px"
				height="400px" style="float: left;"></canvas>
			<div style="width: 200px;height: 200px; float: left;">
				<div class="chart-table"></div>
			</div>
		</div>
		</div>
			</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</nav>
</body>
</html>