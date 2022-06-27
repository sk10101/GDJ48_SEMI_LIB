<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    .detail {
        right: 0;
    }
    table.bbs {
		width: 50%;
	}
	table, th, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td {
		padding: 10px 10px;
	}
	textarea {
		width: 100%;
		height: 150px;
		resize: none;
	}
    a:link {
        text-decoration: none;
    }
</style>
</head>
<body>
	<h3>블랙리스트 회원 상세보기</h3>
	<form action="blackUpdate.do" id="form" method="post">
	<input type ="hidden" id ="black_id" name = "black_id" value = "${param.black_id}"/>
    <br/>
    <table class="bbs">
        <tr>
            <th>회원ID</th>
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
             <td><input type="text" id="clear" name="clear" value="${dto.end_reason} "/></td>
         
 </tr>
        
    </table>
    <div> 
        <input type="button" value="돌아가기" onclick="location.href='blackList.do'"/>
        <input type="button"  onclick="update();return false;" value="수정"/>
    </div>
    </form>
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