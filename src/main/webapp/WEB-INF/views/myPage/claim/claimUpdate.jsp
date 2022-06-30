<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>건의사항 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/claim.css">
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
	        <h3>마이페이지</h3>
	        <hr style="border:none; height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="/brwHistory">도서내역</a><br/>
	        <br/>
	        <a class="tabSelect" href="claimList">건의사항</a><br/>
	        <br/>
	        <a href="#">회원정보</a>
	    </div>
    	<div class="section" id="main_content">
	    	<form class="claimTable-area" action="claimUpdate.do" method="post" enctype="multipart/form-data">
		        <table class="claim_table" id="claim_writeForm">
		            <tr>
		                <th class="claimTableTh">제목</th>
		                <td>
		                	<input type="hidden" name="claim_id" value="${claim.claim_id}"/>
		                	<input class="claimWriteInput" type="text" name="claim_title" value="${claim.claim_title}"/>
		                </td>
		            </tr>
		            <tr>
		                <th>내용</th>
		                <td><textarea class="claimWriteInput" id="claimWriteTextarea" name="claim_content">${claim.claim_content}</textarea></td>
		            </tr>
		            <tr>
		                <th>이미지</th>
		                <td>
		                	<input type="file" name="photos" multiple="multiple"/>
		                	<c:forEach items="${claimList}" var="path">
								<p><img src="/image/${path.newFileName}" width="500"/></p>
							</c:forEach>
		                </td>
		            </tr>
		        </table>
		        <div class="claimWritePageBtn-area">
					<input class="claimBtn" type="submit" value="저장"/>
					<input class="claimBtn" type="button" value="목록" onclick="location.href='/claimList'"/>
				</div>	
	        </form>
    	</div>
    </div>
</body>
<script></script>
</html>