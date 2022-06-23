<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	  		h3 {text-align: left; font-weight: bold; font-size: 40px;}
            table {width: 80%}
            table, th, td {border: 1px solid black; border-collapse: collapse;}
            th, td{padding: 5px 10px; text-align: center;}
            input[type='text'] {width: 100%;}
            textarea {width: 100%; height : 150px; resize: none;}
            button{margin-bottom: 5px; float: right;}
</style>
</head>
<body>
       <table class="notice">
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
                    <th>내용</th>
                    <td>${notice.notice_content}</td>
                </tr>
                <c:if test="${noticeList.size() >0 }">
                <tr>
                    <th>첨부파일</th>
                    <td>
                    	<c:forEach items="${noticeList}" var="path">
                    			<img src="/photo/${path.newFileName}" width="500" />
                    	</c:forEach>
                    </td>
                </tr>
                </c:if>
        </table>
        <button onclick="location.href='notice.go'">돌아가기</button>
    </body>
    <script>
        
    </script>
</html>