<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../resources/css/admin.css">
<style>
</style>
</head>
<body>
    <header>
        <div class="header-wrap">
            <div class="logo">
                <a href="/"><img src="../resources/img/logo.png" class="logo"></a>
            </div>
            <nav>
                <ul class="navi">
                    <li>***님 환영합니다.</li>
                    <li><a href="#">로그아웃</a></li>
                    <li><a href="#">관리자페이지</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <aside id="menu">
        <h1>관리자페이지</h1>
        <hr/>
        <ul class="admin_menu">
            <li><a href="#">회원관리</a></li>
            <li><a href="#">도서관리</a></li>
            <li><a href="#">건의사항</a></li>
            <li><a href="#">블랙리스트</a></li>
            <li><a href="#">이용정지내역</a></li>
        </ul>
    </aside>
	<section>
		<h3>대출내역</h3>
		<ul class="book_menu">
			<li><a href="#">대출내역</a></li>
			<li><a href="brwHis()">이전 대출내역</a></li>
			<li><a href="reserveList()">예약내역</a></li>
			<li id="mb_id"></li>
		</ul>
	    <table class="brw_table">
	        <thead>
	            <tr>
	                <td>대출번호</td>          
	                <td>도서제목</td>           
	                <td>대출일</td>           
	                <td>반납예정일</td>       
	                <td>대출상태</td>      
	                <td>연장여부</td>
	            </tr>
	        </thead>
	        <tbody id="list">

			</tbody>
	    </table>
	</section>
</body>
<script>
listCall();

function listCall() {
	$.ajax({
		type:'get',
		url:'memberBrw.ajax',
		data: {},
		dataType:'json',
		success:function(data){
			drawList(data.list);
		},
		error:function(error){
			console.log(error);
		}
	});
}

function drawList(brwList) {
	var content='';
	brwList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>' +item.brw_id+ '</td>';
		content += '<td><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
		content += '<td>' +item.brw_date+ '</td>';
		content += '<td>'+item.return_date+'</td>';
		content += '<td>'+item.brw_status+'</td>';
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

function brwHis(hisList){
	var content='';
	hisList.forEach(function(item){
		console.log(item);
		content += '<tr>';
		content += '<td>' +item.brw_id+ '</td>';
		content += '<td><a href="bookDetail.do?b_id='+item.b_id+' ">' +item.b_title+'</a></td>';
		content += '<td>' +item.brw_date+ '</td>';
		content += '<td>';		
	}
	$('#list').empty();
	$('#list').append(content);
}

</script>
</html>