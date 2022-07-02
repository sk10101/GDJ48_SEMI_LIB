<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 추가</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/adminBlack.css"/>
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
		<div class="body">
		<div class="myPageTab" id="myPage_menu">
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a class="tabSelect" href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
	    <div class="section">
	    	<div class="title-area">
		    	<h3>블랙리스트 지정</h3>
		    </div>
		   	<div class="blackAdd-area">
				<form action="blackAdd.do" method="post">
				    <table class="bbs">
				        <tr>
				            <th>회원ID</th>          
				            <td><input type="text" name="mb_id" value="${dto.mb_id }"/></td>            
				        </tr>
				        <tr>        
				            <th>지정사유</th>
				            <td><input type="text"  name="black_reason" value="${dto.black_reason }"/></td>                        
				        </tr>
				    </table>
				    <div class="addBtn-area">
					    <input type="button" value="돌아가기" onclick="location.href='blackList.go'"/>
					    <input type="submit" value="추가"/>
				    </div>
			    </form>
		    </div>
    	</div>
    </div>
</body>
<script>
	
</script>
</html>