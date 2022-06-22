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
            <button class="btn_bookAdd" onclick="location.href='bookAdd.go' ">도서추가</button>
            <table>
                <thead>
                    <th>책ID</th>
                    <th>제목</th>
                    <th>저자</th>
                    <th>출판사</th>
                    <th>도서상태</th>
                    <th>등록일</th>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="dto">
                        <tr>
                            <td>${dto.b_id}</td>
                            <td><a href="bookDetail.do?b_id=${dto.b_id}">${dto.b_title}</a></td>
                            <td>${dto.writer}</td>
                            <td>${dto.publisher}</td>
                            <td>${dto.b_status}</td>
                            <td>${dto.b_date}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="search">
                <input type="text" placeholder="도서검색"/>
                <button class="btn_bookSearch" onclick="#"></button>
            </div>
        </div>
    </section>
</body>
<script></script>
</html>