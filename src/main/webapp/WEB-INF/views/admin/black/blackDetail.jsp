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
            <td><input type="checkbox" name="cancel" value="cancel"/></td>
        </tr>
        <tr>
            <th>해제사유</th>
            <td><input type="text" name="reason" value=""/></td>
        </tr>
    </table>
    <div>
        <button onclick="location.href='blackList.do'">돌아가기</button>
        <button type=button onclick="blackCancel()">수정</button>
    </div>
</body>
<script>
	function blackCancel(){
		 var chk=[];
	    console.log( '체크박스 값 : '+$(":input:checkbox[name=cancel]:checked").val() );
	 
	    $("input[name=cancel]:checked").each(function() { 
	        chk.push($(this).val());
	    });
	    
	    console.log('chk 값 :'+chk);
	    
        $.ajax({
        	type:'post',
        	url:'blackCancel.ajax',
        	data:{cn:chk},
        	dataType:'json',
        	success:function(data){
        		console.log(data);
        	},
        	error:function(e){
        		console.log(e);
        	}
        });
	 
	}
</script>
</html>