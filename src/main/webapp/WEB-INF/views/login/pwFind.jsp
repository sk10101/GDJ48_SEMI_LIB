<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/login.css">
<link rel="icon" href="../resources/img/favicon.png">
</head>
<body>
	<h3 id="title">비밀번호 찾기</h3>
	<table>
		<tr>
			<th class="col1">아이디</th>
			<td class="FindCol2">
				<input type="text" id="id"/>
			</td>
		</tr>
		<tr>
			<th class="col1">이메일</th>
			<td class="FindCol2"><input type="email" id="email"/></td>
		</tr>
	</table>
	<div class="FindBtn-area">
		<input class="FindBtn" type="button" value="PW찾기" onclick="pwFind()"/> 
		<input class="FindBtn" type="button" value="취소" onclick="location.href='../login.go'"/>
	</div>
</body>
<script>
 function pwFind(){
	var id = $("#id").val()
	var email =$("#email").val()	
	
	$.ajax({
		type:'get',
		url:'pwFind.ajax',
		data:{
			id :id,
			email :email
			},
		dataType:'text',
		success:function(data){			
			if(data){
				alert("고객님의 비밀번호는 : "+ data + "입니다");
				 location.href="../login.go"
			}else{
				alert("고객님의 id 또는 email 이 일치하지 않습니다.");				
			}
		},
		error:function(e){
			console.log(e);
		}			
	});
}

 






</script>
</html>