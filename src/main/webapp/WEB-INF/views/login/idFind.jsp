<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<h3>ID 찾기</h3>
<table>
	<tr>Email </tr>
	<input type="email" id = "email"  placeholder="Email"/>
	<input type="button" value="아이디 찾기" onclick="idFind()"/>
	
</table>
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