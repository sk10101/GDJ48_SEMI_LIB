<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>대출내역(관리자)</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/frame.css">
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
	        <a class="tabSelect" href="memberList.go">회원관리</a><br/>
	        <br/>
	        <a href="bookList.go">도서관리</a><br/>
	        <br/>
	        <a href="adminClaimList">건의사항</a><br/>
	        <br/>
	        <a href="blackList.go">블랙리스트</a><br/>
	        <br/>
	        <a href="penaltyList.go">이용정지내역</a>
	    </div>
	<section>
		<h3>대출내역</h3>
		<ul class="book_menu">
			<li><a href="/memberBrw.go?mb_id=${param.mb_id}">대출내역</a></li>
			<li><a href="/memberHis.go?mb_id=${param.mb_id}">이전 대출내역</a></li>
			<li><a href=" /memberReserve.go?mb_id=${param.mb_id}">예약내역</a></li>
			<li>회원 ID : ${param.mb_id}</li>
		</ul>
	    <table class="brw_table">
	        <thead>
	            <tr>
	                <td>대출번호</td>          
	                <td>도서제목</td>           
	                <td>대출일</td>           
	                <td>반납예정일</td>           
	                <td>연장여부</td>
	            </tr>
	        </thead>
	        <tbody id="list">

			</tbody>
	    </table>
	</section>
	</div>
</body>
<script>

var msg ="${msg}";

if (msg != "") {
	alert(msg);
}


var mb_id=$('#mb_id').html();
console.log(mb_id);

listCall();

function listCall() {
	$.ajax({
		type:'get',
		url:'memberBrw.ajax',
		data: {
			mb_id:mb_id
		},
		dataType:'json',
		success:function(data){
			console.log("테이블")
			drawList(data.list);
			console.log(data.list);
		},
		error:function(error){
			console.log(error);
		}
	});
}

function drawList(brwList) {
	var content='';
	console.log("brwList");
	brwList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>' +item.brw_id+ '</td>';
		content += '<td><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
		content += '<td>' +item.brw_date+ '</td>';
		content += '<td>'+item.return_date+'</td>';
		content += '<td>';
			if(item.renew==true) {
				content += 'Y';
			}else{
				content += 'N';
			}
		content += '</td>';
		content += '</tr>';
	});
	$('#list').append(content);
}
</script>
</html>