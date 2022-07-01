<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 페이지 / 답변 수정</title>
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
    <div id="main_content">
    	<form action="replyUpdate.do" method="post" enctype="multipart/form-data">
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
            <tr>
	          	<th colspan="2">
		            <input type="submit" value="수정"/>
					<input type="button" value="취소" onclick="location.href='adminClaimDetail?claim_id=${claim.claim_id}'"/>
				</th>
			</tr>			
         </table>
        </form>
    </div>
</body>
<script></script>
</html>