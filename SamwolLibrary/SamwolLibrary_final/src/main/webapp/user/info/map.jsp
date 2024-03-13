<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="/syLibrary/include/user.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="/syLibrary/include/js/bootstrap.js"></script>
<link rel="stylesheet" href="/syLibrary/include/css/bootstrap.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e210f77be896b9944b8fb0593850ab6"></script>
<style>
.customoverlay {
	position: relative;
	bottom: 85px;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	float: left;
}

.customoverlay:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.customoverlay a {
	display: block;
	text-decoration: none;
	color: #000;
	text-align: center;
	border-radius: 6px;
	font-size: 14px;
	font-weight: bold;
	overflow: hidden;
	background: #d95050;
	background: #d95050
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.customoverlay .title {
	display: block;
	text-align: center;
	background: #fff;
	margin-right: 35px;
	padding: 10px 15px;
	font-size: 14px;
	font-weight: bold;
}

.customoverlay:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: -12px;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container"
		style="float: none; margin: 0 auto; margin-top: 3em">
		<div class="card-style mb-30">
			<h3 class="text-bold">
				<img src="/syLibrary/resources/images/map.png" width="40px"
					height="40px"> 도서관 오는 길
			</h3>
			<hr>
			<div id="map"
				style="width: 90%; height: 500px; border: 1px solid #e5e5e5; border-radius: 20px; margin: auto !important;"></div>
		</div>
		<div class="card-style mb-30">
			<div class="top">
				<h4>
					<span class="mont">Library in March</span> <br /> <b>3월 도서관</b>
				</h4>
				<p>서울 마포구 월드컵북로 21 풍성빌딩 2층</p>
			</div>
			<div class="bot">
				<h5>
					<img src="/syLibrary/resources/images/subway.png" alt="icon" />
					지하철 이용시
				</h5>
				<ul>
					<li>
						<h6>
							<span class="col01">2호선</span> 홍대입구역
						</h6>
						<p>1번출구 도보5분 거리</p>
					</li>
					<li>
						<h6>
							<span class="col02">경의중앙선</span> 홍대입구역
						</h6>
						<p>3번출구 도보9분 거리</p>
					</li>
				</ul>
				<h5>
					<img src="/syLibrary/resources/images/bus.png" alt="icon" /> 버스
					이용시
				</h5>
				<ul>
					<li class="w125">
						<h6>동교로사거리 하차</h6>
						<p>7016, 7711, 7734, 7737, 7739, 마포06, 마포09</p>
					</li>
				</ul>
			</div>
		</div>
	</div>
</body>
<script>
	var mapContainer = document.getElementById('map'), //지도가 나올 div
	mapOption = {
		center : new kakao.maps.LatLng(37.55655, 126.91952),
		level : 3
	};

	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 마커 위치
	var markerPosition = new kakao.maps.LatLng(37.55655, 126.91952);

	// 마커 이미지
	var imageSrc = "/syLibrary/resources/images/marker.png";
	imageSize = new kakao.maps.Size(60, 60);
	imageOption = {
		offset : new kakao.maps.Point(27, 69)
	};

	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
			imageOption);

	// 마커 생성
	var marker = new kakao.maps.Marker({
		position : markerPosition,
		image : markerImage
	});

	// 마커 표시
	marker.setMap(map);

	// 커스텀 오버레이 내용
	var content = '<div class="customoverlay">'
			+ '  <a href="https://map.kakao.com/link/to/3월 도서관, 37.55655, 126.91952" target="_blank">'
			+ '    <span class="title">3월 도서관</span>' + '  </a>' + '</div>';

	// 커스텀 오버레이 위치
	var position = new kakao.maps.LatLng(37.55655, 126.91952);

	// 커스텀 오버레이 생성
	var customOverlay = new kakao.maps.CustomOverlay({
		map : map,
		position : position,
		content : content,
		yAnchor : 1
	});
</script>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>