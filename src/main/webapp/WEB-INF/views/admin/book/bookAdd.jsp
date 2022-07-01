<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>도서추가</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="icon" href="resources/img/favicon.png">
<style></style>
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
	        <a class="tabSelect" href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
    <section>
        <div class="content">
            <form action="bookAdd.do" method="post" enctype="multipart/form-data">
                <table class="book">
                    <tr>
                        <th>책 제목</th>
                        <td><input type="text" name="b_title"></td>
                    </tr>
                    <tr>
                        <th>저자</th>
                        <td><input type="text" name="writer"></td>
                    </tr>
                    <tr>
                        <th>출판사</th>
                        <td><input type="text" name="publisher"></td>
                    </tr>
                    <tr>
                        <th>발행년도</th>
                        <td><input type="text" name="issue"></td>
                    </tr>
                    <tr>
                        <th>책 표지</th>
                        <td><input type="file" name="b_img"></td>
                    </tr>
                </table>
                <input type="button" value="목록보기" onclick="location.href='bookList.go' "/>
            	<input type="submit" value="도서추가" class="btn_bookAdd"/>
            </form>
        </div>
    </section>
    </div>
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}
</script>
</html>