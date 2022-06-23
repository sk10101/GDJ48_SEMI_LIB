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
	<form action="blackAdd.do" method="post">
	    <table class="bbs">
	        <tr>
	            <td>회원ID</td>          
	            <th><input type="text" name="mb_id" value="${dto.mb_id }"/></th>            
	        </tr>
	        <tr>        
	            <td>지정사유</td>
	            <th><input type="text"  name="black_reason" value="${dto.black_reason }"/></th>                        
	        </tr>
	    </table>
	    <input type="button" value="돌아가기" onclick="location.href='blackList.do'"/>
	    <input type="submit" value="추가"/>
    </form>
</body>
<script>
	var msg ="${msg}";
	
	if (msg != "") {
		alert(msg);
	}
</script>
</html>