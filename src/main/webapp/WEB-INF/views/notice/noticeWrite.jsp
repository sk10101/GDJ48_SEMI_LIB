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
            input[type='file'] {float: left;}
            textarea {width: 100%; height : 150px; resize: none;}
            button{margin-bottom: 5px; float: right;}
</style>
</head>
<body>
	<!--   <form action="noticeWrite.do" method="post">-->
       <table class="notice">
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="notice_title" /></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea name="notice_content"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td id="photo_id">
                        <!-- 파일 선택 버튼이 오른쪽으로 갈려면 ? -->
                        <form action="upload" method="post" enctype="multipart/form-data">
                            <input type="file" name="uploadFile" />
                        </form>
                    </td>
                </tr>
        </table>
     <!--   </form> -->
        <button onclick="location.href='noticelist.do'">취소</button>
        <!-- 저장 설정 변경 해야됨 -->
       <button onclick="location.href='noticelist.do'">저장</button>
    </body>
    <script>
        
    </script>
</html>