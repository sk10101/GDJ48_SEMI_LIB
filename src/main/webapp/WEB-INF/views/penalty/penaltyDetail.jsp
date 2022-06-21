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
    <div class="header">
        <th>***님 환영합니다.</th>
        <a href="#">로그아웃</a>
        <a href="#">관리자페이지</a>
    </div>
    <br/>
    <table class="bbs">
        <tr>
            <th>회원ID</th>
            <td></td>
        </tr>
        <tr>
            <th>이름</th>
            <td></td>
        </tr>
        <tr>
            <th>제한내역</th>
            <td></td>
        </tr>
        <tr>
            <th>이용정지날짜</th>
            <td></td>
        </tr>
        <tr>
            <th>이용종료날짜</th>
            <td></td>
        </tr>
        <tr>
            <th>취소한 관리자ID</th>
            <td></td>
        </tr>
        <tr>
            <th>취소</th>
            <td><input type="checkbox" name="b" value="cancel"/></td>
        </tr>
        <tr>
            <th colspan="2">
                <input type="button" value="돌아가기" onclick=""/>
                <input type="button" value="수정" onclick=""/>
            </th>
        </tr>
    </table>
</body>
<script></script>
</html>