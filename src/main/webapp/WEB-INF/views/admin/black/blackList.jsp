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
    <div class="header">
        <th>***님 환영합니다.</th>
        <a href="#">로그아웃</a>
        <a href="#">관리자페이지</a>
    </div>
    <br/>
    <tr>
        <th colspan="2">
            <th><a href="detail02.html">대출내역</a></th>
            <th><a href="detail03.html">이전 대출내역</a></th>
            <th><a href="#">예약내역</a></th>
            <td>회원 ID:</td>
        </th>
    </tr>
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
        <tbody id="list">
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
    <div>
        <input type="text" placeholder="검색"/>
        <button type="submit">검색</button>
    </div>
</body>
<script></script>
</html>