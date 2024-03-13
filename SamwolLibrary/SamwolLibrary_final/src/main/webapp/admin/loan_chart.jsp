<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<script>

$(document).ready(function(){
	getGraph();
});


function getGraph() {
	let dateList = [];
	let bookList=[];
	$.ajax({
		url: "/syLibrary/admin_servlet/chart.do",
		type: "get",
		dataType:"json",
		ContentType: "text/html;charset=utf-8",
		success: function(data){
			for (let i=0; i<7; i++) {
				dateList.push(data[i].L_LODATE);
				bookList.push(data[i].LOAN_BOOK);	
			}	
			const chartEl = document.getElementById('chart-container').getContext('2d');
		    const barChart = new Chart(chartEl, {
		        type: 'bar',
		        data: {
		            labels: dateList,
		            datasets: [{
		                label: '주간 도서 대출량',
		                borderWidth: 3,
		                backgroundColor: ['#FB3640', '#EFCA08', '#43AA8B', '#253D5B','#ffd950', '#02bc77', '#28c3d7'],
		                data: bookList
		            }]
		        },
		        options: {
		        	responsive: false,
		        	maintainAspectRatio: false,
		        	datalabels: false		        
		        }
		    });
		    var table = document.createElement('table');
			table.className = 'table table-bordered';
			var thead = document.createElement('thead');
			var tbody = document.createElement('tbody');
			
			var tr = document.createElement('tr');
			var th = document.createElement('th');
			th.textContent = 'date';
			tr.appendChild(th);
			th = document.createElement('th');
			th.textContent = 'amount';
			tr.appendChild(th);
			thead.appendChild(tr);
			table.appendChild(thead);
			
			for (var i = 0; i < 7; i++) {
				var tr = document.createElement('tr');
				var td = document.createElement('td');
				td.textContent = dateList[i];
				tr.appendChild(td);
				td = document.createElement('td');
				td.textContent = bookList[i];
				tr.appendChild(td);
				tbody.appendChild(tr);
			}
			table.appendChild(tbody);
			
			var chartWrapper = document.querySelector('.chart-table');
			chartWrapper.appendChild(table);
		}
	});
}
</script>
<style>
.row {
position: absolute;
left: 300px;
width: 1000px;
}

.chart-table{
tr-width:200px;
}
</style>
<body>
<jsp:include page="admin_header.jsp" />
<div id="body-wrapper">
	<div id="body-content">
			<jsp:include page="/admin/menu.jsp" />
<div style="width:1000px;">
	<div class="page-direction" style="padding: 20px; padding-left: 250px;">
	<div class="navi">
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;도서통계</span> <i class="bi bi-chevron-right"></i>
			<span style="font-weight:bold;">주간 도서 대출량</span>
	</div>
	</div>

        <div class="row">
                <canvas id="chart-container" width="500px" height="400px"></canvas>  
                <div style="width: 300px; height: 200px; margin:30px;">
				<div style="width: 200px;" class="chart-table"></div>
			</div> 
            </div>
            </div>
	</div>
	<jsp:include page="/admin/admin_footer.jsp" />
</div>
</body>
</html>