<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완료창(키오스크)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://kit.fontawesome.com/5415520417.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/kioskStyle.css">
<style></style>
</head>
<body>
	<a href="ki_main.go">
        <i class="fa-solid fa-house back"></i>
    </a>
    <a href="ki_logout.do">
        <i class="fa-solid fa-arrow-right-from-bracket logout"></i>
    </a>
    <div class="alert">
        ${msg}완료 되었습니다.
    </div>
</body>
<script></script>
</html>