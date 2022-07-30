<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
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
	    	<h3>공지사항 작성</h3>
	    </div>
		<form action="noticeWrite.do" method="post" enctype="multipart/form-data">
       		<input type="hidden" name="mb_id" />
       		<table class="noticeWrite">
                <tr>
                    <th>제목</th>
                    <td><input class="noticeWriteSubject" type="text" name="notice_title" /></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea class="noticeWriteContent" name="notice_content"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td><input type="file" name="photos" multiple="multiple" /></td>
                </tr>
                 <input type="hidden" name="notice_id" value="${sessionScope.loginId}"/>
        	 </table>
	     	 <div class="noticeWriteBtn-area">
	        	<input class="noticeWriteBtn" type="submit" value="저장" />
	       		<input class="noticeWriteBtn" type="button" value="취소" onclick="location.href='noticeList'">
	       	 </div>	
     	 </form>
     </div>
</body>
<script>
	var msg = "${msg}"
	if (msg != "") {
		alert(msg);
	}
</script>
</html>