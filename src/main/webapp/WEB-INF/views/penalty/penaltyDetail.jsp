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
	input[type='text'] {
		width: 100%;
	}
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}
	button {
		margin-bottom: 5px;
	}
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
	<h3>이용정지내역 회원상세보기</h3>
	<form action="penaltyUpdate.do" method="get">
	<input type ="hidden" id ="penalty_id" name = "penalty_id" value = "${param.penalty_id}"/>
    <table class="bbs">
        <tr>
            <th>회원ID</th>
            <td>${dto.mb_id }</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${dto.name}</td>
        </tr>
        <tr>
            <th>제한내역</th>
            <c:choose>
       			<c:when test="${dto.category_id eq '5'}">
                     <td>대출연체</td>
         		</c:when>
                <c:otherwise>
                     <td>예약만료</td>
                </c:otherwise>
   			</c:choose>
        </tr>
        <tr>
            <th>이용정지날짜</th>
            <td>${dto.penalty_start }</td>
        </tr>
        <tr>
            <th>이용정지종료날짜</th>
            <td>${dto.penalty_end }</td>
        </tr>
        <tr>
            <th>취소한 관리자ID</th>
            <td>${dto.admin_cancel }</td>
        </tr>
        <tr>
            <th>취소</th>
            <td> <input type="checkbox" id='cancel' name="cancel"<c:if test = "${dto.cancel}"> checked </c:if> value="true"/>
</td> 
			
        </tr>
        <tr>
            <th colspan="2">
                <input type="button" value="돌아가기" onclick="location.href='penaltyList.go'"/>
                <input type="submit" value="수정"/>
            </th>
        </tr>
    </table>
    </form>
</body>
<script>

</script>
</html>