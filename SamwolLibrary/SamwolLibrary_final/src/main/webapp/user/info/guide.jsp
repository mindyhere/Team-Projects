<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/syLibrary/resources/images/icon.png"
	type="image/x-icon">
<link rel="stylesheet" href="/syLibrary/include/user.css">
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<div class="card-style mb-30">
			<h3 class="text-bold">
				<img src="/syLibrary/resources/images/info.png" width="35px"
					height="35px"> 대출/예약/반납
			</h3>
			<hr>
			<!-- 이용안내_자료이용방법_대출/반납/예약_정보화 -->
			<h5 class="htitle">대출방법 및 규정</h5>
			<table class="tbl" style="border-collapse: collapse;">
				<colgroup>
					<col style="width: 15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구분</th>
						<th colspan="2">내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">대출 자격</th>
						<td class="ta_l">홈페이지에서 회원가입 후 회원카드를 발급받은 회원에 한해 대출 가능</td>
					</tr>
					<tr>
						<th scope="row">대출 조건</th>
						<td class="ta_l">회원 본인카드는 본인만 사용가능 <br /> 회원 1인당
							5책(까지) 14일(동안)/ 예약자 없을 시 7일 연기 가능(1회만 가능)
						</td>
					</tr>
				</tbody>
			</table>

			<h5 class="htitle">반납</h5>
			<table class="tbl">
				<colgroup>
					<col style="width: 15%" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구분</th>
						<th colspan="2">내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">규정</th>
						<td class="ta_l">어린이실 도서는 어린이실에 반납 (어린이실 폐관이후에는 종합자료관에 반납)<br />
							종합자료관 도서는 종합자료관에 반납(1관, 2관 구분없이 가능)
						</td>
					</tr>
				</tbody>
			</table>

			<h5 class="htitle">폐관 및 휴관시 반납</h5>
			<table class="tbl">
				<colgroup>
					<col style="width: 15%" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구분</th>
						<th colspan="2">내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">규정</th>
						<td class="ta_l">폐관 및 휴관시에는 도서관 정문 오른쪽에 설치되어 있는 무인반납기에서 반납해
							주시기 바랍니다.<br /> (무인반납기에서 처리 안되는 자료는 무인반납함에 반납 가능)
						</td>
					</tr>
				</tbody>
			</table>

			<ul>
				<li>무인반납함에서 반납한&nbsp;도서는 다음 개관일 오전에 처리됩니다.</li>
				<li>연체도서는 자동으로 연체일수만큼 대출정지 처리됩니다.</li>
				<li>개관시간 중에는 반드시 자료실로 반납해 주시기 바랍니다.</li>
			</ul>

			<h5 class="htitle">반납 연기</h5>
			<div class="tblWrap">
				<table class="tbl">
					<colgroup>
						<col style="width: 15%" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th colspan="2">내용</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">규정</th>
							<td class="ta_l">1회 7일 연기 (단, 예약이 되어 있는 도서 및 상호대차 도서는 연기 불가)<br />
								연체 중인 도서는 연기 불가
							</td>
						</tr>
						<tr>
							<th scope="row">방법</th>
							<td class="ta_l">
								<ul class="dash-list">
									<li>도서관 홈페이지 로그인 &rarr; 나의도서관 &rarr; 도서이용정보 &rarr;
										대출현황조회에서 반납연기 신청</li>
									<li>전화신청(02-960-1959)</li>
									<li>도서관 방문</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<h5 class="htitle">자료 예약</h5>
			<div class="tblWrap">
				<table class="tbl">
					<colgroup>
						<col style="width: 15%" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th colspan="2">내용</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">대상</th>
							<td class="ta_l">현재 대출 중인 도서에 한해서만 가능</td>
						</tr>
						<tr>
							<th scope="row">규정</th>
							<td class="ta_l">한 자료당 최대 5명(1~5순위)까지, 1인당 5권까지 예약 가능<br />
								예약도서 대출안내 받으신 후 3일 이내 대출해 주시기 바랍니다.기간이 지나면 다음 순위 예약자에게 대출됩니다.
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<h5 class="htitle">연체 규정</h5>
			<div class="tblWrap">
				<table class="tbl">
					<colgroup>
						<col style="width: 15%" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th colspan="2">내용</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">대출정지</th>
							<td class="ta_l">연체시 연체일수만큼 대출정지</td>
						</tr>
						<tr>
							<th scope="row">연체료</th>
							<td class="ta_l">
								<ul class="dot-list">
									<li>1일 1권당 100원</li>
									<li>연체일수 &times; 연체권수 &times; 100원 (2권의 책을 3일 연체한 경우
										3&times;2&times;100=600원)</li>
									<li>연체료는 최대 대출자료 시가의 50%까지만 적용</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<p class="ref">연체자료를&nbsp;모두 반납한&nbsp;후 대출정지&nbsp;해제를
				위하여&nbsp;연체료를 납부할 수 있으며, 납부&nbsp;후에는 다시 변경할 수 없습니다.</p>
		</div>
	</div>
</body>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>