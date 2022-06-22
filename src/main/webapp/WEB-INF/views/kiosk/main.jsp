<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/kioskStyle.css">
<style></style>
</head>
<body>
	<a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div>
        <div class="book">
            <button id="borrow" onclick="location.href='ki_borrow.go'">대출</button>
            <button id="return" onclick="location.href='ki_return.go'">반납</button>
        </div>
        <div class="study">
            <button onclick="location.href='seat.html'">열람실</button>
        </div>
    </div>
</body>
<script></script>
</html>