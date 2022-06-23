<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>로그인</title>
  <meta charset="utf-8">
</head>
<style>
* {
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
    border-radius: 5px;
  }
   
  body {
    margin: 0;
   
  }
   
  .login-form {
      width: 400px;
      background-color: #69c464;
      margin-right: auto;
      margin-left: auto;
      margin-top: 50px;
      padding: 20px;
      text-align: center;
      border: none;
      
  }
   
  .text-field {
        font-size: 14px;
        padding: 10px;
        border: none;
        width: 260px;
        margin-bottom: 10px;
   
  }
   
  .submit-btn {
    font-size: 14px;
    padding: 10px;
    width: 125px;
    background-color: white;
    color: rgb(5, 5, 5);
  }
   
  .links {
      text-align: right;
  }
  h3{
    text-align: center;
  }
  .logo{
    font-size: 30px;
    font-weight: bold;
    width: 300px;
    height: 200px;
    text-align: center; 
    /* line-height: 120px; */
    margin-bottom: 70px;
}
 section{
    width:100%;
    display: flex;
    flex-direction: column;
    /* justify-content: center; */
    align-items: center;
}
  
  </style>
<body>
<section>
	<div class="logo">
            <a href="#"><img src="../resources/img/logo.png" class="logo"/><br/></a>
        </div>
  
  <div class="login-form">
    <form action="login.do" method="POST">
        <table>
        	
            <input type="text" name="id" class="text-field" placeholder="아이디">
            <input type="password" name="pw" class="text-field" placeholder="비밀번호">
        </table>
        <br>
            <input type="submit" value="로그인" class="submit-btn">
            <input type="button" value="회원가입" onclick="location.href='joinForm.go'" class="submit-btn"/>
            <div class="links">
         	<a href="idFind">ID 찾기</a> 
        	<a href="pwFind">PW 찾기 </a>
    </div>
        </form>
       
				
	</section>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>