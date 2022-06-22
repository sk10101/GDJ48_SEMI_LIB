<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/main.css">
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style></style>
</head>
<body>
	<!-- header start -->
    <header id="main_header">
        <nav>
            <ul class="login_menu">
                <li><a href="#">로그인</a></li>
            </ul>
        </nav>
    </header>
    <!-- header end -->
    <section>
        <div class="logo">
            <a href="#"><img src="../resources/img/logo.png" class="logo"/><br/></a>
        </div>
        <form class="search" action="bookSearch.do" method="get">
            <select name="bookSearchOption">
                <option value="all" selected>전체</option>
                <option value="b_title">제목</option>
                <option value="writer">저자</option>
                <option value="publisher">출판사</option>
            </select>
            <input type="text" name="bookSearchWord" placeholder="도서 검색">
            <button type="submit" class="btn_search"></button>
        </form>
        <div class="menu">
            <ul class="icons">
                <li>
                    <a href="#"><img src="../resources/img/mypage.png"/><br/>공지사항</a>
                </li>
                <li><!-- href 나중에 변경해야함 (임시.)-->
                    <a href="/bookList.go"><img src="../resources/img/mypage.png"/><br/>마이페이지</a>
                </li>
                <li>
                    <a href="#"><img src="../resources/img/mypage.png"/><br/>도서반납연기</a>
                </li>
                <li>
                    <a href="#"><img src="../resources/img/mypage.png"/><br/>건의사항</a>
                </li>
                <li>
                    <a href="#"><img src="../resources/img/mypage.png"/><br/>열람실</a>
                </li>
            </ul>
        </div>
    </section>
</body>
<script></script>
</html>