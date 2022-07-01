<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보상세보기(회원)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/myInfo.css">
<link rel="icon" href="resources/img/favicon.png">
<style>
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="../../commons/header.jsp"/>
	</div>
	<hr style="height: 1px !important; background:#333; display: block !important; width: 100% !important; margin:0;"/>
	<div class="body">
	    <div class="myPageTab" id="myPage_menu">
	        <h3>마이페이지</h3>
	        <hr style="border:1px solid #333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="/brwHistory">도서내역</a><br/>
	        <br/>
	        <a href="claimList">건의사항</a><br/>
	        <br/>
	        <a class="tabSelect" href="myUpdateDetail.go">회원정보</a>
	    </div>
	    <div class="info-area">
		  <form action="myUpdate" method="post">
		 	<table class="bbs">
	            <tr>
	                <th class="memberDetailTh">ID</th>
	                <td><input type="hidden" name="mb_id" id="mb_id" value="${sessionScope.loginId }">${sessionScope.loginId }</td>
	            </tr>
	            <tr>
	                <th>PW</th>
	                <td>
	                    <input type="text" name="mb_pw" value="">
	                      ※ 4자리 이상,비밀번호 수정시에만 작성
	                </td>
	            </tr>
	            <tr>
	                <th>이름</th>
	                <td><input type="text" name="name" value="${myUpdateDetail.name}"></td>
	            </tr>
	            <tr>
	                <th>전화번호</th>
	                <td>
	                    <input type="text" name="phone" value="${myUpdateDetail.phone}">
	                    ※ ‘-’ 를 제외하고 입력
	                </td>
	            </tr>
	            <tr>
	                <th>이메일</th>
	                <td>${myUpdateDetail.email }</td>
	            </tr>
	            <tr>
	                <th>회원탈퇴신청</th>
	                <td>
	                <div>
	                <input type="checkbox" id="chk"  name="secession"  <c:if test = "${myUpdateDetail.mb_status eq '탈퇴신청' || myUpdateDetail.mb_status eq '탈퇴완료'}"> checked </c:if> value="true" />
	                <input type="hidden" id="chk" name="secession" value="false" />
	                    ※ 체크하신 후 수정버튼을 누르시면 탈퇴신청이 접수됩니다.<br/>
	                    (신청일 포함 7일 동안 체크해제를 하지 않으셨다면 탈퇴처리가 완료됩니다.)
	                 </div>                
	                </td>
	            </tr>
	        </table>
	
	        <br/>
	
	        <table class = bbw>
	            <tr>
	                <th>기존 PW 확인</th>
	                <td><input type="password" name="pw_chk" value="">
	                <input type="hidden" name="Oripw_chk" value="${myUpdateDetail.mb_pw}" /></td>
	            </tr>
	        </table>
		        <div class="memberDetailBtn-area">
		        <input class="memberDetailUpdateBtn" type="submit" value="수정" >
		        </div>
	        </form>
	     </div>
     </div>
</body>
<script>
	var msg = "${msg}";
	if(msg != "") {
	alert(msg);
	}
	
	
	$(document).ready(function(){    
		
	
	if(!$("#chk").val("true")) {
		$("#chk").prop("checked" , false);
	}
		
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
			    $(this).val("false");
			}  
				  
		});
	
	});
	

	
	
</script>
</html>