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
	<h3>블랙리스트 회원 상세보기</h3>
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
            <th>관리자ID</th>
            <td></td>
        </tr>
        <tr>
            <th>지정일자</th>
            <td></td>
        </tr>
        <tr>
            <th>지정사유</th>
            <td></td>
        </tr>
        <tr>
            <th>해제</th>
            <td><input type="checkbox" name="b" value="cancel"/></td>
        </tr>
        <tr>
            <th>해제사유</th>
            <td><input type="text" name="a" value=""/></td>
        </tr>
    </table>
    <div>
        <button>돌아가기</button>
        <button>수정</button>
    </div>
</body>
<script></script>
</html>