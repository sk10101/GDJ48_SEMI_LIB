<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/login.css">
<link rel="icon" href="../resources/img/favicon.png">
</head>
<body>
	<h3 id="title">ID 찾기</h3>
	<table class="idFindTable">
		<tr>
			<th class="col1">이메일</th>
			<td class="FindCol2">
				<input type="email" id = "email"/>
			</td>
		</tr>
	</table>
	<div class="FindBtn-area">
		<button class="FindBtn" type="button" onclick="idFind()">ID찾기</button>
		<button class="FindBtn" type="button" onclick="location.href='/member/login'">취소</button>
	</div>
</body>
<script>
function idFind(){
	var email =$("#email").val()	
	$.ajax({
		type:'get',
		url:'idFind.ajax',
		data:{email :email},
		dataType:'text',
		success:function(data){			
			if(data){
				alert("고객님의 아이디는 : "+ data + "입니다");
				 location.href="/member/login"
			}else{
				alert("고객님의 정보를 찾을수 없습니다.");				
			}
		},
		error:function(e){
			console.log(e);
		}			
	});
}
</script>
</html>