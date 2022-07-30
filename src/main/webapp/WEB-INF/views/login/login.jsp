<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>로그인</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" href="../resources/css/login.css">
  <link rel="icon" href="../resources/img/favicon.png">
</head>
<body>
	<div class="logo">
            <a href="/"><img src="../resources/img/logo.png" class="logo"/><br/></a>
    </div>
  	<div class="login-form">
    	<form action="./login.do" method="POST">
	        <div class="login-area">
	            <input type="text" name="id" id="id" placeholder="아이디"/>
	        </div>
	        <div class="login-area">
	            <input type="password" name="pw" id="pw" placeholder="비밀번호"/>
	        </div>
	        <div class="btn-area">
	            <input type="submit" id="login" value="로그인">
	            <input type="button" id="join" value="회원가입" onclick="location.href='./member/joinForm.go'"/>
	        </div>
	        <div class="links">
		       	<a href="./member/idFind">ID 찾기</a> 
		       	 || 
		       	<a href="./member/pwFind">PW 찾기 </a>
	       	</div>
        </form>
    </div>
</body>
<script>
	var msg = "${msg}"
	if (msg != "") {
		alert(msg);
	}
</script>
</html>