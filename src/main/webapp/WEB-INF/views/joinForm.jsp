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
<style>
*{margin: 0; box-sizing: border-box;}
* {
 
  font-family: 'Noto Sans KR', sans-serif;
  border-radius: 5px;
}
 
body {
  margin: 0;
  
}
 
.login-form {
    width: min-content;
    background-color: #EEEFF1;
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
  border: none;
  padding: 10px;
  width: 125px;
  background-color: #46c148;
  margin-bottom: 30px;
  color: black;
}
 h3{
    text-align: center;
 }


</style>
<body>
    <h3>회원가입</h3>
	<div class="login-form">
		<table>
           
            
			<tr>
				<th colspan="1">ID</th>
				<td><input class="text-field" type="text"  id="id" placeholder="id"/>
				<button onclick="overaly()">아이디 중복 체크</button>
			</tr>
			<tr>
				<th>PW</th>
				<td><input  class="text-field" type="text" id="pw" placeholder="pw"/></td>
			</tr>
			<tr>
				<th>NAME</th>
				<td><input class="text-field" type="text" id="name" placeholder="name"/></td>
			</tr>
			<tr>
				<th>PHONE</th>
				<td><input class="text-field" type="text" id="phone" placeholder="phone"/></td>
			</tr>
			<tr>
				<th colspan="1">EMAIL</th>
				<td><input class="text-field" type="text" id="email" placeholder="email"/>
				<button onclick="overalys()">이메일 중복 체크</button>
				<br>
            <br>
				</th>
			</tr>
            
			<tr>
				<th colspan="2">
					<input class="submit-btn" type="button" value="회원가입" onclick="join()"/>
					<input class="submit-btn" type="button" value="돌아가기" onclick="location.href='/lib/member/login'"/>
				</th>
			</tr>
		</table>
    </div>
	
	
</body>
<script>
	/* function joinFinish(){
	    const regExp = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g; 
	    if(!regExp.test($("#id"))){
	    	alert("아이디는 한글로 입력 가능합니다.");
	    	$("#id").fouce();	    	
	    	return false;
	    } 
	    
	    
	   
	    document.getElementById('join').submit(); 
	} */ 
	
	
	
	 /* const idCheck = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g; 
    if(!idCheck.test($("#id"))){
   	alert("아이디는 한글이 불가능합니다.");
   	return false; 
   }  */
	
	
	
	var overChkId = false; // 중복체크 여부

	function overaly(){
		var id = $("#id").val();
		var idChk = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g; 
		console.log('아이디 중복 체크 : '+id);		
		$.ajax({
			type:'get',
			url:'overaly.ajax',
			data:{chkId:id},
			dataType:'JSON',
			success:function(data){
				//console.log(data);
				if(!idChk.test($("#id"))){
				   	alert("아이디는 한글이 불가능합니다.");
				   	
				   } 
				
				else if(data.overlay){
					alert("이미 사용중인 아이디 입니다.");
				}else{
					alert("사용 가능한 아이디 입니다.");
					overChkId = true;
				}
			},
			error:function(e){
				console.log(e);
			}			
		});
	}
	
	
	var overChkEmail = false; // 중복체크 여부

	function overalys(){
		var email = $("#email").val();
		console.log('이메일 중복 체크 : '+email);		
		$.ajax({
			type:'get',
			url:'overalys.ajax',
			data:{chkEmail:email},
			dataType:'JSON',
			success:function(data){
				//console.log(data);
				if(data.overlays){
					alert("이미 사용중인 이메일 입니다.");
				}else{
					alert("사용 가능한 이메일 입니다.");
					overChkEmail = true;
				}
			},
			error:function(e){
				console.log(e);
			}			
		});
	}
	
	

	
	function join(){
		console.log('회원가입');
		var id = $('#id');
		var pw = $('#pw');
		var name = $('#name');
		var phone = $('#phone');
		var email = $('#email');
		 /* const idCheck = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g; 
	     if(!idCheck.test($("#id"))){
	    	alert("아이디는 한글이 불가능합니다.");
	    	return false; 
	    }  */
	    
	    var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{4,8}$/;
	   
	    var reg = /^[0-9]+/g;
		
	    if(overChkId && overChkEmail){
			
			 if(id.val() == ""){
				alert("아이디를 입력해 주세요!");
				
				$id.focus();
			}else if(pw.val() == ""){
				alert("비밀번호를 입력해 주세요!");
				pw.focus();
			}else if(!pwdCheck.test($("#pw"))) {
			    alert("비밀번호는 영문자+숫자+특수문자 조합으로 4~8자리 사용해야 합니다.");
			    pwd.focus();
			    return false;
			  }
			
			else if(name.val() == ""){
				alert("이름을 입력해 주세요!");
				name.focus();
			} else if(phone.val() == ""){
				alert("번호를 입력해 주세요!");
				phone.focus();
				
			}else if(!reg.test($("#phone"))){
				alert("전화번호는 숫자만 입력할 수 있습니다.");
				phone.focus();
			    return false;
			}
			
			else if(email.val() == ""){
				alert("이메일을 입력해 주세요!");
				email.focus();
			}else{
				console.log("회원 가입 요청");
				
				$.ajax({
					type:'post',
					url:'join.ajax',
					data:{
						id:id.val(),
						pw:pw.val(),
						name:name.val(),
						phone:phone.val(),
						email:email.val()
					},
					dataType:'JSON',
					success:function(data){
						console.log(data);
						
						if(data.success){
							alert("회원가입에 성공 했습니다.");
							location.href='/main';
						}else{
							alert("회원가입에 실패 했습니다.");
						}
						
					},
					error:function(e){
						console.log(e);
						alert("회원가입에 실패 했습니다.");
					}
				});
				
			}			
		}else{
			if(!overChkId){
				alert("아이디 중복체크를 진행해 주세요");
				id.focus();	
			}else{
				alert("이메일 중복체크를 진행해 주세요");
				email.focus();
			}
			
		}		
	}
	
</script>

</html>