<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	
		<table>
			<tr>
			<td>ID</td>
			<th><input type="text" id="id"/></th>
			</tr>
			<tr>
			<td>EMAIL</td>
			<th><input type="email" id="email"/></th>
			</tr>
			<tr>
			<!-- <td>새비밀번호</td>
			<th><input type="text" pw="pw"/></th> -->
			</tr>
			<tr>
			<th colspan="2">
			<input type="button" value="비밀번호 찾기" onclick="pwFind()"/>
			<input type="button" value="돌아가기" onclick="location.href='/lib/member/login'"/>
			</th>
			</tr>
		</table>
	
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
				 location.href="/lib/member/login"
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