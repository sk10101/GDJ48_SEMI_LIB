<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 페이지 / 답변 글쓰기</title>
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
    	<form action="replyWrite.do" method="post" enctype="multipart/form-data">
         <table id="reply_writeForm">
             <tr>
                 <th>내용</th>
                 <td>
	                 <input type="hidden" name="claim_id" value="${claim_id}"/>
	                 <textarea name="reply_content">${reply.reply_content}</textarea>
                 </td>
             </tr>
             <tr>
                 <th>이미지</th>
                 <td><input type="file" name="photos" multiple="multiple"/></td>
             </tr>
             <tr>
	           <th colspan="2">
		            <input type="submit" value="저장"/>
					<input type="button" value="취소" onclick="location.href='adminClaimDetail?claim_id=${claim_id}'"/>
				</th>
			</tr>			
         </table>
        </form>
    </div>
</body>
<script></script>
</html>