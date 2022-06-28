<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
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
    input[type='text'] {
        width: 10%;
    }
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
	<h3>이용정지내역 기본</h3>
    <table class="bbs">
        <thead>
            <tr>
            	<td>No</td>
                <td>회원ID</td>          
                <td>제한내역</td>           
                <td>이용정지날짜</td>           
                <td>이용정지종료날짜</td>       
                <td>취소</td>      
            </tr>
        </thead>
        <tbody>
				<c:forEach items="${penaltyList}" var="dto">
			<tr>
				<td>${dto.penalty_id}</td>
				<td><a href="penaltyDetail.do?penalty_id=${dto.penalty_id}">${dto.mb_id }</a></td>
				<c:choose>
         			<c:when test="${dto.category_id eq '5'}">
             			<td>대출연체</td>
         			</c:when>
         			<c:otherwise>
              			<td>예약만료</td>
         			</c:otherwise>
    			</c:choose>
				<td>${dto.penalty_start}</td>
				<td>${dto.penalty_end }</td>
				<c:choose>
         			<c:when test="${dto.cancel eq 'true'}">
             			<td>Y</td>
         			</c:when>
         			<c:otherwise>
              			<td>N</td>
         			</c:otherwise>
    			</c:choose>
			</tr>
		</c:forEach>
		</tbody>
    </table>
    <br/>
    <div>
        <select id="option">
            <option value="member">회원ID</option>
            <option value="bantext">제한내역</option>
        </select>
        <input type="text" placeholder="검색"/>
        <button type="submit">검색</button>
    </div>
</body>
<script>


</script>
</html>