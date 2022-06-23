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
	<h3>대출내역</h3>
    <tr>
        <th colspan="2"/>
            <th><a href="#">대출내역</a></th>
            <th><a href="/memberHis.do">이전 대출내역</a></th>
            <th><a href="/memberReserve.do">예약내역</a></th>
            <td>회원 ID:</td>
    </tr>
    <table class="bbs">
        <thead>
            <tr>
                <td>대출번호</td>          
                <td>도서제목</td>           
                <td>대출일</td>           
                <td>반납예정일</td>       
                <td>대출상태</td>      
                <td>연장여부</td>
            </tr>
        </thead>
        <tbody>
			<c:forEach items="${memberBrw }" var="dto">
				<tr>
					<td><a href="memberDetail.do?mb_id=${dto.mb_id }">${dto.mb_id }</a></td>
					<td>${dto.name }</td>
					<td>${dto.phone }</td>
				</tr>
			</c:forEach>
		</tbody>
    </table>
</body>
<script></script>
</html>