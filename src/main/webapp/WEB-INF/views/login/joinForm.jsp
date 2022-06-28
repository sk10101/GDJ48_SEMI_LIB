<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/login.css">
<link rel="icon" href="../resources/img/favicon.png">
</head>
<style>
</style>
<body>
    <h3 id="title">회원가입</h3>
	<div class="join-form">
		<table>
			<tr>
				<th class="col1">ID</th>
				<td class="col2"><input class="joinInput" type="text"  id="joinId"/></td>
				<td class="col3"><button class="chkBtn" onclick="overaly()">중복 확인</button></td>
			</tr>
			<tr>
				<th class="col1">PW</th>
				<td class="col2"><input class="joinInput" type="text" id="joinPw"/></td>
				<td class="col3">※ 4글자 이상 (한글 제외)</td>
			</tr>
			<tr>
				<th class="col1">이름</th>
				<td class="col2"><input class="joinInput" type="text" id="joinName"/></td>
			</tr>
			<tr>
				<th class="col1">전화번호</th>
				<td class="col2"><input class="joinInput" type="text" id="joinPhone"/></td>
				<td class="col3">※ 숫자만 입력하세요.</td>
			</tr>
			<tr>
				<th class="col1">이메일</th>
				<td class="col2"><input class="joinInput" type="text" id="email"/></td>
				<td class="col3"><button class="chkBtn" onclick="overalys()">중복 확인</button></td>
			</tr>
		</table>
		<div class="joinBtn-area">
			<input class="submit-btn" type="button" value="회원가입" onclick="join()"/>
			<input class="submit-btn" type="button" value="돌아가기" onclick="location.href='/member/login'"/>
		</div>
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
	      if(idChk.test($("#id").val())){
	          alert("아이디는 한글이 불가능합니다.");
	          return false; 
	       }
	      
	      if(id== ""|| id == null){
	         alert("아이디를 입력해주세요");
	         return false;
	      }
		console.log('아이디 중복 체크 : '+id);		
		$.ajax({
			type:'get',
			url:'overaly.ajax',
			data:{chkId:id},
			dataType:'JSON',
			success:function(data){
				//console.log(data);
			 if(data.overlay){
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
		 if(email== ""|| email == null){
	         alert("이메일을 입력해주세요");
	         return false;
	      }
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
	    
	    var pwdCheck = /^(?=.*[a-zA-Z]).{4,50}$/; 
	   
	    var reg = /^[0-9]+/g;
		
	    if(overChkId && overChkEmail){
			
			 if(id.val() == ""){
				alert("아이디를 입력해 주세요!");
				
				$id.focus();
			}else if(pw.val() == ""){
				alert("비밀번호를 입력해 주세요!");
				pw.focus();
			} else if(!pwdCheck.test($("#pw").val())) {
			    alert("비밀번호는 한글을 제외한 4자리 이상이어야 합니다.");
			    pwd.focus();
			    return false;
			  }  /* else if(pw.val().length <= 4){
				  alert("비밀번호는 4자 이상입니다.")
			  } */
			
			else if(name.val() == ""){
				alert("이름을 입력해 주세요!");
				name.focus();
			} else if(phone.val() == ""){
				alert("번호를 입력해 주세요!");
				phone.focus();
				
			} else if(!reg.test($("#phone").val())){
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
							location.href='/member/login';
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