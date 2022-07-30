<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 페이지 / 답변 수정</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="resources/css/frame.css">
	<link rel="stylesheet" href="resources/css/adminClaim.css"/>
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
	        <a class="tabSelect" href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
	    <div class="section" id="main_content">
	    	<form class="replyForm" action="replyUpdate.do" method="post" enctype="multipart/form-data">
		         <table id="reply_writeForm">
		         	<tr>
		                <th>관리자</th>
		                <td>
		                	<input type="hidden" name="claim_id" value="${claim.claim_id}"/>
		                	<input type="hidden" name="reply_id" value="${reply.reply_id}"/>
		                	${reply.mb_id}
		                </td>
		            </tr>
		            <tr>
		                <th>작성일</th>
		                <td>${reply.reply_date}</td>
		            </tr>
		            <tr>
		                <th>답변 내용</th>
		                <td><textarea name="reply_content">${reply.reply_content}</textarea></td>
		            </tr>
			            <tr>
			                <th>이미지</th>
			                <td>
			                	<input type="file" name="photos" multiple="multiple"/>	
				                <c:forEach items="${replyList}" var="pathR">
									<img src="/image/${pathR.newFileName}" width="640"/>
								</c:forEach>
							</td>
			            </tr>
		         </table>
				<div class="replyFormBtn">
					<input type="submit" value="수정"/>
					<input type="button" value="취소" onclick="location.href='adminClaimDetail?claim_id=${claim.claim_id}'"/>
				</div>					
	        </form>
	    </div>
    </div>
</body>
<script></script>
</html>