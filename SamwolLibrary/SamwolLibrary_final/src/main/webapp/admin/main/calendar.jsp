<%@page import="java.util.Calendar"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <%
 	request.setCharacterEncoding("utf-8");
 	Calendar cal=Calendar.getInstance(); //현재 시스템이 가지고 있는 날짜 데이터 가지고 오기
	
 	int nowy=cal.get(Calendar.YEAR);
 	int nowm=cal.get(Calendar.MONTH)+1;
 	int nowd=cal.get(Calendar.DATE);
 	int today=cal.get(Calendar.DATE);
 	
 	int y=cal.get(Calendar.YEAR);
 	int m=cal.get(Calendar.MONTH)+1;
 	int d=cal.get(Calendar.DATE);
 	String _y=request.getParameter("y");
 	String _m=request.getParameter("m");

 	if(_y!=null)
 		y=Integer.parseInt(_y);
 	if(_m!=null)
 		m=Integer.parseInt(_m);
 	// y년 m월 1일의 요일
 	cal.set(y,m-1,1);

 	y=cal.get(Calendar.YEAR);
 	m=cal.get(Calendar.MONTH)+1;
 	int w=cal.get(Calendar.DAY_OF_WEEK); //1(일)~7(토) => 일요일일때 w에 1. 메소드를 외우면 된다.

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" href="../include/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="../include/js/bootstrap.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- <style type="text/css">

	*{margin:0px; padding:0px;font-famaily: 돋움; font-size: 9pt;}

	td{font-size: 9pt;}

	a{text-decoration: none;}

	a:HOVER{text=decoration: underline;color:black;}

</style> -->
<style>
.pl{
    width: 95px;
    height: 40px;
    border: 1px solid #C4C4C4;
    box-sizing: border-box;
    border-radius: 8px;
    padding: 10px 11px;
    font-style: normal;
    font-weight: 300;
    font-size: 14px;
    line-height: 5px;
}

.pl:focus{
    border: 1px solid #9B51E0;
    box-sizing: border-box;
    border-radius: 8px;
    outline: 3px solid #f5817a;
    border-radius: 10px;
}

.calt {
  border-collapse: collapse;
  width: 250px;
  margin: 0rem auto;
  box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
  background-color: white;
  cellpadding:0;
  cellspacing:1;
  margin-top: 10px;
}
.date {
  font-size:20px;
  font-style:normal;
  font-weight: 300;
}
.hh {
  color: white;
}

/* th, td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
  text-align: center;
} */
</style>
<script type="text/javascript">

 

function changeDate(){

	var y=document.getElementById("y").value;
	var m=document.getElementById("m").value;
	var url="/syLibrary/admin/admin_main.jsp?y="+y+"&m="+m;
	location.href=url; //url이 가지고 있는 값으로 이동
	
}
</script>
</head>
<body>
<br>
<center>

<caption style=" height :45px; padding:10px;">

<select id="y" name="y" class="pl" onchange="changeDate()">

<% for(int i=y-5; i<=y; i++){%>

	<option value="<%=i %>"><%=i %>년</option>

<%} %>

	<option value="<%=y %>" selected="selected"><%=y%>년</option>

<% for(int i=y+1; i<=y+5; i++){%> 

	<option value="<%=i %>"><%=i %>년</option>

<%} %>

</select>

<select id="m" name="m" class="pl" onchange="changeDate()">

<% for(int i=1; i<=12; i++){%>

	<option value="<%=i %>"<%=m==i?"selected='selected'":"" %>><%=i %>월</option>

<%} %>

</select>


</caption>

<table class="calt">
<tr height="35" class="hh">

	<td width="60" bgcolor="#f5817a" align="center">S</td>
	<td width="60" bgcolor="#f5817a" align="center">M</td>
	<td width="60" bgcolor="#f5817a" align="center">T</td>
	<td width="60" bgcolor="#f5817a" align="center">W</td>
	<td width="60" bgcolor="#f5817a" align="center">T</td>
	<td width="60" bgcolor="#f5817a" align="center">F</td>
	<td width="60" bgcolor="#f5817a" align="center">S</td>

</tr>
<%	


	//1일 앞부분 공백처리
	out.println("<tr height='35'>");
	for(int i=1; i<w; i++){ // 6월의 1일은 토요일이라 w=7 따라서 공백 6번을 써준다.
		out.println("<td bgcolor='#ffffff'>&nbsp;</td>" );
	}

	//1~마지막일 계산
	//1일부터 마지막 날까지 날짜를 출력하면서 오늘 날짜면 동그라미로 표시
	String fc;
	for(int i=1; i<=cal.getActualMaximum(Calendar.DATE); i++){
		fc=w%7==1?"red":(w%7==0?"blue":"black");
		 String circleStyle = (i == today && y == nowy && m == nowm) ? "border-radius: 50%; background-color: #FFDBDB; padding: 5px;" : ""; // 오늘 날짜면 네모로 스타일 지정
		out.println("<td align='center' bgcolor='#ffffff' style='color:"+fc+";"+circleStyle+"'>");
		out.print(i+"</td>");
		w++;
		if(w%7==1&&i!=cal.getActualMaximum(Calendar.DATE)){
			out.println("</tr>");
			/* out.println("<tr height='100'>"); // 공백 부분 */
			/* for(int j=1; j<=7;j++)
				out.println("<td align='center' bgcolor='#ffffff';>&nbsp;</td>");
				out.println("</tr>"); */					//  공백 부분
			out.println("<tr height='35'>");
		}
	}
	


	
	// 뒷부분 공백처리

	if(w%7!=1){

		if(w%7==0){

			out.println("<td bgcolor='#ffffff'>&nbsp;</td>");

		}else{

		for(int i=w%7; i<=7; i++)

			out.println("<td bgcolor='#ffffff'>&nbsp;</td>");

	}

	out.println("</tr>");

	}
	

%>
</table>

</center>
</body>
</html>