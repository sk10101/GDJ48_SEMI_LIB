<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	  		h3 {text-align: left; font-weight: bold; font-size: 40px;}
            table {width: 40%}
            table, th, td {border: 1px solid black; border-collapse: collapse;}
            th, td{padding: 5px 10px; text-align: center;}
            textarea {width: 50%; height : 30px; resize: none; float:left;}
</style>
</head>
<body>
	  <h3>${sessionScope.loginId }님의 상세 정보</h3>
	  <form action="myUpdate" method="post">
	 <table>
            <tr>
                <th>ID</th>
                <td><input type="hidden" name="mb_id" value="${myUpdateDetail.mb_id}">${myUpdateDetail.mb_id}</td>
            </tr>
            <tr>
                <th>PW</th>
                <td>
                    <textarea name="mb_pw" value="${myUpdateDetail.mb_pw}"></textarea>
                      ※ 4자리 이상,비밀번호 수정시에만 작성
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td><textarea name="name" value="${myUpdateDetail.name}">${myUpdateDetail.name}</textarea></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    <textarea name="phone" value="${myUpdateDetail.phone}">${myUpdateDetail.phone}</textarea>
                    ※ ‘-’ 를 제외하고 입력
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${myUpdateDetail.email }</td>
            </tr>
            <tr>
                <th>회원탈퇴신청</th>
                <td><input type="checkbox" id="chk"  onclick="">
                    ※ 체크하신 후 수정버튼을 누르시면 탈퇴신청이 접수됩니다.<br/>
                    (신청일 포함 7일 동안 체크해제를 하지 않으셨다면 탈퇴처리가 완료됩니다.)                    
                </td>
            </tr>
        </table>

        <br/>

        <table>
            <tr>
                <th>PW 확인</th>
                <td><textarea name="pw_chk" value=""></textarea>
                <input type="hidden" name="Oripw_chk" value="${myUpdateDetail.mb_pw}" /></td>
            </tr>
        </table>

        <br/>
        <input type="submit" value="수정" id="myUpdateButton">
        </form>
</body>
<script>
	var msg = "${msg}";
	if(msg != "") {
	alert(msg);
	}
	
	
	$(document).ready(function(){    
		
		$("#chk").change(function(){       
			
			 if($("#chk").is(":checked")){           
				
				if(confirm("※ 정말로 탈퇴 하시겠습니까?  ") == true){
					alert ("회원탈퇴는 신청후 7일뒤 처리 됩니다. 회원탈퇴 처리가 완료되면 해당 아이디는 재사용이 불가 합니다. ");
					
				} else {
					$("#chk").prop("checked" , false);
					return ;
				}
				  
			}else{            
				alert("회원 탈퇴가 취소 되었습니다.");
				        
			}  
				  
		});
	
	});
	
	$('#myUpdateButton').on("click", function() {
		mySecession();
	});
	
	
	function mySecession() {
		
		if("#chk").prop("checked", false) {
		
			/*
			$.ajax({
				type : 'POST',
				url: '/CancelMySecession.ajax',
				data : {},
				dataType : 'JSON',
				success: function(data) {
					console.log(data);
				},
				error: function(e) {
					console.log(e);
				}
				
			});
			
			*/
			
		}
		
		else {
			
			/*
			
			$.ajax({
				type: 'POST',
				url: '/MySecession.ajax',
				data : {},
				dataType : {},
				success: function(data) {
					console.log(data);		
				},
				error: function(e) {
					console.log(e);
				}
				
			});
			
			*/
		
		}
				
		
	}
	
	
</script>
</html>