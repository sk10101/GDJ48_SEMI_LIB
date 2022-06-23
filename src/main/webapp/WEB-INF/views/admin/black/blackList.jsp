<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    .detail {
        right: 0;
    }
    table.bbs {
		width: 50%;
	}
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td {
		padding: 10px 10px;
	}
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
	<h3>블랙리스트 기본</h3>
	    <table class="bbs">
	        <thead>
	            <tr>
	                <td>회원ID</td>          
	                <td>지정한 관리자ID</td>           
	                <td>지정일</td>           
	                <td>해제한 관리자ID</td>       
	                <td>해제일</td>      
	            </tr>
	        </thead>
	        <tbody>
				<c:forEach items="${blackList }" var="dto">
					<tr>
						<td><a href="blackDetail.do?black_id=${dto.black_id }">${dto.mb_id }</a></td>
						<td>${dto.admin_start }</td>
						<td>${dto.black_start }</td>
						<td>${dto.admin_end }</td>
						<td>${dto.black_end }</td>
					</tr>
				</c:forEach>
			</tbody>
	    </table>
	<input type="button" value="추가" onclick="location.href='blackAdd.go'">
</body>
<script></script>
</html>