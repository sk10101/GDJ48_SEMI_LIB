<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/book.css">
<style></style>
</head>
<body>
    <!-- header start -->
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">마이페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <!-- header end -->
    <section>
        <div class="search">
            <input type="text" placeholder="도서 검색">
            <button type="submit" class="btn_search"></button>
            <select name="option">
                <option value="all" selected>전체</option>
                <option value="title">제목</option>
                <option value="writer">저자</option>
                <option value="publisher">출판사</option>
            </select>
        </div>

        <tasble>

        <table>

            <thead>
                <th>책표지</th>
                <th>제목</th>
                <th>저자</th>
                <th>출판사</th>
                <th>도서상태</th>
                <th>예약가능여부</th>
            </thead>
            <tbody>
				<c:forEach items="${dto}" var="dto">
					<tr>
						<td>${dto.b_id}</td>
						<td><a href="bookDetail.do?b_id=${dto.b_id}">${dto.b_title}</a></td>
						<td>${dto.writer}</td>
						<td>${dto.publisher}</td>
						<td>${dto.b_status}</td>
						<td>${dto.publisher}</td>
					</tr>
				</c:forEach>
            </tbody>
        </table>
    </section>
</body>
<script></script>
</html>