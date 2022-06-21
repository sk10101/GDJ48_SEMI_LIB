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
	<h3>블랙리스트 지정</h3>
    <div class="header">
        <th>***님 환영합니다.</th>
        <a href="#">로그아웃</a>
        <a href="#">관리자페이지</a>
    </div>
    <br/>
    <table class="bbs">
        <tr>
            <td>회원ID</td>          
            <th><input type="text" value=""/></th>            
        </tr>
        <tr>        
            <td>지정사유</td>
            <th><input type="text" value=""/></th>                        
        </tr>
    </table>
    <div>
        <button type="submit">추가</button>
    </div>
</body>
<script></script>
</html>