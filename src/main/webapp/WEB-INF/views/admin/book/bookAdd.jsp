<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">
<style></style>
</head>
<body>
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">관리자페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <aside id="menu">
        <h1>관리자페이지</h1>
        <hr/>
        <ul class="admin_menu">
            <li><a href="#">회원관리</a></li>
            <li><a href="#">도서관리</a></li>
            <li><a href="#">건의사항</a></li>
            <li><a href="#">블랙리스트</a></li>
            <li><a href="#">이용정지내역</a></li>
        </ul>
    </aside>
    <section>
        <div class="content">
            <form action="bookAdd.do" method="post" enctype="multipart/form-data">
                <table class="book">
                    <tr>
                        <th>제목</th>
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
                        <th>책표지</th>
                        <td><input type="file" name="b_img"></td>
                    </tr>
                </table>
                <input type="button" value="목록보기" onclick="location.href='bookList.go' "/>
            	<input type="submit" value="도서추가" class="btn_bookAdd"/>
            </form>
        </div>
    </section>
</body>
<script></script>
</html>