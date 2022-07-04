<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/notice.css">
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
		<div class="title">
	    	<h3>공지사항 상세보기</h3>
	    </div>
		<table class="noticeDetail">
		         <tr>
		             <th>제목</th>
		             <td>${notice.notice_title}</td>
		        </tr>
		        <tr>
		            <th>작성자</th>
		            <td>${notice.mb_id }</td>
		        </tr>
		        <tr>
		            <th>작성일</th>
		            <td>${notice.notice_date }</td>
		        </tr>
		      	<tr>
		      		<th>조회수</th>
		      		<td>${notice.hit}</td>
		      	</tr>
		        <tr>
		            <th>내용</th>
		            <td style="vertical-align:top; height:150px;">${notice.notice_content}</td>
		        </tr>
		        <c:if test="${noticeList.size() >0 }">
		        <tr>
		            <th>첨부파일</th>
		            <td>
		            	<c:forEach items="${noticeList}" var="path">
		            			<img src="/image/${path.newFileName}" width="500" />
		            	</c:forEach>
		            </td>
		        </tr>
		        </c:if>
		</table>
		<input type ="button" class="noticeBack" value="돌아가기" onclick="history.back()" />
	</div>
</body>
<script>
</script>
</html>