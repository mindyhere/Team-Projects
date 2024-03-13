<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-sm table-striped table-hover align-middle text-center" style="">
  <tbody>
	<c:forEach var="dto" items="${list }">
	<tr style="background: #fbf7f5 !important;border-color:#FAE0E0;">
		<th scope="row">&nbsp;&nbsp;&nbsp;&nbsp;@&nbsp;${dto.b_id }</th>
		<td>${dto.b_name }&nbsp;(${dto.b_author }&nbsp;|&nbsp;${dto.b_pub })</td>
		<td>
			<label onclick="insert('${dto.b_id }')"><i class="bi bi-box-arrow-right"></i>&nbsp;&nbsp;&nbsp;&nbsp;</label>
    	</td>
    </tr>
	</c:forEach>
  </tbody>	
</table>	
