<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>도서추가</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">
<link rel="icon" href="resources/img/favicon.png">
<style></style>
</head>
<body>
    <div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
    <aside id="menu">
        <h1>관리자페이지</h1>
        <hr/>
        <ul class="admin_menu">
            <li><a href="memberList.go">회원관리</a></li>
            <li><a href="bookList.go">도서관리</a></li>
            <li><a href="claimList">건의사항</a></li>
            <li><a href="blackList.go">블랙리스트</a></li>
            <li><a href="penaltyList.go">이용정지내역</a></li>
        </ul>
    </aside>
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
</body>
<script>
var msg = "${msg}"
if (msg != "") {
	alert(msg);
}
</script>
</html>