<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인(키오스크)</title>
<link rel="stylesheet" href="resources/css/kioskStyle.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style></style>
</head>
<body>
	<form action="ki_login.do" method="post">
        <div class="int-area">
            <input type="text" placeholder="ID" name="id" id="id" autocomplete="off" required>
        </div>
        <div class="int-area">
            <input type="password" placeholder="PW" name="pw" id="pw" autocomplete="off" required>
        </div>
        <div class="btn-area">
            <button type="submit">로그인</button>
        </div>
    </form>
</body>
<script>
var msg = "${msg}";

if (msg != "") {
	alert(msg);
}
</script>
</html>