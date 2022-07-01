<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 추가</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
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