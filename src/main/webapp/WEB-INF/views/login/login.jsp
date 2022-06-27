<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>로그인</title>
  <meta charset="utf-8">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" href="../resources/css/login.css">
</head>
<style>
</style>
<body>
	<div class="logo">
            <a href="/"><img src="../resources/img/logo.png" class="logo"/><br/></a>
    </div>
  	<div class="login-form">
    	<form action="login.do" method="POST">
        <div class="login-area">
            <input type="text" name="id" id="id" placeholder="아이디"/>
        </div>
        <div class="login-area">
            <input type="password" name="pw" id="pw" placeholder="비밀번호"/>
        </div>
        <div class="btn-area">
            <input type="submit" id="login" value="로그인" class="submit-btn">
            <input type="button" id="join" value="회원가입" onclick="location.href='joinForm.go'" class="submit-btn"/>
        </div>
        <div class="links">
	       	<a href="idFind">ID 찾기</a> 
	       	 || 
	       	<a href="pwFind">PW 찾기 </a>
       	</div>
        </form>
    </div>
</body>
<script>
</script>
</html>