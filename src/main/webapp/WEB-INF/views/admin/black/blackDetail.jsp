<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
<link rel="stylesheet" href="resources/css/blackMember.css">
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
	        <h3>관리자 페이지</h3>
	        <hr style="height: 1px !important; background:#333; display: block !important; width: 140px !important; margin:10px 5px 20px 5px;"/>
	        <a href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a class="tabSelect" href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
	    <div class="section">
	    	<div class="title-area">
	   <h3>블랙리스트 회원 상세보기</h3>
	    </div>
	   <div class="info-area">
	   <form action="blackUpdate.do" method="post">
	   <input type ="hidden" id ="black_id" name = "black_id" value = "${param.black_id}"/>
	    	<table class="bbs">
		        <tr>
		            <th class="blackDetailTh">회원ID</th>
		            <td>${dto.mb_id }</td>
		        </tr>
		        <tr>
		            <th>이름</th>
		            <td>${dto.name }</td>
		        </tr>
		        <tr>
		            <th>관리자ID</th>
		            <td>${dto.admin_start }</td>
		        </tr>
		        <tr>
		            <th>지정일자</th>
		            <td>${dto.black_start }</td>
		        </tr>
		        <tr>
		            <th>지정사유</th>
		            <td>${dto.black_reason }</td>
		        </tr>
		        <tr>
		            <th>해제</th>
		            <td> <input type="checkbox" id='black_cancel' name="black_cancel"<c:if test = "${dto.black_cancel}"> checked </c:if> value="true"/>
		        </tr>
		        <tr>
		            <th>해제사유</th>
		             <td><input type="text" id="clear" name="clear" <c:if test="${dto.end_reason eq '' || dto.end_reason eq null}">
		           
		             </c:if> 
		             value="${dto.end_reason} "/></td>
		         </tr>

		    </table>
		    </form>
		
			    <div class="blackDetailBtn-area"> 
			        <input type="button" value="돌아가기" onclick="location.href='blackList.go'"/>
			        <input type="button"  onclick="update();return false;" value="수정"/>
			    </div>
		    </div>
	    </div>
    </div>
</body>
<script>
/* if(id== ""|| id == null){
    alert("아이디를 입력해주세요");
    return false; 
 }*/
 
 function update(){
	var form = document.getElementById("form");
	var id = document.getElementById("clear");  
	const checkbox = document.getElementById('black_cancel');
	// 2. checked 속성을 체크합니다.
	const is_checked = checkbox.checked;
	if(is_checked){
		var blank_pattern = /^\s+|\s+$/g;
		if(id.value == null || id.value == "" || id.value.replace(blank_pattern, '' ) == "" ){
			alert("해제사유를 입력해주세요.");
			return false;
		}
	}else{
		id.value = "";	
	}  
	form.submit();
 }
 
 var msg = "${msg}";
   if(msg != ""){
      alert(msg);
   }
   
   
   
</script>
</html>